Let's Go!
=======================

**golang の紹介**

![gopher](./materials/golang_intro_1/gopher.png)

>>>

[Back to table of contents](./index.html)

---

ここ最近、2つ程 Go言語の勉強会に参加してきました。
![golang_study](./materials/golang_intro_1/golang_strudy_20150811.png)
![golang_allstarts](./materials/golang_intro_1/golang_allstarts_20151011.png)<br>

なので、Go言語がどんなもんか  
軽く紹介したいと思います。

---

目次

* 事の始まり
* どんな感じの言語？
* よく言われる Golang の特徴
* 個人的に思う Golang の良いところ
* 昨今の主な使われ方

---

事の始まりは以下のエントリー  

<span style="font-size:x-large">[江添さんに簡単に質問出来るコマンドを golang で書いた。](http://mattn.kaoriya.net/software/lang/go/20150520134340.htm)</span>

* 江添さんの ask.fm に質問をポスト出来る「コマンドラインアプリ」
* `go get github.com/mattn/ezoe` でインストールしたらホントにすぐ動いた
* わしも試してみよと思ったわけ

---

試してみようと思った理由（個人的）

* ちょっとしたコマンドラインツールを作るのに  
調度良いらしい
* コンパイルする言語である
* 新しめの言語だし試してみるか
* vim と相性良いらしい...! <!-- .element: class="fragment" data-fragment-index="1" -->

---

** どんな感じの言語？ **

* Google製。C/C++の置き換え目的らしい。
* 楽しくプログラミングしようぜ、というテーマがあるらしい。

---

** 続・どんな感じの言語？ **

* ここで hello world を書く
* 処女作 [acsmvc](https://github.com/aYosukeAkatsuka/acsmvc)
* 確かに簡単だった！ <!-- .element: class="fragment" data-fragment-index="1" -->

--- 

** よく言われるGo言語の特徴 ** 

* ポータビリティ
  * ビルドの結果、ワンバイナリになるのでデプロイ簡単
* 並列処理が簡単！
  * goroutine
* interface
  * いわゆるダックタイピング
  * Generic型はないが、似たようなことはできる

--- 

** 個人的に思うGo言語の良いところ **

* 書きやすい（LL的）
* クロスコンパイルが簡単
* コンパイルする（しかも割と厳しい）
* `go fmt` でコードフォーマット
* C/C++と相性良い
* `go get` 一発でインストール完了
* `makefile` 的なものは書かない
* シンプル → ベターC 的な感覚

---

** その他諸々 **

* バイナリサイズ大きい
* ガベージコレクションが遅い
* そんなわけで組み込みにはまだ向かないという意見も

--- 

** 昨今の主な用途 **

主にインフラ寄り

* docker
* mackerel
* Gunosyで色々
* KAYACで色々

---

トライしてみたらいかがかな！

---

Thank you!

>>>

[Back to table of contents](./index.html)
