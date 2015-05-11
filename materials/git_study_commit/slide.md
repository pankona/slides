Git study No.1
=======================

** commitを綺麗にする小技集 **

>>>

[Back to table of contents](./index.html)

---

コミットを綺麗に！
=======================

gitにはコミットをキレイにするための機能・仕組みが  
たくさん用意されております。  
ちょっと役にたつかもしれない小枝を紹介します。

---

** そもそもキレイなコミットとは？ **

** なんでコミットをキレイにしなきゃいけないの？ **

- それは別の機会に。。 <!-- .element: class="fragment" data-fragment-index="1" -->

>>>

** こんなコミットは嫌だよ Case.1 **

* やたら差分がでかい

意味もなくでかいならまだいい、すべての変更に意味があるのにやたらでかいコミットがきつい

>>>

** こんなコミットは嫌だよ Case.2 **

* 細かく刻み過ぎている

`「fix indentation」`  
`「remove trailing white spaces」`  
`「remove trailing white spaces again」`  
`「fix indentation again」`  
`「fix build error」`   
`「fix build, I hope」`   

>>>

** こんなコミットは嫌だよ Case.3 **

* コミットログがウソ

`「fix indentation」`等と書いているのに  
明らかにロジックを直している。

>>>

** こんなコミットは嫌だよ Case.4 **

* 情報が足りなくて寂しい

`fix build error.`  
`add new class.`  
`change logic.`

--- 

全部直せます！
=======================

** しかもコミットしてからでも。 **

* ただしリモートにプッシュしてしまっている場合は手遅れの場合があります。  
* それでも直したいときはまず磯部さんに相談してください。<!-- .element: class="fragment" data-fragment-index="1" -->

>>>

** こんなコミットは嫌だよ Case.1（再掲） **

* やたら差分がでかい

意味もなくでかいならまだいい、すべての変更に意味があるのにやたらでかいコミットがきつい

>>> 

** でっかくなってしまった差分には **

* `git add -p <file>`

実演。 <!-- .element: class="fragment" data-fragment-index="1" -->

>>>

** こんなコミットは嫌だよ Case.2（再掲） **

* 細かく刻み過ぎている

`「fix indentation」`  
`「remove trailing white spaces」`  
`「remove trailing white spaces again」`  
`「fix indentation again」`  
`「fix build error」`   
`「fix build, I hope」`   

>>> 

** しょうもないコミットが多くなってしまったときは **

* `git rebase` からの `squash`

実演。 <!-- .element: class="fragment" data-fragment-index="1" -->

>>> 

** こんなコミットは嫌だよ Case.3（再掲） **

* コミットログがウソ

`「fix indentation」`等と書いているのに  
明らかにロジックを直している。

>>>

** こんなコミットは嫌だよ Case.4（再掲） **

* 情報が足りなくて寂しい

`fix build error.`  
`add new class.`  
`change logic.`

>>> 

** コミットログ間違えちゃった日には **

* `git rebase` もしくは `git commit --amend`

実演。 <!-- .element: class="fragment" data-fragment-index="1" -->

---

キレイなコミットが作る笑顔の開発チーム
=======================

** 嬉しいね！ \\(^0^)/ **

--- 

** Thank you. **
