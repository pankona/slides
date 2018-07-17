# 実際にやってみる

実際にやってみます。

## 用意するもの

* Go 1.11 コンパイラ
  * master の最新か go1.11beta1 タグからビルドしても良い
  * `go get` で go1.11beta1 を取得するのが楽
* wasm に変換する Go のソース
* wasm を読み込んで関数を実行する JavaScript
* wasm と JavaScript を読み込む HTML コンテンツ
* 適当な HTTP Server

## 手順 (カンペ)

* いつもの hello world を作る
* `GOOS=js GOARCH=wasm go build -o test.wasm main.go` みたいにしてビルド
* `curl -sO https://raw.githubusercontent.com/golang/go/master/misc/wasm/wasm_exec.html` で HTML コンテンツ入手
* `curl -sO https://raw.githubusercontent.com/golang/go/master/misc/wasm/wasm_exec.js` で wasm を読み込んで関数を実行するための JavaScript を入手
* HTML コンテンツをHTTP Server でサーブ
  * file:/// ではダメ。chrome の制限で file:/// だと JavaScript を実行してくれないという情報あり
* サーブしたコンテンツをブラウザで見る

* 上記をまとめたリポジトリが以下
  * https://github.com/pankona/go-wasm-test 

## 試したところ…　

* コンパイルはとてもとても簡単だった
* けど、バイナリでかい...。のでロードが遅い。


