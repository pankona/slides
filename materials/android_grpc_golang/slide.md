gRPC vs gomobile
=======================

** 例えば gRPC を Go 言語との Binding として使う **

<img src="./materials/android_grpc_golang/21.png" style="background:none; border:none; box-shadow:none;">


赤塚洋介 (34)

>>>

[Back to table of contents](./index.html)

---

** 目次 **

* ここまでのあらすじ
* gomobile の紹介
* gomobile の不便な点
* gRPC で代替してみる
* gRPC とは
* 実際やってみた
* 速度を計ってみた
* まとめ

---

** ここまでのあらすじ **

>>>

よくあるシチュエーションとして…  
Android/iOS 両対応が求められるアプリを作るときに、  
C/C++ でロジックを書いておいて両プラットフォームに流用できるようにしとく作戦  

あると思います。

>>>

しかし C/C++ でやるのヤダ…

>>>

*そこで Go 言語ですよ！*

<img src="./materials/android_grpc_golang/01.png" style="background:none; border:none; box-shadow:none;">

---

** gomobile の紹介 **

* Go 言語で書いたソースを  
Android/iOS で使える形にビルドしてくれるツール
* go のソースから一気に aar を作ってくれる！
  * C/C++ で書いてた JNI も書かなくて良い  
  (自動で生成される)

---

** gomobile の不便な点 **

Java 側に expose できる型が少ない…  
* integer
* boolean
* byte (の配列)
* string

**○○の配列、とかを指定できない。**

---

** gRPC で代替してみる案 **

* もう少し扱える型に柔軟性を持たせることはできないか…
* HTTPサーバクライアントにすればできそうだが、立て付け考えるのが手間…

* gRPC なら両立できそうな気がした！ <!-- .element: class="fragment" data-fragment-index="1" -->

---

** gRPC とは **

>>>

[詳しくは Web で！(公式ページ)](http://www.grpc.io/)

>>>

** gRPC 概要 **

* RPCフレームワーク by Google
* 2015年2月に発表。割と最近。
* gRPC Client/Server が存在していて、互いにやり取りする形の RPC。
* 通信に HTTP2 を使う。

>>>

** gRPC 概要 **

* protocol buffers の書き方でサービスを定義する  
(proto ファイル) 。
* やりとりするデータは protocol buffers でエンコードされる。
* 各言語向けにクライアント/サーバのソースを自動生成する仕組みがある。  
(C++, Java, Go, Python, Ruby, Node.js, Android Java, C#, Objective-C, PHP)
* クライアントとサーバは別言語で実装するのも容易。

>>>

** proto ファイルの例 **

```
syntax = "proto3";

package helloworld;

service Greeter {
	rpc SayHello (HelloRequest) returns (HelloReply){}
}

message HelloRequest{
	string name = 1;
}

message HelloReply {
	string message = 1;
}
```

型が書ける！ <!-- .element: class="fragment" data-fragment-index="1" -->

>>>

通信の方向は4種類  
(proto ファイルでどれを使うか書いていく)

* Simple
* Server-side streaming
* Client-side streaming
* Bidirectional streaming

>>>

型は int 諸々、boolean、string の他に、

* enum
* repeated で配列に
* map でマップに
* oneof で排他に

---

** 実際やってみた **

>>>

構成

<img src="./materials/android_grpc_golang/grpc.svg" style="width:250px; background:none; border:none; box-shadow:none;">

* Go ... gRPC サーバ
* Java ... gRPC クライアント

>>>

proto ファイル

```
syntax = "proto3";

option java_multiple_files = true;
option java_package = "io.pankona.stringservice";

package stringservice;

// The Supervisor service definition.
service StringService {
  rpc GetLargeString (Empty) returns (LargeString) {}
}

message Empty {
}

message LargeString {
    repeated string string_list = 1;
}
```

String の配列を渡す API を定義

>>>

Java (クライアント側) のソース (一部抜粋)

```
public class GRPCClient {
    ManagedChannel m_channel;
    StringServiceGrpc.StringServiceBlockingStub m_stub;
    public GRPCClient(int port) {
        m_channel = ManagedChannelBuilder.forAddress("localhost", port)
                .usePlaintext(true)
                .build();
        m_stub = StringServiceGrpc.newBlockingStub(m_channel);
    }

    public List<String> getString() {
        Empty e = Empty.newBuilder().build();
        LargeString largeString = m_stub.getLargeString(e);
        return largeString.getStringListList();
    }
}
```

>>>

Go (サーバ側) のソース (一部抜粋)

```
func (server *gRPCServer) GetLargeString(context.Context, *stringservice.Empty) (*stringservice.LargeString, error) {
	largeStringGRPC = &stringservice.LargeString{
		StringList: []string{
            "aaa",
            "bbb",
            "ccc",
        },
	}

	return largeStringGRPC, nil
}
```

Go 側はこれの他に  
サーバ起動とシャットダウンのための処理を実装。

>>>

* (動いてるところ見せられなくて地味ですが)   
これで動きました。
* Java、Go 共にあんまり書かないで済んでしまう。
* 実装はとても簡単という印象。

---

** 速度を計ってみた **

通信が絡むので遅いんじゃないかと思い、  
速度を計ってみました。

>>>

** ルール **

* Java 側から Go 側の API (gRPC/Binding) を呼び出して string の配列を取得する。
  * 1000 要素ある string (256 byte 長) の配列を n 回取得して速度を測定する。

* Go バインディングは文字列の配列を返却できないので、JSON Array で代替する。
  * Unmarshal はしない
* gRPC は 文字列の配列を返す。

* 何回か計って平均を計算する。

>>>

こんな感じでした (時間の単位は ms)。  
(使った端末は Nexus 9)。


|      n|  1|  10|   100|   1000|   10000|
|-------|---|----|------|-------|--------|
|Binding|  4|  52|   275|  2,604|  26,101|
|gRPC   | 89| 198| 1,556| 14,553| 144,797|

gRPC まあまあ遅い <!-- .element: class="fragment" data-fragment-index="1" -->

---

** まとめ **

* gRPC を使うことで gomobile bind を使うより型に自由度が出て良い。
* 実装もそれほど難儀ではない (が慣れが必要)
* あんまり激しく使う場合はパフォーマンスが気になるかも...

---

以上です！

>>>

今日試したソースは[ここ](https://github.com/pankona/grpc_go_android)に置いてます。

---

<img src="./materials/android_grpc_golang/25.png" style="background:none; border:none; box-shadow:none;">

>>>

[Back to table of contents](./index.html)
