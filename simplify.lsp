; вспомогательная функция проверки элемента 
(defun check_elem(elem)
	(cond ((atom elem)
	       (list elem)
		  )
		  ((eq (length elem) 1)
			nil
		  )
		  ((eq (length elem) 2)
		   (cdr elem)
		  )
		  (T
		   (list elem)
		  )					
	)
)

; для сокращения последнего элемента
(defun remove_last(L) 
	(cond ((atom L) 
		   (list L)
		  )
		  ((eq (length L) 1) 
		   nil
		  )
		  ((eq (length L) 2) 
		   (cdr L)
		  )
		  (T
		   (list (remove_1_2 L)) 
		  )
	)
)

; убираем списки неправильной длины // на вход идет все выражение
(defun remove_1_2(L)
	(cond ((null (cdr L))              
		   (remove_last (car L))      
		  )
		  ((atom (car L)) 
		   (cons (car L) (remove_1_2 (cdr L)))
		  )
		  ((eq (length (car L)) 1) 
		   (remove_1_2 (cdr L))
		  )
		  ((eq (length (car L)) 2) 
		   (cons (cadar L) (remove_1_2 (cdr L)))
		  )
		  (T
		   (cons (remove_1_2 (car L)) (remove_1_2 (cdr L))) 
		  )
	)
)

