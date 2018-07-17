# ところで GopherJS について

Go を JavaScript にトランスパイルすると言えば GopherJS がありますね。 

<a class="embedly-card" data-card-controls="0" href="https://github.com/gopherjs/gopherjs">gopherjs/gopherjs</a>
<script async src="//cdn.embedly.com/widgets/platform.js" charset="UTF-8"></script><Paste>

* 細かくは本日は触れませんがなかなかパッション溢れるプロダクト
  * 開発者は Richard Musiol さん
  * Richard Musiol さんは Go の wasm サポートの開発者でもある
  * 最近は wasm の方に熱心で GopherJS はあまりやってない模様
  * 公式ではないということもあり、しばしばバグる
* Go の言語機能は全てサポートと言っている (goroutine、channel、GC、等)
  * ただ、goroutine、mutex、channel を使えば使うだけ遅くなるという話を聞く...
  * パフォーマンスを求めるのであればこれらの言語機能を使わないという選択も必要



