# New features

## Coroutines are graduating to stable

* Coroutine がより安定化する！
* 1.2 のころは一応 experimental だった。
* 1.2 で既に coroutine 使っている場合、1.3 を用いる際には多少のマイグレーションが必要
  * パッケージ名とかクラス名とか多少変わる模様

## Capturing when subject in a variable

* when を使うときに変数をキャプチャできるようになる
  * ちなみに if 文でも同じことやりたい！っていう要望も出ているらしい。
* 地味だが便利っぽい。以下のようなコードが書ける。

```kotlin
fun Request.getBody() =
    when (val response = executeRequest()) { // 以前はこう書けなかった
        is Success -> response.body
        is HttpError -> throw HttpException(response.status)
    }
```

```kotlin
fun main(args: Array<String>) {
    val hoge = Hoge("hagehage")
    val res = when(val hage = hoge.toStr()) { // 以前はこう書けなかった
        "hage" -> "hage"
        "hagehage" -> "hage"
        else -> "else"
    }
    println(res)
}

class Hoge(val value : String) {
    fun toStr() = value
}
```

## @JvmStatic and @JvmField in companions of interfaces

* @JvmStatic と @JvmField が interface の companion 部分にも使えるようになる
* このアノテーションは、Kotlin で書いたコードを Java から呼び出すときに、ちょっとお手軽に呼べるようになるアノテーションだよ

```kotlin
interface Service {
    companion object {
        @JvmField
        val ID = 0xF0EF

        @JvmStatic
        fun create(): Service = ...
    }
}
```

## Nested declarations in annotation classes

* annotation クラス内に annotation クラスが書けるようになる
* 以前、annotation クラスは body を持つことができなかった
* 以下のようなコードが書けるようになる。

```kotlin
annotation class Outer(val param: Inner) {
    annotation class Inner(val value: String)
}
```

```kotlin
annotation class Annotation {
    companion object {
        @JvmField
        val timestamp = System.currentTimeMillis()
    }
}
```

## Functional types of higher arity

* Function 型 (a.k.a FunctionN) は 22 までしかなかったのが 255 まで使えるようになる



