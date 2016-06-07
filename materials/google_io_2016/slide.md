Google I/O 2016<br>情報共有 
=======================

Yosuke Akatsuka (33)

>>>

[Back to table of contents](./index.html)

---

この資料は
=======================
Google I/O 2016 の内容を<br>
社内で軽くシェアするために作成されました。

発表された内容が多いですので、<br>各要素についてはダイジェストでお送ります。

また、主に Android Studio 2.2 について触れています。

---

** 目次 **

* Google Assistant
* Google Home
* Allo / Duo
* Android N Developer Preview 3 / Daydream
* Android Wear 2.0
* Android Studio 2.2
* Firebase
* Android Instant Apps

---

** Google Assistant **

* 対話型アシスタントの「ロジック」　
* コンテキストを理解できるのが特徴
  * (彼、って言って誰のことか文脈で判断する)
* 後に出てくる Google Home、Allo 等に使われている

---

** Google Home **

* Amazon Echo みたいなやつ
* Google Assistant を使っている
* 音声で家電の制御を行ったりするのを目指している
* [公式](https://home.google.com/)

>>>

![google_home](./materials/google_io_2016/io2016_google_home.jpg)<br>
Google Home はこんなの

---

** Allo / Duo **

コミュニケーションのためのアプリ<br>

![alloduo](./materials/google_io_2016/io2016_alloduo.jpg)<br>

>>>

** Allo (チャット) **

* チャットにおいて返信をサジェストしてくれたりする
* 子供の写真が送られてきたら「かわいいね」等

** Duo (ビデオ通話) **

* 低速な回線でも良い品質でビデオ通話できる、らしい
* 通話前から相手側の映像が見えるので空気読める

---

** Android N Developer Preview 3 **

* 3月に発表済
* 以下のサイトでコードネーム募集中 (6/8 まで)
* https://www.android.com/versions/name-n/

---

** Daydream **

* スマートフォンでVR
* 既存の端末が Daydream 対応認定がされることはない
* Daydream 対応スマホ、ヘッドセット、コントローラは今秋から

---

** Android Wear 2.0 **

![android_wear](./materials/google_io_2016/io2016_android_wear.png)<br>

>>>

** 2.0 での主な変更点 **

* UI の改善、文字入力機能の改善
* スタンドアロンでの動作が可能になった
  * Data Layout API の利用は必須ではなくなった
* スマホ向けのアプリをそのまま入れてもある程度動いちゃったりする
  * ただし、これは良くない。専用に設計されたアプリを。

---

## Android Studio 2.2


![youtube](./materials/google_io_2016/whatsnew_in_android_dev_tools.png)

[What's New in Android Development Tools - Youtube](https://www.youtube.com/watch?v=csaXml4xtN8)

---

Android Studio 2.2<br>大きな変更4つ

* Design
* Develop
* Build
* Test

--- 

## Design

* Layout Editor
* ConstraintLayout
* Layout Inspector

>>> 

** (1) Layout Editor **

* Android 2.2 入れたらとりあえずびっくりするところ。
* いろいろやりやすくなっている。ドラッグ＆ドロップでウィジェットを配置したり。
* Xcode っぽい？

>>>

![layout_editor_1](./materials/google_io_2016/as22_layout_editor_1.png)<br>
Layout Editor の図

>>>

![layout_editor_2](./materials/google_io_2016/as22_layout_editor_2.png)<br>
Menu を編集しているところ

>>>

** (2) ConstraintLayout **

* これもまたちょっと Xcode っぽい。
* ストーリーボードの Constraint とだいたい同じ？

>>>

![constraint_layout_1](./materials/google_io_2016/as22_constraint_layout_1.png)<br>
Constraint Layout でウィジェットを配置している図

>>>

** (3) Layout Inspector **

* 実機と繋いだ状態でみる。ビューのヒエラルキ等を確認できる。
* ビューの属性や現在の状態がかなり細かく見えるようになった。

>>>

![layout_inspector_1](./materials/google_io_2016/as22_layout_inspector_1.png)<br>
Layout Inspector でビューの属性を確認しているところ

--- 

## Develop

* Firebase plugin
* Sample code browser
* Support annotation、lint の強化

>>> 

** (1) Firebase plugin **

* Firebase の各種機能を簡単に利用できる
* 数クリックで Analytics の設定終了、なんていう話も

>>>

![firebase_plugin_1](./materials/google_io_2016/as22_firebase_on_studio_1.png)<br>
Firebase Plugin のペイン<br>
(Android Studio の右端のほう)

>>>

** (2) Sample code browser **

* 右クリックのメニューから「サンプルコードを表示」ができるようになる
* Google が提供する高品質なサンプルとのこと　
* とはいえ、今のところ出ないやつも多い。今後増える？

>>>

![sample_code_1](./materials/google_io_2016/as22_sample_code_1.png)<br>
サンプルコードを探しているところ<br>
(下のペインにサンプル候補がでる)

>>>

** (3) Support annotation、lint の強化 **

* Annotation のサジェストをしてくれる<br>(いまはテキストベースで出力されるだけ)

--- 

## Build

* ビルドの高速化
* Jack Annotation Processor Support
* CMake と NDK-BUILD が Gradle と連携
* Merged Manifest Viewer
* Project Structure View (experimental)

>>>

** (1) ビルドの高速化 **

以下のような噂があるが、詳細不明

* ビルドが早くなる
* エミュレータも早くなる

>>>

** (2) Jack Annotation Processor Support **

* Jack toolchain が Annotation をサポートするようになった
* gradle から Jack を有効にすると、自動的に Annotation が有効になる
* (Jack ってまだ作ってたんだ…？)

>>>

** (3) CMake と NDK-BUILD が Gradle と連携 **

Native (C/C++) のビルドサポートが強化

* CMakeList.txt を build.gradle 内から指定してビルド
* Android.mk を指定してビルド

>>>

![cmake](./materials/google_io_2016/as22_cmake.png)<br>
build.gradle から CMakeList.txt を指定しているところ

>>>

![ndk_build](./materials/google_io_2016/as22_ndk_build.png)<br>
build.gradle から Android.mk を指定しているところ

>>>

** (4) Merged Manifest Viewer **

* AndroidManifest.xml がビルド後にどのように変わるか見れる

>>>

![merged_manifest](./materials/google_io_2016/as22_merged_manifest_viewer.png)<br>
Manifest Viewer しているところ

>>>

** (5) Project Structure View (experimental) **

* Dependencies が分かりやすくなった。前は誰が何を引っ張ってきてるのかわかりずらかった。
* 更新可能ライブラリがあればお知らせしてくれたり。
* Gradle の設定で有効にしないと使えない

--- 

### Test

* Espresso Test Recorder
* APK Analyzer
* C++ Debugger

>>>

** (1) Espresso Test Recorder **

* 操作を覚えてくれて後で再生できる夢のような機能
* アプリを普通に使うだけでテストが作成できる、という触れ込み

>>>

![espresso_test_recorder](./materials/google_io_2016/as22_espresso_test_recorder.png)<br>
Espresso Test Recorder

>>>

** (2) APK Analyzer **

* ファイルの容量、各パッケージのメソッドの量
* Remove unused resources で使っていないリソースを削除してくれたりする機能も。

>>>

![apk_analyzer](./materials/google_io_2016/as22_apk_analyzer.png)<br>
APK Analyzer を使っているところ

>>>

** (3) C++ Debugger **

* java-aware C++ debugger
* lldb を使って C++ のデバッグできるらしい

---

** Firebase **

* Firebase Analytics
* Google Cloud Messaging、App Indexing、AdWords、AdMob などを統合

---

** Android Instant Apps **

* Play ストア使わずにアプリを使うことができる
* ダウンロード即実行、終わったら破棄
* QRコード等でダウンロードさせる 

---

** その他 - nearby **

* https://developers.google.com/nearby/
* アプリなしでURL配れるようになる

---

** 参考 **

* [Android Studio 2.2 Preview - New UI Designer & Constraint Layout](http://android-developers.blogspot.jp/2016/05/android-studio-22-preview-new-ui.html)
* [Google I/O 2016 情報共有会 - connpass](http://fablic.connpass.com/event/32434/)
* [Google I/O 2016で発表されたことのまとめ - Gigazine](http://gigazine.net/news/20160519-googleio2016-matome/)

---

完

>>>

[Back to table of contents](./index.html)
