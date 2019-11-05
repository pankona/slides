# gochecknoglobals

Checks that no globals are present in Go code

## 何をチェックしてくれる？

- package 内にグローバル変数があると怒ってくれる
- `const` 修飾子がついているもの (つまり定数) は許される

```go
package main


var x int // これは怒られる

func main() {
    fmt.Println(x)
}

```

## 僕の感想

結構邪魔くさくていつもオフにしてしまう。以下のような理由。

- グローバル変数に `const` をつけると指摘されなくなるが、Go ではすべての変数に `const` がつけられるわけではない
  - 構造体や `interface`、`map` や `slice` には `const` がつけられない
- 変数を package 外に公開するパターンが使えなくなる (`Error` を公開するパターンなど)
- 普段はまだしも、テストコードではしばしばグローバル変数は使われる
