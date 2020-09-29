6)  Фильтр  Filter1 (F L)  -- из списка L выбираются элементы, удовлетворяющие 
предикату P, и помещаются в результирующий список
(defun Filter1 (F L)
	(cond 
		  ((null L) nil)
		  ((eval (list F (list 'quote(car L)))) (cons (car L)(Filter1 F(cdr L)))) 
		  (T (Filter1 F(cdr L)))
	)
)
(Filter1 'listp '((B C)D (G) A (C D)))
(Filter1 'atom '((B C)D (G) A (C D) Q P))
(Filter1 'atom '((B C)D (G) A (C D)))
(Filter1 'numberp '((B C)4 (5) A (2 D) 12 P))
