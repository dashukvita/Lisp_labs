5) функция reverse1 (L) то же, что 4, но с использованием вспомогательной функции с накапливающим параметром
(defun RevAll (L)
	(cond 
	    ((null L) nil)
		(T (append (RevAll (cdr L))
			(cons 
				(cond ((atom (car L))  
				(car L)) 
				(T (RevAll (car L)))) 
			nil)
			)
		)
	)
)

(RevAll '((A M) (B C)D E))
