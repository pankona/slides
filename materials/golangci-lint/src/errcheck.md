# errcheck

Errcheck is a program for checking for unchecked errors in go programs. These unchecked errors can be critical bugs in some cases

## 何をチェックしてくれる？

`error` が返ってくる関数を呼び出したときにエラーハンドリングしてないと怒ってくれる

```go
package main

import (
	"errors"
)

func main() {
	hoge() // 戻ってきたエラーをチェックしていないので怒られる
}

func hoge() error {
	return errors.New("error from hoge")
}
```

## 僕の感想

- エラーハンドリング漏れがなくなるのでとにかく安心
- しばしば「あれ、この関数ってエラー返すんだ？」みたいな気付きにも繋がって便利である
