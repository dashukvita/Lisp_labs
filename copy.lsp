2)  функция copy(L)  возвращающая копию линейного списка
(defun Copy (L)
	(cond 
		((null L) NIL)
		(T (cons (car L) (Copy (cdr L))))
	)
)

(Copy '(A B C))
