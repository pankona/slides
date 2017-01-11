共通 CA 紹介
=======================

赤塚洋介 (33)

>>>

[Back to table of contents](./index.html)

---

* 共通 CA (正式名称: Hybridcast Connect) が、<br>
もうすぐ Google Play / App Store にリリースされそうです！<br>
(2017.1.11 現在)
* というところで、どんな中身になっているか紹介します。

---

目次

* どんなアプリか？
* 設計のポイント
* うまくいったと思われるところ
* 苦労したところ

---

**どんなアプリか？**

[公式サイト](https://hybridcast.access-company.com/) <!-- .element: class="fragment" data-fragment-index="1" -->

---

**謳い文句抜粋**

*Hybridcast Connect は、放送・通信の連携による新しいテレビサービス Hybridcast を楽しむためのアプリケーションです。<br>
Hybridcast 対応番組の放送中にお使いのテレビと連携して Hybridcast の多彩なコンテンツをスマートフォンを通してお楽しみいただけます。<br>
例えば、双方向番組への参加、オンデマンド番組の視聴、視聴中の番組情報を手軽に入手できるなど、快適なテレビライフをお楽しみいただけます。*

---

**大体で言うと**

* スマホアプリはテレビと連携する
* スマホを使ってテレビでやってるクイズとか投票とかに参加できる
* (一部のテレビに対しては) リモコン機能も搭載
* スマホに表示されるコンテンツは HTML ベース

---

**要件のポイント(1)**

* Android/iOS どっちもほしい
* 双方のアプリは見た目もできるだけ同じに

* → ビジネスロジック部分は共通化したい <!-- .element: class="fragment" data-fragment-index="1" -->

---

**設計のポイント**

* Android/iOS のアプリ部分 (Java/Swiftで書く部分) はなるべく薄く
* 共通の処理は C++ で書いて、Android/iOS 双方向けに使う

---

<img src="./materials/ccapp/module_diagram.svg" width=60% style="background:none; border:none; box-shadow:none;"><br>
モジュール構成図

---

**うまくいったと思われるところ (1)**

* C++ レイヤでビジネスロジック部分を共通化

>>>

* (個人的には) テストしやすい
* OSS の数も割と少なくて済む
* Android/iOS アプリが比較的素直に書けるので、ハマりどころ減らせた
* Android/iOS アプリも共通化するべきだった…？

---

**苦労したところ (1)**

* メーカー間の差異を吸収する

>>>

* スマホ↔テレビ間の通信はメーカーによって異なる
* 機器検索、認証方式、電文のやりとりの方法は以下のような感じ
    * 共通CAサーバ ... DIAL、PINコード、WebSocket
    * T芝R ... netbios、PINコード、WebSocket
    * M菱R ... UPnP、認証なし、UPnP
    * SプA ... UPnP、IDとパスワード、WebSocket

>>> 

* メーカー間の差異は基本的に全てC++レイヤで吸収
* Java/Swift では (なるべく) メーカーを意識せずにアプリを書けるように

---

**苦労したところ (2)**

* pthread_cancel が NDK ビルド時に見つからない

>>>

* スレッド開始・終了を pthread_create と pthread_cancel でやる想定だった
    * 機器検索の開始・終了、WebSocket 通信の開始・終了、ハートビート…
* Android 向けにビルドしたときに発覚
* 後々までデッドロックを引き起こす原因になる

>>>

pthread_cancel を使わずに pthread を終了させるためにやったこと

* pthread_kill を使うのを試したがダメだった
* 愚直にループ制御フラグを外部からもちゃもちゃする

---

「Hybridcast Connect」で検索！<br>
出たら使ってみてね！

※ ハイブリッドキャスト対応テレビが必要です<br>
※ T芝かM菱のテレビである必要があります<br>
※ 対応機種はこれから変わる可能性があります

---

完

>>>

[Back to table of contents](./index.html)
