# goroutine 間の通信

* goroutine は軽量ということもあり、カジュアルに大量に生成する使い方がされることも。
  * 複数の goroutine 間でコミュニケーションをしたい場合はどうするか？
  * 共有メモリを用いるパターンと `channel` を用いるパターンを紹介

![GO GO](./assets/images/04.png)
