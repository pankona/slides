WIP Pull Requestのすゝめ
=======================

>>>

[Back to table of contents](./index.html)

---

WIP Pull Requestとは

作業中だがプルリクエストを出しちゃうこと <!-- .element: class="fragment" data-fragment-index="1" -->

---

[こんなのです。](https://github.com/pankona/slides/pull/3)

---

どんな意味が？

* 雰囲気をレビュー<br>（細かいところはまだ見なくてもいい）  <!-- .element: class="fragment" data-fragment-index="1" -->
* 頑張って作りこむ前なら大きめの指摘も気楽                  <!-- .element: class="fragment" data-fragment-index="2" -->
* 進捗具合の確認にも使える                                  <!-- .element: class="fragment" data-fragment-index="3" -->

>>> 

* 作業中の変更をローカルに大事に抱えていて、次の日会社休んじゃう、みたいなね。
* そういうのを防ぐ意味でも、さっさとGitHubにあげちゃうのがいいんじゃないかな。 <!-- .element: class="fragment" data-fragment-index="3" -->

---

やり方

* 作業中（ワンコミットしたあと）に<br>プルリク作ればOK  <!-- .element: class="fragment" data-fragment-index="1" -->
* プルリクのタイトルに [WIP] をつけて、<br>作業中だからマージしないでをアピール  <!-- .element: class="fragment" data-fragment-index="2" -->
* 変更完了したらWIPを外してガチレビュー依頼  <!-- .element: class="fragment" data-fragment-index="3" -->

---

TIPS: 開幕WIP Pull Request

* もう作業開始したら<br>さっさとWIPプルリク作っちゃおうか！
* でもワンコミットしないとプルリクが作れない、<br>どうすれば…  <!-- .element: class="fragment" data-fragment-index="1" -->

---

そんなときはこれ

* `git commit --allow-empty` で変更のないコミットが作れます
* これで開幕WIPプルリクもできる！

---

無駄コミットログができちゃうけど…？

* 安心しろ、大丈夫だ
* その後 `git commit --amend` すれば、<br>その無駄コミットも消せる

---

ツール紹介

* [scriptForGithub](https://github.com/kasaharu/scriptForGitHub) by kasaharu
* プルリク、コミットメッセージのテンプレートを提供してくれる

---

快適なプルリクライフを！

---

Thank you!

>>>

[Back to table of contents](./index.html)
