
(define list-length 
	(lambda (L)
		(let incr 
			(
				(L L) 
				(count 0)
			) 
			(if (null? L) 
				count
				(incr 
					(cdr L) 
					(+ count 1)
				)
			)
		)
	)
)

(define list-min-max 
	(lambda (L)
		(let next 
			(
				(L L) 
				(min (car L)) 
				(max (car L))
			) 
			(if (null? L) 
				(cons min max)
				(next 
					(cdr L) 
					(if (< (car L) min) 
						(car L) 
						min 
					)	 
					(if (> (car L) max) 
						(car L) 
						max 
					)
				)
			) 
		)
	)
)

(define collect-ints 
	(lambda ()
		(let getint
			(
				(L '())
				(x (read))
			)
			(if (= x 0) 
				(reverse L)
				(getint
					(cons x L)
					(read)
				)	
			)
		)
	)
)

(define get-list
	(lambda ()
		(let 
			(
				(L (collect-ints) )
				(min '(min value =))
				(max '(max value =))
			)
			(
				display (cons 
							L

							(cons 
								(append max (cdr (list-min-max L))) 
								(append min (car (list-min-max L)))
							)
						)
			)
		)
	)
)

(define merge 
	(lambda (left right)
		(if (null? left)
			right
			(if (null? right)
				left
				(if (> (car left) (car right))
					(cons (car right) (merge (cdr right) left))
					(cons (car left)  (merge (cdr left) right))
				)
			)
		)
	)
)

; returns a pair of lists list 1 contains the 1st half of the list 
; and list 2 the second
(define split
	(lambda (lis) ;func that receives a single list as a param
		(let div 
			(
				(lis lis)
				(R '())
				(L '())
			)
			(if (null? lis)
				(list (reverse L) (reverse R))
				(div 
					(cddr lis)
					(cons (cadr lis) R)
					(cons (car lis) L)			
				)
			)
		)
	)
)

(define merge-sort 
	(lambda (lis)
		(if (null? lis)
			lis
			(if (null? (cdr lis))
				lis
				(let ((x (split lis)))
					(
						merge
						(merge-sort (car x))
						(merge-sort (cadr x))
					)
				)
			)
		)
	)
)



