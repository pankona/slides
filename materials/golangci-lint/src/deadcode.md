# deadcode

Finds unused code

## 何をチェックしてくれる？

使ってないコードがあると怒ってくれる

```go
package main

import "fmt"

// 使ってない関数
func hoge() int {
	return 0
}

// 使ってない変数
var fuga int

func main() {
    fmt.Println("main")
}
```

## 僕の感想

- リファクタリングなどで不要になった関数をついうっかり消し忘れたりするのを防げる
- 先に関数だけ作っといてあとで呼び出す部分を作ろう、等と思った時に邪魔くさいことはある
