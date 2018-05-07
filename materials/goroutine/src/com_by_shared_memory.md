# 共有メモリによる通信

* 共有メモリを使うパターンはシンプル
* しかしデータの競合に気を使う必要がある

## 素朴な (しかし悪い) 例

* 何も考えずに共有メモリを使ってみたパターン
* 配列を goroutine 使ってじゃんじゃん伸ばしていきたいとする
* 以下を実行するとどうなるでしょうか [(playground)](https://play.golang.org/p/icEx7riw9ab)

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	ints := []int{} // goroutine 間で共有されるメモリ
	for i := 0; i < 10; i++ {
		go func(n int) {
			ints = append(ints, n) // 配列に新しい要素を入れて伸ばす
		}(i)
	}
	time.Sleep(time.Second) // goroutine が終わるの待つ
	fmt.Println(ints)
}
```

* (playground で動かすとうまく動いちゃう…)
* やるたびに結果が変わるはず 
  * 各 goroutine は `ints` を読み込んで新しい値を入れて上書きしようとする
  * 読み込んで上書きしようとする間に別の goroutine によって値が更新されてしまう

### 修正案 (1) sync.Mutex による排他制御

* 素朴に `sync.Mutex` を使って排他制御を行う
* とりあえずシンプルで悪くない (個人の感想です)

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	ints := []int{}    // goroutine 間で共有されるメモリ
	mu := sync.Mutex{} // ロック/アンロックのための Mutex
	for i := 0; i < 10; i++ {
		go func(n int) {
			mu.Lock()              // 共有メモリの読み書きをロック
			ints = append(ints, n) // 配列に新しい要素を入れて伸ばす
			mu.Unlock()            // 共有メモリの読み書きをアンロック
		}(i)
	}
	time.Sleep(time.Second) // goroutine が終わるの待つ
	fmt.Println(ints)
}
```

### 修正案 (2) 並列処理せず、直列にする

* 身も蓋もないが、そもそも直列にすればええやん、ということもある
* 以下、goroutine 使うの辞めた場合

```go
package main

import (
	"fmt"
)

func main() {
	ints := []int{}
	for i := 0; i < 10; i++ {
		ints = append(ints, n)
	}
	fmt.Println(ints)
}
```


