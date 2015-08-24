CI TIPS
=======================

** GitHub Pull Request Builder **

>>>

[Back to table of contents](./index.html)

---

CIしてますか！ 

![jenkins_logo](./materials/ci-tips/jenkins_logo.png)<br>
ジェンキンスおじさん

---

** よくあるCIでやること例 **

* ビルドの確認
* 自動でテスト
* 成果物のデプロイ
* こけたらお知らせ
* etc...
* これらをいつ実行していますか？ <!-- .element: class="fragment" data-fragment-index="1" -->

---

** 個人的にTravis CIを試してみたときのこと **

![travis-mascot](./materials/ci-tips/travis-mascot.png)<br>
トラビスおじさん

---

** Travis CIが「デフォルトで」やってくれること **

以下のタイミングでスクリプト実行 <!-- .element: class="fragment" data-fragment-index="1" -->

* masterに新しくコミットがPUSHされたら <!-- .element: class="fragment" data-fragment-index="2" -->
* Pull Requestができたら <!-- .element: class="fragment" data-fragment-index="3" -->
* Pull Requestに新しくコミットがPUSHされたら <!-- .element: class="fragment" data-fragment-index="3" -->
* 結構凄い！ <!-- .element: class="fragment" data-fragment-index="4" -->

---

** Pull Requestに対しては... **

* ブランチに対してスクリプト実行
* （マージできるなら）試しにマージしてからスクリプト実行
* 結構凄い！ <!-- .element: class="fragment" data-fragment-index="1" -->

---

** 何が起こるかというと **

* マージしても大丈夫なPull Requestかわかる。 <!-- .element: class="fragment" data-fragment-index="1" -->
* masterにマージしてから色々こけたのが分かるのより効率が良い。 <!-- .element: class="fragment" data-fragment-index="2" -->

---

** Travis CIの話をしてきましたが... **

---

** それJenkinsでもできるよ **

![jenkins_angry](./materials/ci-tips/jenkins_angry.png)<br>

---

** GitHub Pull Request Builder Plugin **

[Pluginのページ](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin)

---

** 何が出来るかというと (ざっくり) **

* Pull Requestができたらスクリプト実行 <!-- .element: class="fragment" data-fragment-index="1" -->
* 試しにマージしてスクリプト実行 <!-- .element: class="fragment" data-fragment-index="1" -->
* 通ったらPull Requestにお知らせしてくれる！ <!-- .element: class="fragment" data-fragment-index="2" -->

---

** こんなんなります **

![pr_builder](./materials/ci-tips/pr_builder.png)<br>

---

** 試してみたらいかがかな！ **

---

Thank you!

>>>

[Back to table of contents](./index.html)
