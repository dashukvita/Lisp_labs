<h1> Common Lisp</h1>
<div style="width:500px;
border-top:3px solid #9EC1D4;
border-bottom: dotted 3px #9EC1D4;
padding-left:10px">
<p>1. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/getlast.lsp">getlast(L)</a>, возвращающая последний элемент списка </p>
<p>2. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/copy.lsp">copy(L)</a>, возвращающая копию &quot;линейного&quot; списка</p>
<p>3. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/copyc.lsp">copyc(L)</a>, возвращающая копию списка, который может содержать подсписки</p>
<p>4. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/reverse.lsp">reverse(L)</a>, возвращающая перевернутый  список</p>
<p>5. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/reverse1.lsp">reverse1(L)</a> то же, что 4, но с использованием вспомогательной функции с накапливающим параметром</p>
<p>6. Фильтр <a href="https://github.com/dashukvita/Lisp_labs/blob/master/filter1.lsp">Filter1(P L)</a> -- из списка L выбираются элементы, удовлетворяющие предикату P, и помещаются в результирующий список</p>
<p>7. АнтиФильтр <a href="https://github.com/dashukvita/Lisp_labs/blob/master/filter2.lsp">Filter2(P L)</a> -- то же, что в 6, не удовлетворяющие предикату</p>
<p>8. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/depth.lsp">Depth(L)</a>, вычисляющую глубину списка L, т.е. максимальное количество уровней в нём.</p>
<p>9. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/subst.lsp">Subst(A L E)</a>, заменяющая в произвольном списочном выражении L на всех его уровнях все вхождения атома А на выражение Е.</p>
<p>10. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/trans.lsp">Trans(N S)</a>, которая упрощает структуру списочного выражения S, заменяя в нём все списочные элементы, находящиеся на уровне N (N&gt;=1), на (X) </p>
<p>11. Функция <a href="https://github.com/dashukvita/Lisp_labs/blob/master/simplify.lsp">simplify</a>, которая упрощает
выражения (c операциями +,-,/,*).
<br>   Например выражение a+b+b*(c+0)*b+(b+f)*0
<br>   можно представить лисповским списком: (+ a b (* b (+ c 0) b) (*(+ b f ) 0) )
