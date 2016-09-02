Jenkins+Dockerで<br>ちょっと便利なCI生活
=======================

<img src="./materials/docker_for_ci/jenkins_logo.png" style="background:none; border:none; box-shadow:none;">
<img src="./materials/docker_for_ci/docker_logo.png" style="background:none; border:none; box-shadow:none;">

赤塚洋介 (33)

>>>

[Back to table of contents](./index.html)

---

私が関わった最近の案件の特徴

* リポジトリ1個でビルドターゲット複数
  * 1) linux (32bit、64bit、いずれもx86)、iOS、Android
  * 2) Windows、linux (x86 32-bit、arm でクロスコンパイル)

** CI 作るの結構たいへん <!-- .element: class="fragment" data-fragment-index="1" --> **  
** 特に 32bit のやつ <!-- .element: class="fragment" data-fragment-index="1" --> **

---

** 構成が多岐に渡ると構築が面倒 **

* 必要な数だけ Virtual Box を用意してもよかったけど色々キツイ
* そこで、AVDS 上に 32bit 環境を用意するために Docker 使ってみた

<img src="./materials/docker_for_ci/jenkins_angry.png" style="background:none; border:none; box-shadow:none;">
ぐぬぬ…

---

** Docker っていうのは **

* 簡単に雑に言うと
  * 機能としては、軽量な Linux VM（← 語弊あるけど）
  * ファイルシステムの雛形をイメージと呼び、それを使って作る実行環境をコンテナって呼ぶ
  * イメージは dockerhub においてある (32-bit イメージもある) 。自分でも作れる。

>>> 

<img src="./materials/docker_for_ci/docker01.jpg" style="background:none; border:none; box-shadow:none;"><br>
docker イメージ図 Virtual Box 等との違い

--- 

** Docker の特徴 **

* 立ち上がりが高速
* コンテナは使い捨てする
* 容量あんまり食わない
* 環境上にインストールしておきたい必要なソフトウェアは<br>Dockerfile に書いておいて自動で構築

** いつもクリーンな環境が用意できるので、<br>ビルド確認・テスト実行なんかをやるのにとても良い！ <!-- .element: class="fragment" data-fragment-index="1" --> **

>>>

** Dockerfile の例 **

```
FROM pankona/xenial-32bit:latest

ENV http_proxy http://10.5.134.56:8080
ENV https_proxy http://10.5.134.56:8080
ENV DEBIAN_FRONTEND noninteractive

RUN gpg --keyserver keyserver.ubuntu.com --recv 3E5C1192
RUN gpg --export --armor  3E5C1192 | sudo apt-key add -

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN apt-get -q update --fix-missing

RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-lxc/lxd-stable

RUN apt-get -q update --fix-missing

RUN apt-get -y install build-essential
RUN apt-get -y install sudo
RUN apt-get -y install git-core
RUN apt-get -y install cmake
RUN apt-get -y install ccache
RUN apt-get -y install golang

RUN mkdir /workspace

ADD ./ext/DirectFB-1.7.7.tar.gz /tmp/
RUN cd /tmp/DirectFB-1.7.7 && \
    ./configure --with-gfxdrivers=none && \
    make && \
    make install

ENTRYPOINT ["/bin/bash", "-c"]
```

---

** 所感 **

* 割とうまく動いている...！
* Docker が動くところであれば何でもスレーブにできてスケールさせやすい
  * Mac でもそんじょそこらの AVDS でもスレーブになれる
  * Windows は…
* ビルドに必要なパッケージが明確になる
* ビルド環境が汚れない
  * 「オレの環境ならビルドできるのに…」<br>みたいなことが起こらない

---

** より信頼感のある CI 環境に！ **

<img src="./materials/docker_for_ci/jenkins-docker.png" style="background:none; border:none; box-shadow:none;"><br>
なった気がする

** 試してみたらいかがかな！ <!-- .element: class="fragment" data-fragment-index="1" --> **

---

<img src="./materials/docker_for_ci/gopher_25.png" style="background:none; border:none; box-shadow:none;">

>>>

[Back to table of contents](./index.html)
