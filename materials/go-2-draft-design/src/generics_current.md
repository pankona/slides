# 2018/10 現在の Go における Generics

- ポイント
  - Go は言語機能として Generics をサポートしていない
  - ので、似たような (void\* 的な) ものやコード生成でしのいでいる

## Generics の必要性

- 型に依存しない汎用的な処理 (関数) を作るために用いる
  - 任意の型の配列をソートする
  - 任意の数値っぽい型の大きい方 (もしくは小さい方) を返す
  - コレクションメソッドへの map、filter、reduce、join

## Go ではどうやるか

いくらか Generics のない Go における Generics がほしいときの対処方を紹介します。

### 愚直関数定義

例えばふたつの値をもらって大きい方を返す関数

```go
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
```

- 一件、良さそうであるが…？
  - Go には数値を表す型として `int`、`int32`、`int64`、`uint32`、`uint64`、`float32`、`float64` 等がある
  - 型が異なるので、場合によっては以下のような関数の羅列が必要になる (キャストで一部対応可能だが…？)

```go
func maxi(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxi32(a, b int32) int {
	if a > b {
		return a
	}
	return b
}

func maxi64(a, b int64) int {
	if a > b {
		return a
	}
	return b
}

func maxf32(a, b float32) int {
	if a > b {
		return a
	}
	return b
}

func maxf64(a, b float64) int {
	if a > b {
		return a
	}
	return b
}
```

### interface{}

interface{} は、C で言うところの void\* (よりもだいぶ便利だけど) と思えばだいたいイメージはつかめるかと思われる。

- interface{} を引数にとるような関数には、任意の型を突っ込むことができる
- interface{} の変数は、任意の型にキャスト (type assertion と呼ぶ) ができる
- **互換のない型に type assertion して何の対処もしないとクラッシュする**

```go
func main() {
	m := max(5, 10)
	fmt.Println(m.(int)) // 10
}

func max(a, b interface{}) interface{} {
	ai := a.(int)
	bi := b.(int)
	if ai > bi {
		return ai
	}
	return bi
}
```

- type assertion 時のクラッシュに対処を入れる場合

```go
func main() {
	m, ok := max(5, 10).(int)
	if ok {
		fmt.Println(m) // 10
	}
}

func max(a, b interface{}) interface{} {
	ai, ok := a.(int)
	if !ok {
		// error handling
	}
	bi, ok := b.(int)
	if !ok {
		// error handling
	}
	if ai > bi {
		return ai
	}
	return bi
}
```

- interface{} のつらいところ
  - どの型に type assertion すればよいかは、ドキュメントや実装を頼りに判断するしかない
  - できればこれくらいコンパイル時に解決しといてほしいと思うのが人情
  - これくらいの規模であれば人間にも対処可能だが、ちょっと手を抜くとカオス化してメンテが厳しくなっていく

### go generate

- Go には `go generate` というコード生成のためのサブコマンドが用意されている。
- 一応、テンプレート的なものを用意しておき、引数をあたえてコード生成する、みたいなことは可能だが…
  - 一般の Go のビルド手順から外れる (いつ go generate 叩けばいいのか分からない問題)
  - オレオレテンプレートが溢れる
  - 実はあんまり人気ない (僕は好きです)

## ところで Generics は何でないんだっけ？

- 結構昔から議論をしている。以下の記事は 2011 年に初出の割とガチな Generics の提案
  - https://github.com/golang/proposal/blob/master/design/15292-generics.md
- 別に Go のチームは「Generics が不要」とは言ってない
  - いまはもっとランタイムやライブラリの充実を優先している状況
  - 必要であれば入れる気はある
- そんな Go チームの傍ら、一般人の界隈で Generics いる派、いらない派が押し問答を繰り返す昨今
  - Generics 使わなくても平気だよ実装に問題ないよ派
  - Generics がない言語なんていまどきないよね笑っちゃうよ派
  - Generics がないと困る具体的なユースケース出してみろよ派
  - Generics がなくても困らないっていうのはすっぱい葡萄理論だろ派
  - 検索するとしょちゅう喧嘩してるのが垣間見えます。色んな意見があるので見てみるのも面白いかも。
- **公式からの Generics 提案で、ついに Go に Generics いるいらない議論に終止符が！？**
