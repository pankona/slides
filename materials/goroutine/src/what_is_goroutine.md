# goroutine とは

* Go 言語の主たる言語機能のひとつとして **goroutine** がある。

## goroutine とは何か

* _A goroutine is a lightweight thread managed by Go runtime._ ([Tour of Go - concurrency](https://tour.golang.org/concurrency/1) より抜粋)
  * 軽量スレッドである。
  * キーワード `go` を伴って関数を呼び出すことで、指定の関数は goroutine 上で実行されるようになる。
  * [Go by Example: Goroutines (公式の解説ページ)](https://gobyexample.com/goroutines)

### goroutine を使ったコード例


* 下記は `say` 関数を goroutine 上で実行する例 [(playground)](https://play.golang.org/p/n8xaGOYM4X2)

```go
package main

import (
	"fmt"
	"time"
)

// 引数に指定された文字列を 100 ミリ秒間隔で 5 回 出力する関数
func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}

func main() {
	go say("world") // "go" をつけて関数を呼び出すと goroutine 上での実行になる
	say("hello") // こっちは "go" なしで実行
}
```

* 無名関数を実行することもできる
  * 以下の例は先述の例と同等の動き [(playground)](https://play.golang.org/p/VpjUWTiZGi9)

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	go func(s string) {
		for i := 0; i < 5; i++ {
			time.Sleep(100 * time.Millisecond)
			fmt.Println(s)
		}
	}("world")

	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println("hello")
	}
}
```

## goroutine の特徴

* 軽量スレッドであり、いわゆるプロセス、スレッドよりも省リソース。
  * スレッドは 1〜2 MB の初期スタックメモリを必要とするらしい。goroutine は 2 KB 程度。起動が速い。
* スレッドは CPU のコアにマッピングされるが、goroutine は OS のスレッドにマッピングされる。
  * スレッドへの CPU 処理時間割当のスケジューリングは OS の仕事。
  * goroutine への CPU 処理時間割当のスケジューリングは Go runtime の仕事。
  * つまり M:N モデル (OS のスレッド M 個に対し、goroutine は N 個)。

## 余談: スレッドの実行モデルの種類

* N:1
  * 1 個の OS スレッドの上で N 個のユーザー空間スレッドが動く
  * コンテキストスイッチが速いがマルチコアの恩恵を受けられない
* 1:1
  * 1 個の OS スレッドの上で 1 個のユーザー空間スレッドが動く
  * コンテキストスイッチが遅いがマルチコアの恩恵を受けられる
* M:N
  * M 個の OS スレッドの上で N 個のユーザー空間スレッドが動く
  * コンテキストスイッチが速い上にマルチコアの恩恵も受けられる
  * ただしスケジューラの扱いが煩雑
  * Go はこれ

## 参考

* [ホリネズミでもわかる Goroutine 入門](https://speakerdeck.com/morikuni/golang-dot-tokyo-number-14)
* [ASCII.jp: Go言語と並列処理(2) - Goならわかるシステムプログラミング](http://ascii.jp/elem/000/001/480/1480872/)
* [Go のスケジューラー実装とハマりポイント](https://talks.godoc.org/github.com/niconegoto/talks/concurrency.slide#1)
* [The Go scheduler - Morsing's Blog](https://morsmachine.dk/go-scheduler)
