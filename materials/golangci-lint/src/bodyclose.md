# bodyclose

checks whether HTTP response body is closed successfully

## 何をチェックしてくれる？

HTTP 通信で降ってくる Response の Body の閉じ忘れがあると怒ってくれる

```go
// 怒られる例

resp, err := http.Get("http://example.com/")
if err != nil {
	// handle error
}
body, err := ioutil.ReadAll(resp.Body)
```

```go
// 怒られない例

resp, err := http.Get("http://example.com/")
if err != nil {
	// handle error
}
defer resp.Body.Close() // ここで Body.Close を呼んでいるので合法
body, err := ioutil.ReadAll(resp.Body)
```

## 僕の感想

- `resp.Body` の `Close` し忘れはめっっっっちゃよく見る (僕も忘れる)
  - そもそも閉じなきゃいけないものだっていう認識が最初はなさそう
- 強制的に「`resp.Body` は閉じないと駄目なものだ」って分からされる良い linter
