# gocyclo

Computes and checks the cyclomatic complexity of functions

## 何をチェックしてくれる？

関数の循環性複雑度がしきい値を超えると怒ってくれる

## 補足 - 循環性複雑度の計算

```
// gocyclo の README.md から抜粋

1 is the base complexity of a function
+1 for each 'if', 'for', 'case', '&&' or '||'
```

つまり `if`、`for`、`case`、`&&`、`||` がいっぱい出てくる関数は複雑っていうこと

```go
func MonthName(month int) string {
	switch month {
	case 1:
		return "January"
	case 2:
		return "February"
	case 3:
		return "March"
	case 4:
		return "April"
	case 5:
		return "May"
	case 6:
		return "June"
	case 7:
		return "July"
	case 8:
		return "August"
	case 9:
		return "September"
	case 10:
		return "October"
	case 11:
		return "November"
	case 12:
		return "December"
	default:
		return ""
	}
}
```

これの循環性複雑度は "14"
(1 から始まって、分岐が 13 個あるので +13)

## 僕の感想

- 関数をシンプルに保つのに貢献してくれる
- しきい値を超えたからといってスッと直すのは難しかったりすることも
- しきい値を超える変更をした人が直さなきゃいけないことがしばしばで、そういう意味ではロシアンルーレット的なところもある
