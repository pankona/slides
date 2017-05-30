Let's Go!
=======================

**Go言語の紹介**

![21.png](./materials/golang_intro_3/21.png)

赤塚洋介 (34)

>>>

[Back to table of contents](./index.html)

---

![01.png](./materials/golang_intro_3/01.png)

Go 言語マスコットキャラの Gopher くん

---

目次

* Go 言語ってどんな感じの言語？
* Go 言語の良いところ
* 昨今の主な使われ方

![09.png](./materials/golang_intro_3/09.png)

---

** どんな感じの言語？ **

* 2009年生まれ。Google製。C/C++の置き換え目的らしい。
* 型ある。コンパイルする。手続き型。
* シンプルな言語仕様を保つことにこだわっている。
* とはいえ、型推論などのモダンな一面も。

![05.png](./materials/golang_intro_3/05.png)

---

** Go 言語の良いところ (1) ** 

* とにかくシンプルな言語仕様
  * クラスがない
  * C ライクだが学習コスト低い
  * [acsmvc](https://github.com/aYosukeAkatsuka/acsmvc)

>>>

** シンプルなところの例 **

* ループは for しかない
* GC ある
* ポインタはあるけど演算できない
* 戻り値複数返せる
* 一気に複数代入できる
* 宣言した変数は自動的に初期化される

>>>

Hello World

~~~golang
package main

import (
    "fmt"
    "os" // 使ってないインポートあるとコンパイル通らない
)

func main() {
    i := 5 // 使ってないやつ変数があるとコンパイル通らない
    for {
        fmt.Printf("hello, world\n")
    }
}
~~~

ちなみに `go fmt` でインデントやら何やら自動的に揃う

---

** Go 言語の良いところ (2) ** 

* ポータビリティ
  * ビルドの結果、ワンバイナリになるのでデプロイ簡単
  * 依存関係をバイナリに抱え込んでいるので、ちょっと古い Linux とかでも動く
  * 特別な動作環境はいらない
  * ただちょっとバイナリサイズがおっきくなりがち

>>>

** バイナリサイズをちっさくする工夫 **

* ldflags="-w"
* ldflags="-s"
* UPX
* 1 MB 未満まで落とすことが出来る場合も

>>>

** 参考 **

* [Goのバイナリサイズを削減する - そこはかとなく書くよん。](http://tdoc.info/blog/2016/03/01/go_diet.html)

---

** Go 言語の良いところ (3) ** 

* C 言語との親和性 
  * Go 言語で書いたやつは Shared Object 化できる
    * C 言語から Go 言語の関数を呼び出す
  * Go 言語から C 言語の関数を呼び出す 

---

** 昨今の主な用途 **

かの有名なツールとか

* docker
* mackerel

---

** 昨今の主な用途 **

かの有名な企業とか

* Gunosyで色々
* KAYACで色々
* メルカリで色々

---

** 学び始めるときは **

* まずはチュートリアル ...  [A Tour of Go](https://go-tour-jp.appspot.com/welcome/1)
* 書き方に悩んだら ... [Effective Go](https://golang.org/doc/effective_go.html)

>>>

** 書籍 **

* [プログラミング言語 Go](https://www.amazon.co.jp/%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9EGo-ADDISON-WESLEY-PROFESSIONAL-COMPUTING-Donovan/dp/4621300253)
* [みんなの Go 言語](https://www.amazon.co.jp/dp/B01LMS7B1O/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)

---

トライしてみたらいかがかな！

![04.png](./materials/golang_intro_3/04.png)

---

![25.png](./materials/golang_intro_3/25.png)

>>>

[Back to table of contents](./index.html)
