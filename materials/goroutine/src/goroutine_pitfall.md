# よくハマる goroutine の落とし穴

* goroutine は便利だが落とし穴もある
* 頻発する落とし穴の例を紹介

## 罠の例 (1) goroutine と for ループ

* goroutine を使って配列の中身をダンプしてみることにした
* 以下を実行するとどうなるでしょうか [(playground)](https://play.golang.org/p/Pbw1Fwa01bX)

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	ints := []int{1, 2, 3, 4, 5, 6} // ダンプしたい配列
	for _, n := range ints {
		go func() {
			fmt.Println(n)
		}()
	}

	time.Sleep(3 * time.Second) // 十分に待っているとする
}
```

* なんか 6 ばっかり出たんですけど
  * goroutine に処理が切り替わるのは、for ループが終わった後
  * for ループが終わった段階で n を参照すると、ループの最後の数字が入っている
  * goroutine の処理はいつ始まるか分からないし、何なら順序の保証もないと考えておく

### 修正案: goroutine に引数を渡す

* 逐一 goroutine に引数として渡せば OK [(playground)](https://play.golang.org/p/pFj7nrbcWGQ)

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	ints := []int{1, 2, 3, 4, 5, 6}
	for _, n := range ints {
		go func(i int) { // goroutine が引数をとるように変更
			fmt.Println(i) // 渡ってきた引数を表示する
		}(n)
	}

	time.Sleep(3 * time.Second) // 十分に待っているとする
}
```

## 罠の例 (2) WaitGroup してるのに？

* WaitGroup を使って待ち合わせをする例
* 以下を実行するとどうなるでしょうか [(playground)](https://play.golang.org/p/PXfQe6ej6Go)

```go
package main

import (
	"fmt"
	"sync"
)

func main() {
	wg := sync.WaitGroup{}
	go func(s string) {
		wg.Add(1) // 内部カウンタを 1 増やす
		fmt.Println(s)
		wg.Done() // 内部カウンタを 1 減らす
	}("hello world!")
	wg.Wait() // 内部カウンタが 0 になるまで待つ
}
```

* 何も表示されない…？
  * 割とやりがち
  * goroutine の中で `wg.Add(1)` するのは誤り
  * 結局 goroutine が始まる前にこのプログラムは終わる

### 修正案: goroutine の外で `wg.Add(1)` する

* goroutine の手前で `wg.Add(1)` する

```go
package main

import (
	"fmt"
	"sync"
)

func main() {
	wg := sync.WaitGroup{}
	wg.Add(1) // 内部カウンタを 1 増やす
	go func(s string) {
		fmt.Println(s)
		wg.Done() // 内部カウンタを 1 減らす
	}("hello world!")
	wg.Wait() // 内部カウンタが 0 になるまで待つ
}
```