(defun if_need_simplify(L)
	(cond ((null L)
		   nil
		  )
		  ((atom L) 
		   nil
		  )
		  ((eq (car L) 0) 
		   T
		  )
		  ((atom (car L)) 
		   (cond ((eq (car L) '/)
					(cond ((eq (caddr L) 1)
							T
						  )
						  (T 
							(if_need_simplify (cdr L))
						  )
					)
				 )
				 (T 
				  (if_need_simplify (cdr L))
				 )
		   )		   
		  )
		  ((< (length (car L)) 3)
		   T
		  )
		  ((eq (car L) '/)
		   (cond ((eq (caddr L) 1)
				  T
				 )
		   )
		  )
		  ((if_need_simplify (car L)) 
		   T
		  )
		  (T 
		   (if_need_simplify (cdr L))
		  )
	)
)

(defun remove_elem(elem L)
    (let ((first_elem (car L))
          (tail (cdr L))
         )
         
         (cond ((null tail)                       
                (cond ((eq first_elem elem) nil) 
                      ((atom first_elem)          
                       (list first_elem)
                      )
                      (T (list (simplify first_elem))) 
                )               
               )
               ((eq first_elem elem) (remove_elem elem tail) 
               )
               ((atom first_elem) 
                (cons first_elem (remove_elem elem tail) 
                )
               )
               (T 
                (cons (simplify first_elem)
                        (remove_elem elem tail) 
                )
               )
         )
    )
)

; проверка является ли какой-нибудь элемент 0
(defun if_zero(L)
	(cond ((null L)
		   nil
		  )
		  ((atom (car L)) 
		   (cond ((eq (car L) 0) 
				  T
				 )
				 (T               
				  (if_zero (cdr L))
				 )
		   )
		  )
		  (T 
		  (if_zero (cdr L))
		  )
	)
)

(defun simplify(L)
	(let ((znak (car L))) ; делаем аналог switch-case
		
		(cond ((eq znak '+)
			   (cons znak (remove_elem 0 (cdr L))) 
			  )
			  ((eq znak '-)
			   (cons znak (remove_elem 0 (cdr L))) 
			  )
			  ((eq znak '*)
				(cond ((if_zero (cdr L))
					   '0
				      )
				      (T 
					   (cond ((eq (remove_elem 1 (cdr L)) nil)
							  '1
							 )
							 (T
							  (cons znak (remove_elem 1 (cdr L))) 
							 )
					   )					   
				      ) 
				)				                        
              )
			  ((eq znak '/)
			   (cond ((eq (length L) 3)
					  (delenie L)
					 )
					 (T
					  '(Неверное количество знаков для деления!)
					 )
			   )
			  )
			  (T
			    '(непонятный знак !)
			  )
		)
	)
)

; деление работает следующим образом
; если делитель 0 - вернем ошибку
; если делимое 0 - вернем 0
; если делим на 1 - вернем делимое

(defun delenie(L)
	(let ((delimoe (cadr L))
	      (delitel (caddr L)) 
		 )
		 
		 (cond ((eq delitel 0) 
				'(На ноль делить нельзя!)
			   )
			   ((eq delimoe 0)
			    (list '/ 0)
			   )
			   ((atom delimoe)
			    (cond ((eq delitel 1)
						(list '/ delimoe)
					  )
					  ((atom delitel) 
					   (cons '/ (cons delimoe (list delitel)))
					  )
					  (T 
					   (cons '/ (cons delimoe (list (simplify delitel))))
					  )
				)
			   )			   
			   (T 
			    (cond ((eq delitel 1)
						(list '/ (simplify delimoe))
					  )
					  ((atom delitel) 
					   (cons '/ (cons (simplify delimoe) (list delitel)))
					  )
					  (T 
					   (let ((simpleDelimoe (simplify delimoe))
							 (simpleDelitel (simplify delitel))
							)
					 
							(cons '/ (cons simpleDelimoe (list simpleDelitel)))
					   )	
					  )
				)			    		    				
			   )
		 )
	)
)

; если на выходе из simplify_excpresion получили (+) или (+ 1), то упростим
(defun if_it_simple_make_it_better(L)
	(cond ((eq (length L) 1) 
			'0
		  )
		  ((eq (length L) 2)
		   (cadr L)
		  )
		  (T 
		   L
		  )
	)
)

(print nil)
(print '(if_it_simple_make_it_better test-----------------------------------------------))
(print '(need 0))
(print (if_it_simple_make_it_better '(+)) )
(print '(need 1))
(print (if_it_simple_make_it_better '(+ 1)) )
(print '(if_it_simple_make_it_better test-----------------------------------------------))

(defun simplify_excpresion(L)
	(let ((s_exp (remove_1_2 (simplify L)))) 
		(cond ((if_need_simplify s_exp)     
			   (simplify_excpresion s_exp)
			  )
			  (T
			   (if_it_simple_make_it_better s_exp)
			  )
		)
	)
)
;  проверки
(print '//////////////////////////////////////////////////////////////////////////////////////////////////////////)
(print '(simplify_excpresion test-----------------------------------------------))
(print '(need (+ (- 2 1) 1)))
(print (simplify_excpresion '(+ (- (+ (* 0 0) (* 2 0)) (+ 2 0) 1) (+ (+ 1 0) (+ (* 0 2))))))
(print '(need 0))
(print (simplify_excpresion '(+ 0 0)) )
(print '(need 1))
(print (simplify_excpresion '(+ 1 0)) )
(print '(need (+ (- (* 3 (+ 6 10)) 2 1) 1)))
(print (simplify_excpresion '(+ (- (+ (* 0 0) (* 1 (* 3 (+ 6 10))) (* 2 0)) (+ 2 0) 1) (+ (+ 1 0) (+ (* 0 2))))  ))
(print '//////////////////////////////////////////////////////////////////////////////////////////////////////////)
(print '(need (+ a b (* b  c  b) ) ))
(print (simplify_excpresion '(+ a b (* b (+ c 0) b) (*(+ b f ) 0)) ))
(print '//////////////////////////////////////////////////////////////////////////////////////////////////////////)
(print '(need (+ a b (* b (+ 2 5)  b) ) ))
(print (simplify_excpresion '(+ a b (* b  (/ (+ 2 5) (/ 1 1))  b) ) ))
(print '(need (+ a b (* b (+ 2 5)  b) ) ))
(print (simplify_excpresion '(+ a b (* b  (/ (+ 2 5) 1)  b) ) ))
(print '(need (+ a b) ))
(print (simplify_excpresion '(+ a b (* b  (/ (* 5 0) (+ 2 5))  b) ) ))
(print '(simplify_excpresion test-----------------------------------------------))

(print '(тесты))
(print (simplify_excpresion '(+ (/ a 0) (* b (+ b 0))) ))
(print (simplify_excpresion '(+ (* a (+ b 0)) (/ 0 (+ a b))) ))
(print (simplify_excpresion '(+ (/ a 0) 1) ))
(print (simplify_excpresion '(/ a 0) ))


































