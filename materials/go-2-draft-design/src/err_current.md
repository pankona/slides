# 現在の Go のエラーハンドリング

- **_ポイント_**
  - **_Go には try/catch のような「例外による大域脱出」が存在しない_**

例えば、以下のようなケースを考える (公式より抜粋してちょっと改変)。

```go
// ファイルをコピーする関数
func CopyFile(dst, src string) error {
	r := os.Open(src)
	defer r.Close()

	w := os.Create(dst)
	io.Copy(w, r)
	w.Close()
}
```

- 先述の関数は、ざっくり言えば、
  - `dst`、`src` はファイルパスで、
  - `src` に指定されたファイルを `dst` にコピーする。
- 先述の例は、**一切エラーハンドリングを行っていない状態**

さて、エラーハンドリングを追加すると…

```go
func CopyFile(dst, src string) error {
	r, err := os.Open(src) // 失敗したときに err を返す
	if err != nil {
		return err
	}
	defer r.Close()

	w, err := os.Create(dst) // 失敗したときに err を返す
	if err != nil {
		return err
	}
	defer w.Close()

	_, err = io.Copy(w, r) // io.Copy も失敗したら err を返す
	if err != nil {
		return err
	}

	err = w.Close() // w.Close も失敗したらエラーを返す
	if err := w.Close() {
		return err
	}
}
```

- 先述の関数もまだエラーハンドリングには抜かりがあり、
  - 作ったファイルをコピー失敗時に消していない
  - エラーの文脈がわからなくなる可能性

ということを踏まえてもう少し補うと…

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

- 以下のように修正
  - 処理失敗時にファイルを消す処理を追加
  - `fmt.Errorf` を使うことによってエラーに文脈を含めるように修正

## イヤだと言われるところ

- ひたすら `if err != nil` を連打しなければならず、冗長
