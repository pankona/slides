オススメは gomobile
=======================

**Go 言語と gomobile の紹介**

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
* Go で Android/iOS アプリを作る

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
  * クラスがないのがある意味じゃ特徴
  * C言語ライク。学習コスト低い
  * コンパイラが割と厳格に型をみる

>>>

** シンプルなところの例 **

* ループは for しかない
* GC あるので明示的なメモリフリーはしない
* ポインタはあるけど演算できない
* 戻り値複数返せる
* 一気に複数代入できる

>>>

** コンパイラが割と厳格なところの例 **

* 使っていないインポート文は許されない
* 見ていない戻り値も許されない
* 使っていない変数も許されない

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

>>>

** クロスビルドが楽 **

* GOOS、GOARCH という変数を指定してコンパイルする
* ちなみにコンパイルのコマンドは `go build`

~~~bash
# OSX 向けにビルド
$ GOOS=darwin GOARCH=amd64 go build
~~~
~~~bash
# Linux 32bit 向けにビルド
$ GOOS=linux GOARCH=386 go build
~~~
~~~bash
# Linux 32bit arm 向けにビルド
$ GOOS=linux GOARCH=arm go build
~~~

参照先はここ  
https://golang.org/doc/install/source#environment

---

** Go 言語の良いところ (3) ** 

* 並列プログラミング
  * goroutine と呼ばれる軽量スレッド 

>>>

goroutine の例 (A Tour of Go から抜粋)

```golang
package main

import (
    "fmt"
    "time"
)

func say(s string) {
    for i := 0; i < 5; i++ {
        time.Sleep(100 * time.Millisecond)
        fmt.Println(s)
    }
}

func main() {
    go say("world") // goroutine やってるところ
    say("hello")
}
```

---

** Go 言語の良いところ (4) **

* 充実の標準ツール群
  * チームでの開発に良い
  * `gofmt` と `goimports`
  * `golint` と `govet`
  * `godoc`
  * `go test`
  * `gocode`

>>>

** `gofmt` で修正されるものの例 **

* インデント（デフォはハードタブ）
* 変数と演算子の間のスペースの数
* for 文、if 文の後の中括弧の位置
* 無駄な行末の空白、無駄な改行

>>>

** before **

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
      if i>10
      {
          break
      }
    }
}
~~~

---

** Go 言語の良いところ (5) **

* 充実のチュートリアル

  * [A Tour of Go](https://go-tour-jp.appspot.com/list)
  * [golang-jp.org](http://golang-jp.org/)

3日くらい学べば何か書けるんでは

![14.png](./materials/golang_intro_2/14.png)

---

** そして gomobile **

さんざん良いところを紹介してきましたが、  
これらのメリットは Android/iOS アプリを作るときにも  
活用が可能です。

gomobile っていうの使います。

---

** gomobile とは **

* golang の experimental なプロジェクト
* 激しく開発中（時々壊れる）
* 公式は[ココ](https://github.com/golang/go/wiki/Mobile)

* 以下の2つの手法が提供されている
  * Go で出来たライブラリを出力する
  * Go で出来た APK を出力する

**今日は「Go で出来たライブラリを出力する」をフィーチャー**

---

** gomobile bind **

* 要は C/C++ で書いて NDK ビルドする部分を Go で書けるという話

>>>

** gomobile bind (続き) **

* Android 向けライブラリを出力するには、  
`gomobile bind` というコマンドを使う。
* 以下を自動生成してくれる
  * shared object (.so)
  * Java クラス (ソースファイル)

つまり JNI を書かなくて良い！

---

トライしてみたらいかがかな！

![04.png](./materials/golang_intro_2/04.png)

---

![25.png](./materials/golang_intro_2/25.png)

>>>

[Back to table of contents](./index.html)
