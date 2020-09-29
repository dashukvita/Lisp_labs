9) Составить функцию Subst (E A L), заменяющую в произвольном списочном выражении L 
на всех его уровнях все вхождения атома А на выражение Е
(defun Subst1 (E A L) 
 (cond
	((equal A L) E)
	((atom L) L)
	(T (cons
			(Subst1 E A (car L))
			(Subst1 E A (cdr L))
	   )
	)
 )
) 
(Subst1 'B 'A '(A (D) A (F (A) E) (A B) A D A))
(Subst1 'B 'A 'A)
(Subst1 'B 'A '())
(Subst1 'B 'A '(A))
