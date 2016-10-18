Espresso Test Recorder<br>使ってみた
=======================

赤塚洋介 (33)

>>>

[Back to table of contents](./index.html)

---

Espresso Test Recorder を使ってみた感想を発表します。

<img src="./materials/espresso/espresso_test_recorder.png" style="background:none; border:none; box-shadow:none;">

---

**Espresso Test Recorer とは**

* Android Studio 2.2 にビルトインされた機能
* UI テストの支援
* 実際に入力した内容を覚えておいてくれて、あとで再現できる

---

**実際に何をやってくれるかというと**

* ユーザが行った操作に従ってコードを自動生成
  * どの View 要素をクリックしたか
  * どの text field に何を入力したか
  * 画面のキャプチャをとる (テスト実行時に一致するか確認する)

---

**(やってくれそうで) やってくれないこと**

* 「待ち」の再現
* WebView へのアクションは完全に自分で書く必要がある

---

**実際ちょっとやってみて現時点での感想**

* 割と使えそう (初見〜 30 分くらいでまあまあ書ける)
* 自動生成されたテストコードはそれなりに調整する必要がある。
* 0 から自力で書くよりは何倍も楽っぽい

---

**実演**

<img src="./materials/espresso/19.png" style="background:none; border:none; box-shadow:none;">

---

みなさんも試してみてね！

---

完

>>>

[Back to table of contents](./index.html)
