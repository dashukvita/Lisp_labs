10)Написать функцию Trans (N S), которая упрощает структуру списочного выражения S, 
заменяя в нем все списочные элементы, находящиеся на уровне N (N>=1), на(X)
(defun Trans (N S) (Accum N S 0))
(defun Accum (N S P)
  (cond
	((atom S) S)
	((null S) (cons (Accum N (NIL) (+ 0)) (Accum N (cdr S) (+ 0))) )
	(T (cons (Accum N (car S) (+ 1)) (Accum N (cdr S) (+ 1))) )
	)
)
(Trans '0 '((A (V B) 6) 7 ((4) 3 (e F) R)))

(defun SumPr3 (X) (Accum X 0 1))
(defun Accum (X S P)
 (cond((null X) (cons S P))
(T (Accum (cdr X) (+ S (car X)) 
	(* P (car X)) )) ))

(SumPr3 '(1 (2) 3))

(Trans '3 '((A (V B) 6) 7 ((4) 3 (e F) R)))
(Trans 2 '(((A(5)8)B(K))(G(C)))) => ((# B #)(G #))
(Trans '3 '((A (V B) 6) 7 ((4) 3 (e F) R)))
