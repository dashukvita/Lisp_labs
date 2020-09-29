1)  функция getlast(L) возвращающая последний элемент списка 
(defun GetLast (L)
	(cond 
		((null (cdr L)) (car L))
		(T (GetLast (cdr L)))
	)
)

(GetLast '(A B C))
(GetLast '())
