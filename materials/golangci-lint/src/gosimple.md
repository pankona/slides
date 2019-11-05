# gosimple

Linter for Go source code that specializes in simplifying a code

## 何をチェックしてくれる？

特定のパターンの冗長なコードを発見したら怒ってくれる

```go
// これは冗長
// 単一の channel のために select は要らぬ
func jouchou(ch chan int) {
	select {
	case x := <-ch:
		fmt.Println(x)
	}
}

// これがシンプル
func simple(ch chan int) {
	x := <-ch
	fmt.Println(x)
}
```

```go
// これは冗長
if <expr> {
    return true
}
return false

// これがシンプル
return <expr>
```

ここに挙げた例以外にも色々チェックしてくれるぞ

## 僕の感想

- 案外気づきにくいところも指摘してくれて嬉しい
