# channel による通信

* Go 言語には **channel** という機能があり、goroutine 間の通信にしばしば用いられる。

## channel とは？

* _Channels are a typed conduit through which you can send and receive values with the channel operator, <-_ ([Tour of Go - Channels](https://tour.golang.org/concurrency/2) より抜粋)
  * channel operator `<-` を使って値を送ったり受けとったりできる。
  * [Go by Example: Channels (公式の解説ページ)](https://gobyexample.com/channels)
* キュー構造 (FIFO) をしている。バッファ (容量) を任意に設定できる。
* **channel への書き込みは自動的に排他制御される。**

### channel を使ったコード例

* Go by Example から抜粋 [(playground)](https://play.golang.org/p/jkKaMWFUEyg)
  * channel から読み込むとき、書き込みがあるまで待っててくれる
  * channel に書き込むとき、バッファがいっぱいだったら空くまで待っててくれる

```go
package main

import "fmt"

func main() {
	messages := make(chan string) // channel を作る

	go func() {
		messages <- "ping" // channel に書き込む
	}()

	msg := <-messages // channel から読み込む

	fmt.Println(msg)
}
```

* 複数の goroutine に channel を渡して通信する [(playground)](https://play.golang.org/p/8_hI06R6VAu)
  * 勝手に排他制御が掛かるので便利

```go
package main

import (
	"fmt"
	"strconv"
)

// 送る側 (引数は書き込み専用 channel)
func send(ch chan<- string) {
	for i := 0; i < 10; i++ {
		ch <- strconv.Itoa(i)
	}
}

// 受け取る側 (引数は読み込み専用 channel)
func receive(ch <-chan string) {
	for i := 0; i < 10; i++ {
		fmt.Println(<-ch)
	}
}

func main() {
	ch := make(chan string)
	go send(ch)
	receive(ch)
}
```

## select を使って複数の channel を扱う

* 複数の channel を扱うときは select がしばしば用いられる。
  * 複数の channel を並べて、実行可能になった channel への操作をひとつだけ実行する
  * 以下の例はブロックしたまま動かないので注意 [(playground)](https://play.golang.org/p/NoyJw85_-Vl)

```go
package main

import "fmt"

func main() {
	// 3 つ channel 作って...
	ch1 := make(chan string)
	ch2 := make(chan string)
	ch3 := make(chan string)

	// select で channel を複数指定する
	// どれかが実行可能になるまで待っててくれる
	// 同時に複数の channel が実行可能になっても、実行されるのはひとつだけ
	select {
	case v := <-ch1:     // ch1 からの読み込み待ち
		fmt.Println(v)
	case v := <-ch2:     // ch2 からの読み込み待ち
		fmt.Println(v)
	case ch3 <- "hello": // ch3 への書き込み待ち
		fmt.Println("hello!")
	}
}
```

* 先述の例は一生動作しない (deadlock ということでただちに panic する)
  * default を用いると、全ての channel が操作不能でもブロックしない [(playground)](https://play.golang.org/p/leransKPFo_N)

```go
package main

import "fmt"

func main() {
	// 3 つ channel 作って...
	ch1 := make(chan string)
	ch2 := make(chan string)
	ch3 := make(chan string)

	// select で channel を複数指定する
	// どれかが実行可能になるまで待っててくれる
	// 同時に複数の channel が実行可能になっても、実行されるのはひとつだけ
	// default 書いておくと待たずにつるっと抜ける
	select {
	case v := <-ch1:     // ch1 からの読み込み待ち
		fmt.Println(v)
	case v := <-ch2:     // ch2 からの読み込み待ち
		fmt.Println(v)
	case ch3 <- "hello": // ch3 への書き込み待ち
		fmt.Println("hello!")
	default:
		fmt.Println("all channels are not available now")
	}
}
```

## 余談: context による goroutine の終了処理

* goroutine を goroutine の外側から強制的に終わらせることはできない
  * いわゆる pthread で言うところの cancel や kill がない
  * ということで、終わらせたかったら自力でちゃんと終わらせる必要がある
  * 以下、露骨に goroutine が残り続けてメモリが無駄に成る例 (goroutine leak) [(playground)](https://play.golang.org/p/XZCy1PoI_Ie)

```go
package main

import "fmt"

// 読み込み専用 channel を引数にとる関数
func receive(ch <-chan string) {
	fmt.Println(<-ch)
}

func main() {
	ch := make(chan string)

	// ここでたくさん goroutine を立てている、が、
	// 各々の goroutine 内では channel 書き込まれ待ちでブロックしている
	for i := 0; i < 1000000; i++ {
		go receive(ch)
	}
}
```

* goroutine を終わらせる方法のひとつとして、`context.Context` を用いる [(playground)](https://play.golang.org/p/8Ktmj7Q6vUs)
  * `context.WithCancel` を用いると、context インスタンスと cancel 用の関数が得られる
  * cancel 用の関数を呼び出すと、context インスタンスの `Done()` が発火する
  * `Done()` は channel を返す関数。select で待っといて終了処理を行うことができるようになる

```go
package main

import (
	"context"
	"fmt"
)

// 読み込み専用 channel に加えて、context を引数にとるようにした
func receive(ctx context.Context, ch <-chan string) {
	select {
	case <-ctx.Done(): // ctx の cancel 呼ばれ待ち
		return         // cancel 呼ばれたら関数を抜ける
	case v := <-ch:
		fmt.Println(v)
	}
}

func main() {
	// context インスタンスと cancel 用の関数を得る
	ctx, cancel := context.WithCancel(context.Background())
	ch := make(chan string)
	for i := 0; i < 1000000; i++ {
		go receive(ctx, ch) // 全部の goroutine に同じ ctx を渡す
	}
	cancel() // cancel を呼ぶと各々の receive に渡った ctx.Done() が発火する
}
```



