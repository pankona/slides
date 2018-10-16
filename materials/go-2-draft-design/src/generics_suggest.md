# Go 2 Draft Design における Generics に対する提案

Generics に関する Draft Design (原文) は[こちら](https://go.googlesource.com/proposal/+/master/design/go2draft-contracts.md)

以下、内容の解説

- Generic な「型」の定義

```go
// 任意の型 T の配列を生成するための型
type List(type T) []T

// 実際使うときはこんな感じ
// 型引数として int を渡す例
var ints List(int)
```

- Generic な「関数」の定義

```go
// map の key だけ抜き出して配列に変換する関数
// map の key と value が任意の型を指定できる
func Keys(type K, V)(m map[K]V) []K { /* ... */ }

// 型引数として int と string を渡す
m := map[int]string{
	1: "one",
	2: "two",
}
keys := Keys(int, string)(m) // [1, 2]
```

- **contract** による型パラメータへの制約
  - 任意とは言うけれど、何らかの制約を与えたい場合に用いる
  - 数値として比較が可能なもののみ指定可能
  - 加算が可能なもののみ指定可能
  - 特定のメソッドが生えているもののみ指定が可能、等…

```go
contract Equal(t T) {
	t == t // == できるかどうかをコンパイル時に判断する
}

// 重複なし配列の Set
type Set(type T Equal) []T

// Set の中から指定された値を探して index を返す関数
func (s Set(T)) Find(x T) int {
	for i ,v := range s {
		// ここで == を使う。contract がないとエラーになる
		if v == x {
			return i
		}
	}
	return -1
}
```

もう少し contract の例。

```go
contract Addable(t T) {
	t + t
	// + の演算ができるということは、数値か string のみという意味
	// なお Go は演算子のオーバーロードができない
}
```

```go
// Addable を使った例
func Sum(type T Addable)(x []T) T {
    var total T
    for _, v := range x {
        total += v
    }
    return total
}

func main() {
	var x []int
	total := Sum(int)(x)
}
```

色んな contract があり得る。

```go
// 1000 を入れられて、加算が可能 (int8 はダメ)
contract add1K(x T) {
	x = 1000
	x + x
}

// String() が使える
contract stringer(x T) {
	var s string = x.String()
}

// ポインター
contract ptr(x T) {
	*x
}

// フィールド
contract hasFooAsField(x T) {
	x.Foo = x.Foo
	// 単に x.Foo ではメソッドを含むので期待通りでない
}

// メソッド
contract hasFooAsMethod(x T) {
	var _ interface {
		String()
	} = x
	// 単に x.Foo() ではフィールドを含むので期待通りではない
}
```

他にも色々 ([tenntenn さんの Gist](https://gist.github.com/tenntenn/3049e06b301b1d7df952d41b12bef7d8)) あるので興味があれば参考されたし。

## contract に対する巷の所感

- 期待したどおりの contract が書けているか検証が難しそう
  - 容易に抜けや漏れが発生する気がする
  - contract 内ではたぶん IDE のサポートを受けられない
  - ほとんどクイズ

## Generics 全体的を通しての巷 (ちまた) の反応

- [Go 2 Generics Feedback (GitHub Wiki)](https://github.com/golang/go/wiki/Go2GenericsFeedback)
  - 赤塚が見る限りにおいては、やはり割と冷ややか
  - contract が難しすぎるという話。これが前提なら Generics いらんやろという意見も。
  - contract は標準ライブラリから提供してもらって、一般人が書かないような状況なら良い、みたいな意見も。
  - 括弧が多くて気持ち悪いので要らない派
