3)  функция  copyc(L) возвращает копию списка, который может содержать подсписки
(defun Copy1 (L)
	(cond 
		((null L) NIL)
		((atom L)(cons (car L) (Copy (cdr L))))
		(T (cons (car L) (Copy (cdr L))))
	)
)

(Copy '(A (B C)D))
(Copy '(A))
