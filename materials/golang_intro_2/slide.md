Let's Go!
=======================

**Go言語の紹介**

![21.png](./materials/golang_intro_2/21.png)

赤塚洋介 (33)

>>>

[Back to table of contents](./index.html)

---

![01.png](./materials/golang_intro_2/01.png)

Go 言語マスコットキャラの Gopher くん

---

目次

* Go 言語ってどんな感じの言語？
* Go 言語の良いところ
* 昨今の主な使われ方

![09.png](./materials/golang_intro_2/09.png)

---

** どんな感じの言語？ **

* 2009年生まれ。Google製。C/C++の置き換え目的らしい。
* 型ある。コンパイルする。手続き型。
* シンプルな言語仕様を保つことにこだわっている。
* とはいえ、型推論などのモダンな一面も。

![05.png](./materials/golang_intro_2/05.png)

---

** Go 言語の良いところ (1) ** 

* とにかくシンプルな言語仕様
  * クラスがない
  * 学習コスト低い
  * [acsmvc](https://github.com/aYosukeAkatsuka/acsmvc)

>>>

** シンプルなところの例 **

* ループは for しかない
* GC ある
* ポインタはあるけど演算できない
* 戻り値複数返せる
* 一気に複数代入できる

>>>

Hello World

~~~golang
package main

import (
    "fmt"
    "os" // 使ってないインポートあるとコンパイル通らない
)

func main() {
    i := 0 // 使ってないやつ変数があるとコンパイル通らない
    for {
        fmt.Printf("hello, world\n")
        i++
        if i > 10 {
            break
        }
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

トライしてみたらいかがかな！

![04.png](./materials/golang_intro_2/04.png)

---

![25.png](./materials/golang_intro_2/25.png)

>>>

[Back to table of contents](./index.html)
