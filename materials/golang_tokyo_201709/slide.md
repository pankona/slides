<span style="font-size:72px">gomobile でゲームは作れる</span>
=======================

** gomobile build でゲーム作った話 **

by @pankona

---
<img src="./materials/golang_tokyo_201709/face.jpg" width="300" style="background:none; border:none; box-shadow:none;">

* <span style="font-size:35px">本名: 赤塚洋介</span>
* <span style="font-size:35px">所属: 株式会社 ACCESS</span>
* <span style="font-size:35px">GitHub: https://github.com/pankona</span>
* <span style="font-size:35px">Twitter: [@gohan_pan_gohan](https://twitter.com/gohan_pan_gohan)</span>
* <span style="font-size:35px">Blog: [make clean;make](http://pankona.github.io/)</span>

<span style="font-size:29px">普段は組み込み関連/Androd アプリ書いたりで仕事してます。</span>

---

先般開催された [Gopher Game Jam](https://itch.io/jam/gopher-jam)<br>
<br>
<a href=https://itch.io/jam/gopher-jam><img src="./materials/golang_tokyo_201709/ggj.png" width="300" style="background-color:#FFFFFF; border:none; box-shadow:none;"></a>

<span style="font-size:29px">gomobile でゲームを作ってこれに応募していった話をします。</span>

---

**目次**

* `gomobile build` の利点/欠点
* gomo-simra
* phantomize
* まとめ

--- 

gomobile について

>>>

gomobile とは

* Go でモバイルアプリを作るためのツール
* Android / iOS に対応
* [gomobile 公式 (Mirror)](https://github.com/golang/mobile)
* `gomobile bind` と `gomobile build` というコマンドを主に使う

>>>

**gomobile bind**

* Go のソースから Android/iOS アプリ向け共有ライブラリを吐き出すコマンド
* 生成したライブラリを Android Studio 等からインポートして使う
* 今日は `gomobile bind` については割愛。

>>>

**gomobile build**

* Go のソースから APK を直接吐き出すコマンド
* OpenGL のバインディングを使って絵を描画することでアプリを作っていく
* 描画更新のために 60回/秒 でイベントが発生する仕組みが用意されている
* **Go だけで Android アプリが作れる**
* iOS 向けも出来ると思われる (がデバイス持ってないので未確認です…)

>>>

**gomobile build についてもう少し**

* `gomobile build` でビルドできるアプリは<br>`go build` も可能
* PC 版 (Win、OSX、Linux) が出力できる。動作確認したりデバッグしたりが手軽。

---

**ゲーム作るなら gomobile build のほうが楽？**

---

**gomobile build の難所 (1)**

* Android SDK の機能に直接触れない
  * intent 投げる、データ保存する、等ができない
  * 気合で JVM を呼び出せば一応やれると思われる (cgo 利用)
  * [JVM 呼び出すサンプル](https://gist.github.com/tenntenn/0751c856ee363182ba76) (by tenntenn さん)

>>>

**gomobile build の難所 (2)**

* アイコンが設定できない
  * 生成した APK を一度を開けて、アイコンを埋め込んでから閉め直せば可能
  * [APK を開けて閉める手順](https://github.com/pankona/gomo-simra/blob/master/memo/HowToEditAndroidManifest.md)

>>>

**gomobile build の難所 (3)**

* キーボード使用不可
* 使用可能な入力は基本的に「タップ」のみ

>>>

**gomobile build の難所 (4)**

* 描画対象は一枚のキャンバスしかない
  * 画面をふたつに分けて広告出したりとかは難しい
  * タップしたら所定の URL に飛ぶ、等も気合がいる

>>>

**gomobile build の難所 (5)**

* 音出すのツライ
  * デフォルトのビルドは音サポートなし。
  * オプション指定で OpenAL 利用するように。
  * ビルドがなかなか通らない上に OpenAL は LGPL。

--- 

**欠点あるとはいえ...**

* `gomobile build` 一発で APK 出てくるのは魅力的
* PC 版も出せてデバッグも楽
* なにより僕は Go で書きたい
* なので頑張って使ってみました

---

**gomobile build を使うにあたって必要な知識**

* 絵を出す周りは結構生ナマしい API になっている
  * OpenGL (あまり知らなくても大丈夫)
  * アフィン変換 (結構知ってる必要ある)

>>>

**アフィン変換...？**

<img src="./materials/golang_tokyo_201709/atamanowaruihito.jpg" width="300" style="background:none; border:none; box-shadow:none;"><br>

---

**[gomo-simra](https://github.com/pankona/gomo-simra)**

* アプリを作ってて面倒だと思った部分を色々ラップしたライブラリ
  * 画像の大きさと座標と回転具合だけ指定して描画
  * 端末の画面サイズに合わせて描画を拡大縮小
  * OpenAL 使わない音を出すインターフェース
  * 絵を次々入れ替える (アニメーションさせる) 仕組み
  * 各画像にタッチリスナーを設定可能
  * テキストの表示
  * 各種 example もあり〼

---

**[phantomize](https://github.com/pankona/phantomize)**

<img src="./materials/golang_tokyo_201709/phantomize.png" width="500" style="background:none; border:none; box-shadow:none;"><br>

* 出来上がったもの。タワーディフェンス的な。
* 製作期間は Jam のルールに則って 2017/4E 〜 2017/7E
* Linux, OSX、Android で動作確認
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

* `gomobile build` でゲームは作れた！
* gomobile、ぜひお試しあれ。

---

完

---

**最後に**

* pankona は Go を書ける職場環境を求めています。
* I WANT TO BE HIRED!

---

<img src="./materials/golang_tokyo_201709/thank.png" width="300" style="background:none; border:none; box-shadow:none;"><br>

---

<span style="font-size:29px">Gopher (Goのマスコット) の原作者はRenee Frenchさんです。</span>
