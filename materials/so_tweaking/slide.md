shared object tweaking
=======================

** shared object の名前を変更する TIPS **

<img src="./materials/android_grpc_golang/21.png" width="90" style="background:none; border:none; box-shadow:none;">

赤塚洋介 (34)

>>>

[Back to table of contents](./index.html)

---

shared object の名前を変更するときに、  
気をつけることを書きます。

---

** 目次 **

* shared object とは
* 顧客案件の紹介
* 顧客からの要望
* (0) ダメな書き換え方
* (1) so を作るときに対処する
* (2) so を作った後に書き換える - patchelf
* (3) static library から作る

---

** shared object とは **

* 説明するまでもないかもしれないですが、  
一応超ザックリ紹介。

>>> 

* shared object とは、linux 環境における動的リンクライブラリ。
* windows の dll、mac の dylib と位置づけは同じ。
* プログラム (実行バイナリ) 実行時に読み込んで使う。

>>>

* 拡張子 .so のファイルと、  
バージョンを示すシンボリックリンクで構成される（ことが多い）。

```
libprotoc.so -> libprotoc.so.13.0.2
libprotoc.so.13 -> libprotoc.so.13.0.2
libprotoc.so.13.0.2 ← これが実体
```

---

** Android アプリ開発における Shared Object の扱い **

* 「C/C++ でソースを書いて ndk-build する」みたいなときに扱う必要が出てくる。
* そうでない限りはあまり意識しなくて良い。

---

** 顧客案件紹介 **

* Android が載ってる STB に CA サーバを乗せる案件。
* 弊社は、顧客から指定されたツールチェイン (ARM) を用いてビルドを行い、**ライブラリ一式** 等を提供する。
* **ライブラリ一式** の大部分は Shared Object の形で提供。

>>>

** 顧客からの要望 **

* shared object をシンボリックリンク構成でなくしてほしい <!-- .element: class="fragment" data-fragment-index="1" -->
* その上で、ファイル名を一律変更してほしい  <!-- .element: class="fragment" data-fragment-index="2" -->

>>>

* わし「(簡単やろ) 承りましたー」
* ということで shared object 書き換えの作業を始めたのであった...  <!-- .element: class="fragment" data-fragment-index="4" -->

---

** TIPS (0) まず、ダメな書き換え方 **

* ライブラリ一式について、単純にファイル名を変更する。
* 結果：ビルドできなくなる。もしくは実行不可なバイナリになる <!-- .element: class="fragment" data-fragment-index="1" -->

>>>

極簡単な解説

* shared object には soname というのが埋め込まれている。
* soname にはライブラリのバージョンが埋め込まれて、互換性を保つための役割を持っている。
* 実行バイナリはビルド時にリンク対象のライブラリに埋め込まれている soname を確認し、実行時にどのライブラリを読み込みにいくかを保持している。
* ファイル名を変えても埋め込まれた soname は変わらないので、実行時にライブラリ読み込みに失敗するようになってしまう。

>>>

```
readelf -a "ライブラリ.so"
```
* とやると、soname を確認できます。
* soname に関する詳細は長大になるので割愛します…！

---

** TIPS (1) shared object を作る時に対処 **

* もっとも妥当な方法 (と思われる)。

```
$ gcc -shared -Wl,-soname=libacs.so.1 -o libacs.so.1.0.0 acs.o
```

* soname もファイル名も指定できる！<!-- .element: class="fragment" data-fragment-index="1" -->

>>>

* この手法は「可能であれば」もっとも安牌かと思われます。
* ただし、かならずしも簡単に適用できるとは限らない。

>>> 

厳しい例

* OSS のビルド等のとき、外部から与えるパラメータでは、soname、ファイル名までケアできないものもある <!-- .element: class="fragment" data-fragment-index="1" -->
* だとしたらもう直接 OSS のビルドを書き換えていく…？辛くない…？ <!-- .element: class="fragment" data-fragment-index="1" -->

--- 

** TIPS (2) patchelf **

* できれば OSS のビルド環境に手をいれたくない赤塚は、ツールを探す旅に出ました。

>>>


* そして見つけました！ → [NixOS/patchelf](https://github.com/NixOS/patchelf)
* shared object の中身を書き換えることができるツール
* v0.9 から soname の書き換えもできる！

>>>

以下のような作業を実施した。

* mv、cp を駆使して shared object の名前を変更する
* 名前の変更に追従するように各 shared object の soname を変更する
* 結果：ビルド通るし実行も出来る！勝った！
* しかし悲しいことが起こった... <!-- .element: class="fragment" data-fragment-index="1" -->

>>>

* [NixOS/patchelf issue#8 Test fail on Fedora ARM](https://github.com/NixOS/patchelf/issues/8)
* つまり patchelf は ARM 向け shared object の書き換えに対応していない。  
(本 issue は 2013 年に起票され、現在まで未対応)
* 私は実機上での動作確認を怠ったため、顧客側にて「起動時にクラッシュする」というご報告をいただくことに...。
* 大変申し訳ございません...！ <!-- .element: class="fragment" data-fragment-index="1" -->

---

** TIPS (2) static library から shared object を作る **

* 結局、この手法を採用しました。

>>>

* 各種 OSS は、soname やファイル名の書き換え設定はできなくても、static library を吐き出す設定くらいはできる。
* 一律、一度 static library を出しておいて、それらを shared object に変換する作戦。

>>>

* こんな感じで変換する。

```
$ gcc -Wl,--whole-archive -shared -o librenamedacs.so -Wl,-soname,librenamedacs.so ./libacs.a -Wl,--no-whole-archive
```

* 今度こそ勝ちました...！ <!-- .element: class="fragment" data-fragment-index="1" -->

---

** まとめ **

* shared object の名前変更は少しハマりどころがあるので、やるときは気をつけて
* ちゃんと動作確認しようね…！ (戒め)

---

<img src="./materials/android_grpc_golang/25.png" style="background:none; border:none; box-shadow:none;">

>>>

[Back to table of contents](./index.html)
