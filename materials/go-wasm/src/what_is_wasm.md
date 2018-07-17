# wasm とは何か

* 公式サイト

<a class="embedly-card" data-card-controls="0" href="https://webassembly.org/">WebAssembly</a>
<script async src="//cdn.embedly.com/widgets/platform.js" charset="UTF-8"></script>

*WebAssembly (abbreviated Wasm) is a binary instruction format for a stack-based virtual machine. Wasm is designed as a portable target for compilation of high-level languages like C/C++/Rust, enabling deployment on the web for client and server applications.*

ポイントは以下。
* binary instruction format (バイナリ命令フォーマット) である
* C/C++/Rust 等の高水準言語をコンパイルして生成するターゲットとして設計されている
* ウェブ上で展開可能である

もっとざっくり言うと、
* C/C++/Rust 等をコンパイルして作ったバイナリを Web ブラウザ上で動かせちまうんだ

ということ。

## 何のためのものか

基本的には、「JavaScript より高速に動作する」というのがウリ
* [FAQ](https://webassembly.org/docs/faq/) によると JavaScript より 20x 速くなるケースも、みたいなことが書かれているが…？
* ちなみに [asm.js](http://asmjs.org/) という似たようなのが既にあるがファイルサイズが大きいだとか基本的に数値計算しかできないということで適用できる場面に限りがある
* asm.js よりもファイルサイズを減らし、ロード時間の短縮に寄与する

## ユースケース

* [公式に様々なユースケースがリストアップされている](https://webassembly.org/docs/use-cases/)
* C/C++/Rust 等で書いたコードを AltJS 的にポートする
* JavaScript では性能的に足りない部分を補う
  * 画像・動画の編集
  * ゲーム
  * 画像認識
  * CAD ([AutoCAD は wasm 使ってるらしい](http://blogs.autodesk.com/autocad/autocad-web-app-google-io-2018/))
* 等など

## その他

* 割とコンパイルがめんどくさいと言われている (試していないが[ビルドに数時間かかるみたいな記事](https://qiita.com/umamichi/items/c62d18b7ed81fdba63c2)もある)
* C/C++/Rust 以外の言語でも wasm へのコンパイルをサポートする動向

