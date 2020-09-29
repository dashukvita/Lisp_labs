4) функция  reverse (L)  возвращающая перевернутый  список
(defun Rev (L)
	(cond 
		((null L) NIL)
		(T (append (Rev (cdr L)) (cons (car L) nil) ))
	)
)

(Rev '(A B C))
(Rev '(A (B C)D))
