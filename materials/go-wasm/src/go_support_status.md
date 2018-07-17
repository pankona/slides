# Go 言語の wasm 対応状況

* Go 1.11 での対応が予定されている
  * Go 1.11 は 2018/08 にリリース予定
  * [all: WebAssembly (&quot;wasm&quot;) support (GitHub の issue)](https://github.com/golang/go/issues/18892)
  * [WebAssembly architecture for Go (設計資料)](https://docs.google.com/document/d/131vjr4DH6JFnb-blm_uRdaC0_Nv3OUwjEY5qVCxCup4/edit)

## Go 1.11 wasm における Go の言語機能サポートは

* goroutine も channel も使えるっちゃ使える
  * wasm にはマルチスレッドの機能がない
    * そもそも goroutine/channel はシングルスレッドでも動くからね
  * wasm にはマルチスレッド機能が入るかも
    * [Threading proposal for WebAssembly](https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md)
* なんと GC も動く
  * wasm には GC がいまのところないがいずれ入れる予定もあるらしい
* スレッドや GC の機能は、スタックをヒープ上に置くことでエミュレートしているらしい
  * 詳細不明ごめんなさい

## ビルドの仕方

* たとえばいつもの hello world (main.go とする) があったとして、

```go
package main

import "fmt"

func main() {
    fmt.Println("hello world!")
}
```
  
* ビルドは以下のようにする。普通にクロスコンパイルする場合と同じ。
  * `GOOS=js GOARCH=wasm` としてクロスコンパイル

```bash
$ GOOS=js GOARCH=wasm go build -o main.wasm main.go
```

## 補足: Go のクロスコンパイルについて

* Go はビルド時に GOOS と GOARCH に色々パラメータを指定することでクロスコンパイルできる
  * GOOS には linux、windows、darwin、等が指定できる
  * GOARCH には arm、arm64、386、amd64、mips、mips64、等が指定できる

```bash
# 64-bit の Arm Linux 向けビルド
$ GOOS=linux GOARCH=arm64 go build

# 32-bit の windows 向けビルド
$ GOOS=windows GOARCH=386 go build
```
