# golangci-lint

## golangci-lint とは

- この世に現存する名だたる Go の linter を同時にいっぱいかけてくれる CLI ツール、およびウェブサービス
  - [GitHub](https://github.com/golangci/golangci-lint)
  - [GolangCI (ウェブサービスのほう)](https://golangci.com)

## 提供形態

- CLI ツール
  - 手元の Go プロジェクトに対して lint をかけるのに使う
- ウェブサービス
  - pull request に対して lint をかけて引っかかったら pull request に直接コメントしてくれる
  - なんと無料で使えちまうんだ (public repository なら)

## 便利なところ

- サポートしている linter めっちゃ多い。とりあえずこれだけ入れておけばよくてお得
  - 2019-11-05 (v1.21.0) 現在、40 個くらいの linter をサポート
- 設定ファイルやコマンドライン引数でどの lint を使うか選べる
  - 設定ファイルはウェブサービスの設定ファイルを兼ねる
  - .golangci.yml みたいのをプロジェクトのルートに置いておくスタイル
- master から変更があったところだけ lint してくれる機能がある
  - コードベース全体に対して lint かけたら大量に指摘があがっちゃうようなときも、徐々に導入していける
- 速いらしい
  - [gometalinter](https://github.com/alecthomas/gometalinter) という類似の (いまは deprecated になった) ツールがあったが、それの 5 倍速いらしい
  - 確かに速い気がする (体感)
