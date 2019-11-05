# ineffassign

Detects when assignments to existing variables are not used

## 何をチェックしてくれる？

変数に値を入れたけど使ってないときに怒ってくれる

```go
package main

func main() {
    a := 1
    fmt.Println(a)

    a = 2 // 代入したけど使ってないので怒られが発生する
}
```

## 僕の感想

- 完全に無駄な代入なんだけどしばしば書いちゃう気がする
- こういうのこそ機械的に発見できると嬉しくないですか
