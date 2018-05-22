# Google I/O 2018 まとめ

* 以下のトピック一覧は GIGAZINE の[本記事](https://gigazine.net/news/20180511-google-io-2018-announcements/)を元に作成
* 訳が怪しそうなところは [Google Blog に掲載の原文](https://www.blog.google/topics/developers/all-io18-announcements/)を元に赤塚が修正、解説、解釈を入れてます

## Google Assistant と Google Home について
* Google Assistantの声を6種類から選択可能になる
* 新しい声の中には[ジョン・レジェンド](https://ja.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%B3%E3%83%BB%E3%83%AC%E3%82%B8%E3%82%A7%E3%83%B3%E3%83%89)のものもある
* Google Assistantの会話はAIと[WaveNet](http://gigazine.net/news/20171005-wavenet-launch-in-google-assistant/)により人間らしさが増す
* いちいち「Hey Google」を言わなくても、一連の流れで会話を認識してくれるようになる
* 「ニューヨークとオースティンの天気はどうですか？」という風に、複数の要求を一度に受け付けられるようになる
* Custom Routines を利用することで、「朝食の準備ができました」「夕食の準備ができました」と言えば、食事に合わせて音楽を流すといった操作が可能
* 特定の日や時間にルーチンをスケジュールすることができる
* 過去2カ月で、家族とその子どもがGoogle AssistantやGoogle Homeを通して13万時間もの会話を行った
* 2018年後半に「Pretty Please」をリリースし、小さな子どもでも Google Assistant や Google Home を使用可能になる
  * [A Google Assistant update will teach kids to say 'please' | TechCrunch](https://techcrunch.com/2018/05/08/a-google-assistant-update-will-teach-kids-to-say-please/)
  * Google Assistant に対して横柄な言葉遣いをしちゃう子供が割といるようで、親御さんの心中察するに余りある
  * なので、丁寧な言葉遣いをしたら丁寧な言葉遣いで返してくれるようになるらしい
  * 「please」をつけてお願いすると、「ご丁寧にありがとう (thanks for asking so nicely)」とか「とても丁寧な方ですね (You're very polite)」って返してくれたりするらしい
* ディスプレイ付き Google Assistant は 2018 年夏から利用可能
* スマートフォンでの Google Assistant を再設計。Google Assistant との交信記録や場所、時間などを用いて一日の snap shot (ダイジェスト的な？) を出してくれるらしい
* 2018年後半から、Google Assistant アプリで食料品の配達をお願いできる
* Google Assistant がナビに統合される。ユーザーはハンズフリーでテキストメッセージの送信や音楽かけたりできる。
* [Google Duplex](http://gigazine.net/news/20180509-google-duplex-ai-phone-system/)は 2018 年夏にテストを行い、AI が自動で電話をかけてくれるようになる
* Google Assistant は2018年末までに 80 カ国で使用可能
* Google Home はスペイン、メキシコ、韓国、オランダ、デンマーク、ノルウェー、スウェーデンなど 7 カ国以上で導入される予定

## AIと機械学習について
* まもなくGmailの[Smart Compose](https://blog.google/products/gmail/subject-write-emails-faster-smart-compose-gmail/)が導入され、メール作成がAIによりサポートされる
  * Smart Compose はユーザが入力する文章を予測して、次に入力されそうなフレーズを提案する機能。
  * [「Gmail」、AIが返信を予測入力する「Smart Compose」を導入へ - CNET Japan](https://japan.cnet.com/article/35118847/)
* Googleが提供する[機械学習キット(ML Kit)](https://developers.googleblog.com/2018/05/introducing-ml-kit.html)は多くの開発者たちにとって有益
* 機械学習専用の第3世代プロセッサ[「TPU3.0」](https://gigazine.net/news/20180510-google-tpu-3-ai-processor/)を発表
* GoogleはAIにより医療の発展に貢献している
  * [Deep Learning で患者が次にどうなるかを予測する話](https://ai.googleblog.com/2018/05/deep-learning-for-electronic-health.html)
* AIは[Waymo](http://gigazine.net/news/20161214-self-driving-car-project-waymo/)の自動運転カーに使用され、雪や霧といった環境でも運転可能にする

## Androidについて
* Android Pのベータ版を発表
  * [Android P: Packed with smarts and simpler than ever (公式ブログ)](https://blog.google/products/android/android-p/)
  * [GIGAZINE の何となく日本語訳っぽい記事](http://gigazine.net/news/20180509-android-p/)
* Deep Mindと連携してバッテリーを優先順位をつけて割り当てるAdaptive Batteryを開発
* Android Pは周囲の環境に合わせて明るさを自動調節する
  * (原文) Adaptive Brightness in Android P learns how you like to set the brightness based on your surroundings, and automatically updates it to conserve energy. 
  * 周囲の明るさに対して持ち主がどの程度の明るさを好むか学習してくれる、電池持ち改善のために、みたいな意味か。
* App Actions により、「ヘッドフォンを指したら Spotify を起動」という風に次のアクションを予測
  * [App Actions | Android Developers](https://developer.android.com/guide/actions/)
  * 色んなところでアプリの起動を促されるようになる模様。下の操作性向上とも関連。
* 操作性の向上
  * (原文) Actions will also show up throughout your Android phone in places like the Launcher, Smart Text Selection, the Play Store, the Google Search app and the Assistant.
  * App Actions によって、ランチャー、テキスト選択、グーグル検索したりってところでもアプリ起動のサジェストが行われるようになる、ってことかと思われる。
  * 検索窓に文字を打ったら検索候補と共に起動可能なアプリの一覧が表示されたり、テキスト選択で Spotify が起動の候補に出たりする、みたい。
* Slices機能により、インタラクティブな情報検索を可能にする
  * [Slices | Android Developers](https://developer.android.com/guide/slices/)
  * Google 検索 (そのうち Google Assistant も) の画面に、アプリの UI の一部を表示できるようになる機能だそうな
  * 「今日の株価」的なものを検索したときに、検索結果の中に株アプリの画面が出る的な
  * Google Assistant で「天気教えて」って言った時に気象庁へのリンク貼られるんじゃなくてその場で天気アプリの一部の画面が表示される的な
  * 既にビルドできるらしいぞ (2018/05/22 現在)
* 仕事に必要なアプリを一カ所にまとめて表示
  * 「仕事」タブのようなものを生やすことが出来て、押すと仕事で使うアプリが一覧されるみたいな話
  * ツイッターは仕事で使いますかね
* Android Pでホームから上にスワイプすると最近使ったアプリが表示される (Overview)
  * 「最近使ったアプリ一覧を出す機能」が新デザインでやってきた、という話の模様
  * ホームボタンを上にスワイプする、ってモーションで呼び出すみたいっす
  * それに伴って (？) アプリ履歴ボタンはなくなる。見たところ戻るボタンもなくなる。ホームボタンだけに。
  * ホームボタンを横にスワイプするだけでアプリを切り替えられるようなことも書いてそうな気がする。
* なんと Overview 表示中にテキスト選択できる
  * もちろんそこから選択した文字をコピーしたり App Actions によるアプリ起動したりといったことができる
* Quick Settings (画面上から引っ張ると出てくるあれ) が刷新。
  * スクリーンショットとるのに vulcan grip (わしづかみ？) しなくてよくなる、編集もいい感じにできるようになるってよ
  * 音量の調節がよりシンプルに、通知の設定とかもいい感じになるってよ
* Technology should help you with your life, not distract you from it. Android P comes with digital wellbeing features built into the platform.
  * 何を言ってんのか
* Dashboard 機能。ユーザーがどのようにスマートフォンを使ったのか一目でわかる情報を表示
  * どんだけどのアプリを使ってたか、どんだけ画面を unlock したか、どんだけ通知を受け取ったか、みたいなことが分かるそうな
* App Timer 機能。アプリに時間制限を設定可能
  * 所定の制限時間がくるとなんかお知らせしてくれるらしい
* DND (Do Not Disturb) モードは着信とかお知らせはもとより、ポップアップなど視覚的に気をそらす表示を抑制する
* スマートフォンをテーブルに伏せて置くと、自動で DND モードに切り替わる
* DND モードにするとメッセージアプリの状態を「離席」にすることができるような API が提供される
* Wind Down 機能
  * 就寝時間を設定すると自動的にナイトライトモード (暖色になるみたいな？) に切り替わる
  * だんだんグレースケールになっていって寝るしかなくなる
* セキュリティの強化
  * (原文) Android P is packed with security and privacy improvements updated security protocols, encrypted backups, protected confirmations and more.   
* Android P Beta は Sony Xperia XZ2、Xiaomi Mi Mix 2S、Nokia 7 Plus、Oppo R15 Pro、Vivo X21、OnePlus 6、Essential PH-1 で利用可能

(以下、赤塚未確認)

## Android TV、Android Auto、Wear OSについて
* GoogleはHarmanと協力してGoogle AssistantのスピーカーとAndroid TVを提供するハイブリッドデバイスを立ち上げた
* 開発者用の限定版Android TVドングルデバイスADT-2をリリース
* Android Autoは現在、400台を超える自動車とアフターマーケットのステレオをサポートするために、50以上のOEM先と協力
* Android搭載のボルボ車はGoogle マップなどと連携
* Wear OSによりスマートウォッチからさまざまな操作が可能
* スマートウォッチからWear OS対応のGoogle Assistantを利用できる
* スマートウォッチに話しかけるだけで、Bluetoothイヤホンやスピーカーを通し今日の予定を知ることが可能
* Wear OS対応のスマートウォッチにより、人生がよりスムーズになる

## Google マップについて
* Googleは220カ国以上で2,100万マイル(約3300万キロメートル)以上の地図を作成し、数億の企業を地図に載せ、世界中の10億人以上の人々がGoogle マップにアクセス可能
* Google マップをより個人向けにカスタマイズできるようになる
* 地元の専門的な情報にもアクセス可能
* アプリ内でチャットグループを作り、行き先を決定可能
* ユーザーの好みに応じてオススメの店舗などを紹介
* ユーザーの行動に速やかに反応し、適切に道案内してくれる

## Googleフォトについて
* 機械学習によりGoogleフォトの写真を明るくしたり、文書の写真をPDF化できる
* Googleフォトは被写体の背景を白黒に編集可能
* 白黒の写真をカラーにすることができる
* Googleフォトパートナープログラムを発表し、開発者たちがより迅速に写真やムービーにアクセス可能

## Googleニュースについて
* 新しいGoogleニュースはAIを駆使し、一連のニュースを時系列で表示してくれる
* ユーザーの好みにカスタマイズし、興味を引きそうなニュースを表示する機能を搭載
* 一つのニュースから簡単により詳しい情報にアクセス可能
* ビジネス・科学・スポーツなど幅広いニュースを提供してくれる
* Googleアカウントから購読可能

## VRとARについて
* Google Lensに写した文字のテキスト変換が可能になる新機能が追加
* カメラを通してGoogle Lensが認識した特定の家具や装飾品に関するレビューなどの情報を表示可能
* Google Lensはリアルタイムで識別した物についてさまざまな情報を伝えてくれる
* LGE、Motorola、Xiaomi、Sony Mobile、HMD/Nokia、Transsion、TCL、OnePlus、BQ、Asus、Google PixelといったデバイスからGoogle Lensが使用可能
* Google Lensは英語だけでなくフランス語・イタリア語・ドイツ語など多くの言語に対応
* Tour Creatorで誰もが360度のVRツアーを構築可能
* SceneformによりJava開発者は容易に没入型の3Dアプリケーションを開発できる
* Cloud Anchor APIを導入して、自宅を改装したり壁にペインティングしたりすることでAR体験が可能
* ARCoreに垂直平面検出機能が追加される
* Augmented Images(拡張イメージ)機能により、画像を実物のように変換可能

## YouTubeについて
* YouTubeのモバイルアプリをアップデートし、一定の時間が経過したら休憩を取るようにリマインダ可能になる
* YouTubeアプリからの通知を無音にすることが可能
* 複数の通知をまとめて1回の通知にすることができる
* YouTubeで過ごした時間を見ることが可能

## アクセシビリティについて
* Lookoutアプリは視覚や聴覚に障害がある人を助ける
* キーボードアプリGboardにモールス信号入力機能を導入

## Google Playと開発者ツールについて
* Google Play Instantはすべてのゲーム開発者に公開された
* Google Play Consoleの機能を更新することで、アプリのパフォーマンスが改善
* Android Jetpackは開発者が簡単にAndroidアプリを開発できるようにする
* Android KTXはKotlin使用者に最適化
* Android App BundleはAndroidアプリを公開するための新しいフォーマットである
* Android Studio 3.2の最新リリースでは、開発者が迅速にアプリを開発可能にする機能が追加
* アプリを実行するために必要なコードとリソースのみをダウンロードし、ダウンロード時間を短縮
* Android Things 1.0を使用して、開発者はAndroid Thingsプラットフォームを使用して商用IoT製品を構築し、出荷することができる
* Firebaseでのアプリパフォーマンス監視を改善
* 数カ月以内にFirebase Test LabにiOSを追加し、AndroidやiOS両方で高品質なアプリを開発可能
* モバイルアプリSDKの最新バージョンFlutter Beta 3をリリース
* Android拡張ライブラリAndroidXの初期プレビューを開始
* ChromebookでLinuxアプリを実行可能になる
* Material Themingは製品全体をより統一的に構築可能
* Material Theme Editorにより、、ワークフローを合理化し、設計と開発の共通点を解決
* オープンソースのMaterial Componentsを使用して、アプリのデザインをカスタマイズ可能

## 広告について
* 開発者はアプリ内の関連コンテンツを広告内に表示し、ユーザーに役立つ情報を提供できる
* ゲーム開発者はUniversal Appキャンペーンを使用して潜在的なユーザーにアプローチし、ユーザーは広告から直接ゲームを試すことが可能
* 開発者はview through conversion (VTC) reportingにより、広告の有効性を確認できる
* 開発者は広告から得られる報酬についての詳細を知ることができ、微調整可能
* 広告バナーなどを販売する開発者は、IAB Tech Lab’s Open Measurement SDKを使用してより簡単に広告主にレポートを送信できる
