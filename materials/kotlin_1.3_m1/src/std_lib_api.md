# New Standard Library APIs

## SuccessOrFailure

* SuccessOrFailure という inline class。
* _It has been introduced to allow for capturing the result of a function execution, whether successful or not, in order to process it at a later time._
  * 関数の実行結果 (成功か失敗) を後で使うために、いったんキャプチャしておける仕組み

```kotlin
val files = listOf(File("a.txt"), File("b.txt"), File("42.txt"))
val contents: List<SuccessOrFailure<String>> = files.map { runCatching { readFileData(it) } }

println("map successful items:")
val upperCaseContents: List<SuccessOrFailure<String>> = 
    contents.map { r -> r.map { it.toUpperCase() } } 
upperCaseContents.printResults()

println()
println("map successful items catching error from transform operation:")
val intContents: List<SuccessOrFailure<Int>> = 
    contents.map { r -> r.mapCatching { it.toInt() } }
intContents.printResults()
```

上記のコードを実行すると以下のような出力。

```bash
map successful items:
Failure: java.lang.Exception: No such file: a.txt
Success: FILE B.TXT CONTENT
Success: 42

map successful items catching error from transform operation:
Failure: java.lang.Exception: No such file: a.txt
Failure: java.lang.NumberFormatException: For input string: "File b.txt content"
Success: 42
```

## Multiplatform random number generator

* Kotlin/JVM だけなら乱数生成は特に問題なかった
* マルチプラットフォーム対応のために `Random` という抽象クラスを導入する

```kotlin
val number = Random.nextInt(limit)  // number is in range [0, limit)
```

## Companion object for Boolean type

* `Int` とか `String` には companion object が生えているのに `Boolean` には生えていない
  * `Boolean.javaClass` ができない
  * これをできるようにしようぜ、という話

## New constants in companion objects of basic types

* `Byte`、`Short`、`Int`、`Long`、`Char` に `SIZE_BITS` と `SIZE_BYTES` が生える
* `Char` に `MIN_VALUE (\u0000)` と `MAX_VALUE (\uFFFF)` が生える

## `isNullOrEmpty` and `orEmpty` extensions

* `isNullOrEmpty` と `orEmpty` 自体は既にある
* 今回の追加は以下。
  * `isNullOrEmpty` が collection に対して使えるようになる
  * `orEmpty` が sequences に対して使えるようになる


