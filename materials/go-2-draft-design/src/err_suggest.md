# Go 2 Draft Design におけるエラーハンドリングに対する提案

- 先程の例を再掲

```go
func CopyFile(dst, src string) error {
	r, err := os.Open(src)
	if err != nil {
		return fmt.Errorf("copy %s %s: %v", src, dst, err)
	}
	defer r.Close()

	w, err := os.Create(dst)
	if err != nil {
		return fmt.Errorf("copy %s %s: %v", src, dst, err)
	}

	_, err = io.Copy(w, r)
	if err != nil {
		w.Close()
		os.Remove(dst) // 失敗したときにファイルを消す
		return fmt.Errorf("copy %s %s: %v", src, dst, err)
	}

	err = w.Close()
	if err != nil {
		os.Remove(dst) // 失敗したときにファイルを消す
		return fmt.Errorf("copy %s %s: %v", src, dst, err)
	}
}
```

## check/handle

- check/handle という言語組み込みの機能を追加してエラーハンドリングを簡略化する案

```go
func CopyFile(dst, src string) error {
	handle err {
		return fmt.Errorf("copy %s %s: %v", src, dst, err)
	}

	r := check os.Open(src)
	defer r.Close()

	w := check os.Create(dst)
	handle err {
		w.Close()
		os.Remove(dst) // (only if a check fails)
	}

	check io.Copy(w, r)
	check w.Close()
	return nil
}
```

- いまのところの仕様案

  - `check` は `error` が返る関数に適用できる (戻り値がタプルでも可)
  - `check` を仕掛けたが `error` が返ってこなかったときは何も起こらない
  - `check` を仕掛けたところで `error` が返ってきたら、直近の `handle` に飛ぶ
  - `handle` は複数仕掛けることができる
    - 複数仕掛けられていたら全部実行される
    - 直近に仕掛けられたものから順番に呼び出される (つまりブロック内で記載とは逆順の評価)
    - レキシカルスコープが適用される
    - 必ずどこかで `return` しなければならない
  - handler の記載は省略可能。省略した場合は `return err` とみなされる。

- これにより、`if err != nil` を連発しなくて良くなるんじゃないかとされている

## いくらか例

- なんとなくいい感じに使えそうな例

```go
// 文字列を二個受け取り、各々を数値に変換して足し算した結果を返す
func printSum(a, b string) error {
	// strconv.Atoi の戻り値は (int, error)
	// 本来はこう書くところを…
	//
	// ai, err := strconv.Atoi(a)
	// if err != nil {
	//     return err
	// }
	// bi, err := strconv.Atoi(b)
	// if err != nil {
	//     return err
	// }
	//
	// fmt.Println("result:", a + b)

	// check/handle を使えば以下で済む
	fmt.Println("result:", check strconv.Atoi(a) + check strconv.Atoi(b))
	return nil
}
```

- chain する例
  - `handle` はレキシカルスコープなので、ループ毎に `handle` が蓄積していくわけではない
  - check 1 でエラーが発生した場合は、C、B、A の順番に `handler` が実行される
  - check 2 でエラーが発生した場合は、A の `handler` だけが実行される

```go
func process(user string, files chan string) (n int, err error) {
	// handler A
	handle err { return 0, fmt.Errorf("process: %v", err) }

	for i := 0; i < 3; i++ {
		// handler B
		handle err { err = fmt.Errorf("attempt %d: %v", i, err) }

		// handler C
		handle err { err = moreWrapping(err) }

		check do(something()) // check 1: handler chain C, B, A
	}

	check do(somethingElse) // check 2: handler chain A
}
```

- 以下は `defer` との組み合わせ例
  - `defer` は関数リターンに合わせて一回だけ呼び出す関数を指定できる機能
  - 以下の例では、handler が全部終わってエラー return が確定したあとに呼び出される

```go
type Error struct {
	Func string
	User string
	Path string
	Err  error
}

func (e *Error) Error() string {
	return e.Err.Error()
}

func ProcessFiles(user string, files chan string) error {
	e := Error{
		Func: "ProcessFile",
		User: user,
	}
	handle err { e.Err = err; return &e } // handler A

	u := check OpenUserInfo(user)         // check 1
	defer u.Close()

	for file := range files {
		handle err { e.Path = file }       // handler B
		check process(check os.Open(file)) // check 2
	}
	...
}
```

## 巷 (ちまた) の反応

- [Go2ErrorHandlingFeedback (GitHub Wiki)](https://github.com/golang/go/wiki/Go2ErrorHandlingFeedback)
- (赤塚が見る限りにおいては) 冷ややか寄りなのが多い気がする。無駄に複雑ではないかという意見が結構ある。
  - これだったら `if err != nil` 連打したほうが平和
  - `if err != nil` との混在を考えたらキツイ
  - default handler だけならまだいいかも
  - などなど…

## その他の細かい話

- `defer` の中で `check` できるようにするかどうかは検討中
- `check` というキーワードの代わりに `?` を使うのはどうかという案も

```go
// check/handle
check io.Copy(w, check newReader(foo))
```

```go
// ? を使う例
io.Copy(w, newReader(foo)?)?
```
