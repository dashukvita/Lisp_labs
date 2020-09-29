7)  АнтиФильтр  Filter2 (P L)  -- то же, что в 6, не удовлетворяющие предикату 
(defun Filter1 (F L)
	(cond 
		  ((null L) nil)
		  ((eval (list F (list 'quote(car L)))) (Filter1 F(cdr L))) 
		  (T (cons (car L)(Filter1 F(cdr L))))
	)
)
(Filter1 'listp '((B C)D (G) A (C D)))
(Filter1 'atom '((B C)D (G) A (C D) Q P))
(Filter1 'numberp '((B C)4 (5) A (2 D) 12 P))
