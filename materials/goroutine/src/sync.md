# 待ち合わせ処理

## 例(1)

* 以下を実行するとどうなるでしょうか [(playground)](https://play.golang.org/p/jNql-0StFgH)

```go
package main

import "fmt"

func main() {
	go func() {
		fmt.Println("Hello world!")
	}()
}
```

* 何も出ない…
  * goroutine が実行される前に `main` が終わっちゃうため
  * goroutine が終わるまで何らかの方法で**待つ**必要がある

### 修正案(1) 信頼と実績の Sleep

* goroutine の実行が終わるまで適当に sleep する [(playground)](https://play.golang.org/p/JM1SFoToHYo)

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	go func() {
		fmt.Println("Hello world!")
	}()
	time.Sleep(time.Second) // 1 秒待つ
}
```

* 1 秒は待ちすぎ？
* goroutine が終わったことを検知したい

### 修正案 (2) channel を使う

* 先述の `channel` を使っていくパターン [(playground)](https://play.golang.org/p/ND4CygMVqWo)
* `channel` の読み出し側が書き込みがあるまでブロッキングする性質を利用

```go
package main

import (
	"fmt"
)

func main() {
	c := make(chan struct{})
	go func() {
		fmt.Println("Hello world!")
		c <- struct{}{} // 処理の終了を channel への書き込みで知らせる
	}()
	<-c // channel に書き込みがあるまで待ってる
}
```
### 修正案 (3) `sync.WaitGroup` を使う

* `sync.WaitGroup` は待ち合わせをするための仕組み
* 複数の goroutine を待ち合わせたいときなんかはこれ

```go
package main

import (
	"fmt"
)

func main() {
	wg := sync.WaitGroup{}
	wg.Add(1) // 内部カウンタを 1 増やす
	go func() {
		fmt.Println("Hello world!")
		wg.Done() // 内部カウンタを 1 減らす
	}()
	wg.Wait() // 内部のカウンタが 0 になるまで待つ
}
```



