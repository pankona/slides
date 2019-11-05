# unparam

Reports unused function parameters

## 何をチェックしてくれる？

- 関数の引数の中に使われていないものがあったら怒ってくれる

```go
// 怒られが発生する関数のイメージ

// b が使われていないので怒られる
// return がいつも nil だから要らんやろって怒られる
func f(a, b int) error {
    fmt.Println(a)
    return nil
}

```

## 僕の感想

ありがたいけれども

- 関数の引数は互換性を考えると簡単に変えることができない場合がある
- 関数が誰にも使われていないうちはアリかも
