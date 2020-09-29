8) Определить функцию Depth( L), вычисляющую глубину списка L, т.е. максимальное количество 
уровней в нём.
(defun Max1 (x y)
		(if (> x y) x y)
)

(defun Depth (L)
	(cond 
		  ((atom L) 0)
		  ((null L) 1)
		  (T (Max1 (+ 1 (Depth (car L)))(Depth (cdr L))) )
	)
)

(Depth '(((A (5) 8) B (K)) (G(C))) )
(DEPTH ‘((A 6) 7 ((C 4) 3)))
(Depth '() )
(Depth 'A )
