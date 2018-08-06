# Experimental language features

## Inline classes

* コンパイル時に型変換みたいなことをしてくれる作業。
* 以下のように書くと、`Name` というシグネチャで `String` を扱うという意味。型エイリアス的な。

```kotlin
inline class Name(internal val value: String)
```

* 型エイリアスと違うのは、assignment における型の互換性
  * inline class を用いる場合、左辺と右辺の型が合わなかったら代入できない
  * 型エイリアスを用いる場合、左辺と右辺の型が実質同じであれば代入できる


## Unsigned integer types

* Unsigned なやつが追加になる。
* コード例は以下のような感じ。

```kotlin
val operand1 = 42
val operand2 = 1000 * 100_000

val signed: Int = operand1 * operand2
val unsigned: UInt = operand1.toUInt() * operand2.toUInt()
```

* リテラルとして使う場合は以下のような感じになる模様。
  * 語尾に `u` とか `uL` をつける

```kotlin
val uintMask = 0xFFFF_FFFFu
val ulongUpperPartMask = 0xFFFF_FFFF_0000_0000uL

const val MAX_SIZE = 32768u

const val MAX_SIZE_BITS = MAX_SIZE * 8u // Error in 1.3-M1
```

## Annotations for marking an experimental API and opting-in for it

* この API は Experimental だよ！を表すアノテーションが追加される
  * library 作成者向け。
  * Experimental を承知で使うよ、を Opt-In 形式で表明すると Experimental な API が使えるようになる。
    * Opt-In なしに使おうとすると警告がでるようになる。
    * I understand that I'm using an experimental declaration that may break at any time.


