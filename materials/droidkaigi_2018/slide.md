<span style="font-size:72px">gomobile でゲームは作れる</span>
=======================

** Go言語でゲームを作った話 **

by @pankona

---
<img src="./materials/droidkaigi_2018/face.jpg" width="300" style="background:none; border:none; box-shadow:none;">

* <span style="font-size:35px">本名: 赤塚洋介</span>
* <span style="font-size:35px">所属: 株式会社 ACCESS</span>
* <span style="font-size:35px">GitHub: https://github.com/pankona</span>
* <span style="font-size:35px">Twitter: [@pankona](https://twitter.com/pankona)</span>
* <span style="font-size:35px">Blog: [make clean;make](http://pankona.github.io/)</span>

<span style="font-size:29px">普段は組み込み関連/Android アプリ書いたりで仕事してます。</span><br>
<span style="font-size:29px">ACCESS は絶賛エンジニア募集中です！よろしくね！</span>

---

先般開催された [Gopher Game Jam](https://itch.io/jam/gopher-jam) (itch.io 主催)<br>
<br>
<a href=https://itch.io/jam/gopher-jam><img src="./materials/droidkaigi_2018/ggj.png" width="300" style="background-color:#FFFFFF; border:none; box-shadow:none;"></a>

<span style="font-size:29px">gomobile でゲームを作ってこれに応募していった話をします。</span>

---

**目次**

* Go と gomobile について
* `gomobile build` の利点/欠点
* 便利ライブラリ製作中
* 実際に出来たもの
* まとめ

--- 

Go と gomobile について

---

Go について

>>>

** Go について **

* 2009年生まれ。Google製。<br>C/C++の置き換え目的らしい。
* 型ある。コンパイルする。手続き型。
* シンプルな言語仕様を保つことにこだわっている。
* とはいえ、型推論などのモダンな一面も。

<img src="./materials/droidkaigi_2018/05.png" width="300" style="background:none; border:none; box-shadow:none;"><br>

>>>

** シンプル、モダンなところの例 **

* ループは for しかない
* GC あるので free しないで良い
* ポインタはあるけど演算できない
* 関数が戻り値複数返して、一気に複数に代入したり
* 宣言した変数は自動的に初期化される
* 余分なコードが許されない傾向

>>>

Hello World

~~~go
package main

import (
    "fmt"
    "os" // 使ってないインポートあるとコンパイル通らない
)

func main() {
    i := 5 // 使ってない変数があるとコンパイル通らない

    for {  // while がないので、無限ループも for を使う
        fmt.Printf("hello, world\n")
    }
}
~~~

ちなみに `go fmt` でインデントやら何やら自動的に揃う

>>>

** ポータビリティ **

* ビルドの結果、ワンバイナリになるのでデプロイ簡単
  * 依存関係をバイナリに抱え込んでいるので、<br>ちょっと古い Linux とかでも動く
  * ただちょっとバイナリサイズがおっきくなりがち
* 充実のクロスコンパイル (windows、mac、linux、arm、mips 等)
* 特別な実行環境はいらない
* いざとなったら C のコードも書ける (cgo という機能)

>>>

** cgo の例 **

```
package main

/*
#include <stdio.h>
void print(char* s) {
    printf("%s", s);
}
*/
import "C"

func main() {
    s := C.CString("hello cgo!\n")
    C.print(s)
}
```

---


gomobile について

>>>

gomobile とは

* Go でモバイルアプリを作るためのツール
* Go のサブプロジェクト。experimental な位置づけ。
* [gomobile 公式 (Mirror)](https://github.com/golang/mobile)
* Android / iOS に対応<br>(ですが本日は主に Android の話題)

<img src="./materials/droidkaigi_2018/caution.png" width="300" style="background:none; border:none; box-shadow:none;"><br>

>>>

** インストール **

`$ go get golang.org/x/mobile/cmd/gomobile`

* 別途 NDK のダウンロードが必要
* gomobile というコマンドが使えるようになる
* `gomobile bind` と `gomobile build` というサブコマンドを主に使う

>>>

**gomobile bind**

* Go のソースから Android アプリ向け共有ライブラリを吐き出すコマンド
  * C/C++ で書いたソースを NDK ビルドするのと同じような位置づけ
* 生成したライブラリを Android Studio 等からインポートして使う
* 今日は `gomobile bind` については割愛。

>>>

**gomobile build**

* Go のソースから APK を直接吐き出すコマンド
* OpenGL のバインディングを使って絵を描画することでアプリを作っていく
* 描画更新のために 60回/秒 でイベントが発生する仕組みが用意されている
* **Go だけで Android アプリが作れる**

>>>

**gomobile build についてもう少し**

* `gomobile build` でビルドできるアプリは<br>`go build` も可能
* PC 版 (windows、mac、linux) が出力できる。動作確認したりデバッグしたりが手軽。
* サンプルもあり〼

---

**Go でゲーム作るなら gomobile build で楽ができる？**

以下、ハマりどころを特集 <!-- .element: class="fragment" data-fragment-index="1" -->

---

**gomobile build の難所 (1)**

* Android SDK の機能に直接触れない
  * intent 投げる、データ保存する、等ができない
  * 気合で JVM を呼び出せば一定の範囲の API は呼び出せる (cgo 利用)
  * [JVM 呼び出すサンプル](https://gist.github.com/tenntenn/0751c856ee363182ba76) (by tenntenn さん)

>>>

**gomobile build の難所 (2)**

* アイコンが設定できない
  * 生成した APK を一度を開けて、アイコンを埋め込んでから閉め直せば可能
  * [APK を開けて閉める手順](https://github.com/pankona/gomo-simra/blob/master/memo/HowToEditAndroidManifest.md)
  * **2017年10月に解消しました！**

>>>

**gomobile build の難所 (3)**

* いつものソフトウェアキーボード使用不可
* 使用可能な入力は基本的に「タップ」のみ

>>>

**gomobile build の難所 (4)**

* 描画対象は一枚のキャンバスしかない
  * 画面をふたつに分けて広告出したりとかは難しい
  * タップしたら所定の URL に飛ぶ、等も気合がいる

>>>

**gomobile build の難所 (5)**

* 音出すのツライ
  * デフォルトの状態では音サポートなし
  * オプション指定で OpenAL 利用するように
  * ビルドがなかなか通らない (個人差があります)

>>>

**gomobile build の難所 (6)**

* 文字が出せない
  * 簡単に文字を出す API は用意されていない
  * 文字を画像化して表示するという工程を踏んで表示する

--- 

**欠点あるとはいえ...**

* `gomobile build` 一発で APK 出てくるのは魅力的
* PC 版も出せてデバッグも楽
* **なにより僕は Go で書きたい**

* なので頑張って使ってみました

---

**gomobile build を使うにあたって必要な知識**

* 絵を出す周りは結構生ナマしい API になっている
  * OpenGL (サンプル見ればあまり知らなくても大丈夫)
  * アフィン変換 (結構知ってる必要ある)

* めんどくさいと思った…？  <!-- .element: class="fragment" data-fragment-index="1" -->

---

**https://github.com/pankona/gomo-simra**

* アプリを作ってて面倒だと思った部分を色々ラップしたライブラリ
  * 画像の大きさと座標と回転具合だけ指定して描画
  * 端末の画面サイズに合わせて描画を拡大縮小
  * OpenAL 使わない音を出すインターフェース
  * 絵を次々入れ替える (アニメーションさせる) 仕組み
  * 各画像にタッチイベントのリスナーを設定可能
  * テキストの表示
  * ファイル保存先ディレクトリパスの取得 (New!)
  * 各種 example もあり〼

---

**https://github.com/pankona/phantomize**

<img src="./materials/droidkaigi_2018/phantomize.png" width="500" style="background:none; border:none; box-shadow:none;"><br>

* 出来上がったもの。タワーディフェンス的な。
* 製作期間は Jam のルールに則って 2017/4E 〜 2017/7E
* Linux、OSX、Android で動作確認
* Jam では 2 位を獲得
* (応募総数 4 作品)  <!-- .element: class="fragment" data-fragment-index="1" -->

---

**感想**

* 絵をちゃんと描けるようにならないと…
* 絵と音の素材を提供してくれている方々に感謝
* 結構時間かけた (3ヶ月くらい) けどしょぼい
* 時間に制限があるので妥協の連続
* とはいえ一応完成 (ということに) して提出できたのは嬉しい

---

**まとめ**

* 制限だらけで苦しいが、`gomobile build` でゲームは作れた！
* gomobile、ぜひお試しあれ。
* ちなみに gomobile にコントリビュートするチャンスは多い

---

<img src="./materials/droidkaigi_2018/thank.png" width="300" style="background:none; border:none; box-shadow:none;"><br>

---

** クレジット **

* <span style="font-size:29px">スライド中の Gopher のイラストは全て [tenntenn さんの作品](https://github.com/tenntenn/gopher-stickers)です。</span><br>
* <span style="font-size:29px">Gopher (Goのマスコット) の原作者はRenee Frenchさんです。</span>
