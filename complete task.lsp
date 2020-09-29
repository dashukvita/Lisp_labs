; вспомогательная функция проверки элемента 
(defun check_elem(elem)
	(cond ((atom elem)
	       (list elem)
		  )
		  ; здесь это уже список, проверим его длину
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
(defun remove_last(L) ; итак, у нас последний элемент
	(cond ((atom L) ; если это атом просто вернем его
		   (list L) ; возвращаем как список, иначе потеряем скобки 
		  )
		  ((eq (length L) 1) ; если это знак уберем
		   nil
		  )
		  ((eq (length L) 2) ; если чисоло со знаком, вернем число
		   (cdr L)
		  )
		  (T
		   (list (remove_1_2 L)) ; если это большой список - упростим
		  )
	)
)

; убираем списки неправильной длины // на вход идет все выражение
(defun remove_1_2(L)
	(cond ((null (cdr L))              ; дошли до последнего элемента
		   (remove_last (car L))       ; обрабатываем его в функции remove_last
		  )
		  ((atom (car L)) ; тут уже не последний элемент, так что смотрим на первый, если это атом, то вставляем его
		   (cons (car L) (remove_1_2 (cdr L)))
		  )
		  ((eq (length (car L)) 1) ; если это вида (+) - убираем
		   (remove_1_2 (cdr L))
		  )
		  ((eq (length (car L)) 2) ;  усли это вида (+ 1) - оставляем только число
		   (cons (cadar L) (remove_1_2 (cdr L)))
		  )
		  (T
		   (cons (remove_1_2 (car L)) (remove_1_2 (cdr L))) ; если первый элемент - нормальный список (> 3), то упрощаем и его и хвост
		  )
	)
)

(defun if_need_simplify(L)
	(cond ((null L)
		   nil
		  )
		  ((atom L) ; для деления
		   nil
		  )
		  ((eq (car L) 0) ; проверяем есть ли нули
		   T
		  )
		  ; old version
		  ;((atom (car L)) ; если это атом (не ноль), то проверяем хвост
		   ;(if_need_simplify (cdr L))
		  ;)
		  ((atom (car L)) ; если это атом (не ноль), то проверяем хвост , но сначала поработаем с делением
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
		  ((< (length (car L)) 3) ; если уже соответственно не атом, то смотрим на его длину, если меньше 3, надо упрощать
		   T
		  )
		  ; это проверка для деления на 1
		  ((eq (car L) '/)
		   (cond ((eq (caddr L) 1)
				  T
				 )
		   )
		  )
		  ((if_need_simplify (car L)) ; теперь лезем в голову, если надо упростить ее, то все нужно упростить
		   T
		  )
		  (T ; с первым элементом все хорошо, идем дальше
		   (if_need_simplify (cdr L))
		  )
	)
)

; убирает elem из списка L
(defun remove_elem(elem L)
    (let ((first_elem (car L))
          (tail (cdr L))
         )
         
         (cond ((null tail)                       ; если хвост пуст - разберемся с первым элементом
                (cond ((eq first_elem elem) nil)  ; если это искомый элемент, то удалим
                      ((atom first_elem)          ; если другой атом - вернем его
                       (list first_elem)
                      )
                      (T (list (simplify first_elem))) ; если оказался списком - то упрощаем дальше
                )               
               )
               ((eq first_elem elem) (remove_elem elem tail) ; если хвост есть и первый элемент искомый - удаляем его и ищем дальше в хвосте
               )
               ((atom first_elem) 
                (cons first_elem (remove_elem elem tail) ; если первый другой атом, вставляем его в рекурсивный вызов для хвоста
                )
               )
               (T 
                (cons (simplify first_elem)
                        (remove_elem elem tail) ; если первый эелемент - список, и хвост есть, то упрощаем первый и рекурсивно удаляем искомый элемент из хвоста
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
		  ((atom (car L)) ; если первый элемент  - атом
		   (cond ((eq (car L) 0) ; если это 0, вернем тру
				  T
				 )
				 (T               ; если не 0, проверим хвост 
				  (if_zero (cdr L))
				 )
		   )
		  )
		  (T ; если первый элемент - список
		  ; список - это не 0!
		  ; поэтому просто проверим хвост!
		  (if_zero (cdr L))
		   ;(cond ((if_zero (car L)) ; проверим этот список, если там есть 0, вернем тру
			;	  T
			;	 )
			;	 (T ; если в этом списке нет 0, проверим хвост
			;	  (if_zero (cdr L))
			;	 )
		   ;)
		  )
	)
)

(defun simplify(L)
	(let ((znak (car L))) ; делаем аналог switch-case
		
		(cond ((eq znak '+)
			   (cons znak (remove_elem 0 (cdr L))) ; передаем слагаемые и удаляем нули из них
			  )
			  ((eq znak '-)
			   (cons znak (remove_elem 0 (cdr L))) ; передаем слагаемые и удаляем нули из них
			  )
			  ((eq znak '*)
				(cond ((if_zero (cdr L)) ; если во множителях встречен 0, вернем 0
					   '0
				      )
				      (T ; если 0 нет
					   (cond ((eq (remove_elem 1 (cdr L)) nil) ; если все множители это 1, то вернем
							  '1
							 )
							 (T
							  (cons znak (remove_elem 1 (cdr L))) ; удалим единицы из множителей
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

; критические значения проверены, теперь нужно обработать отдельные случаи, так как упрощать можно только списки
; если кто-то список, упрощаем его
(defun delenie(L)
	(let ((delimoe (cadr L)) ; берем делимое
	      (delitel (caddr L)) ; берем делитель
		 )
		 
		 (cond ((eq delitel 0) ; сначала проверяем критические значения делимого и делителя
				'(На ноль делить нельзя!)
			   )
			   ((eq delimoe 0)
			    (list '/ 0)
			   )
			   ((atom delimoe) ; теперь посмотрим на дедимое, его нельзя сразу передать в simplify, если это атом, то не сработает 
			    (cond ((eq delitel 1)
						(list '/ delimoe)
					  )
					  ((atom delitel) ; делимое и делитель атомы, отличные от критических
					   (cons '/ (cons delimoe (list delitel)))
					  )
					  (T ; делимое атом, делитель список
					   (cons '/ (cons delimoe (list (simplify delitel))))
					  )
				)
			   )			   
			   (T ; делимое список
			    (cond ((eq delitel 1)
						(list '/ (simplify delimoe))
					  )
					  ((atom delitel) ; делитель атом
					   (cons '/ (cons (simplify delimoe) (list delitel)))
					  )
					  (T ; делимое и делитель списки
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
	(cond ((eq (length L) 1) ; это значит, что мы упростили до знака
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


; основная функция - работает следующим образом:
; упрощает выражение(simplify): 
; - для +- удаляет 0;
; - для *:
;   -если в нем есть 0 элемент, то вернет 0, вместо всего произведения
;   - если есть 1, то уберет их, если только единицы вернет вместо всего произведения 1
; вот так действует simplify: (+ 1 0 (- 0 2) (* 0 2) (* 1 2)) -> (+ 1 (- 2) 0 (* 2))
; после упрощения выражения применяем функцию (remove_1_2),
; которая убирает такие скобки (+), а вместо таких (+ 1) возвращает 1
; вот так действует remove_1_2: (+ 1 (- 2) 0 (* 2)) -> (+ 1 2 0 2)

; деление работает если там 2 аргумента, а также отработает случаи с 0 и 1

; как видно, такое выражение требует повторного упрощения
; поэтому есть функция if_need_simplify, которая вернет тру если в выражении есть 0 и списки длиной 1(+) и 2(+ 1), а также дополнительное условие для деления
; тогда все повториться снова, пока выражение не будет упрощенно и функция if_need_simplify не вернет nil.
(defun simplify_excpresion(L)
	(let ((s_exp (remove_1_2 (simplify L)))) ; упрощаем и удаляем лишние элементы
		(cond ((if_need_simplify s_exp)      ; если нужно упростить еще, упрощаем еще
			   (simplify_excpresion s_exp)
			  )
			  (T
			   (if_it_simple_make_it_better s_exp)
			  )
		)
	)
)

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

(print '(тесты от Иры))
(print (simplify_excpresion '(+ (/ a 0) (* b (+ b 0))) ))
(print (simplify_excpresion '(+ (* a (+ b 0)) (/ 0 (+ a b))) ))
(print (simplify_excpresion '(+ (/ a 0) 1) ))
(print (simplify_excpresion '(/ a 0) ))


































