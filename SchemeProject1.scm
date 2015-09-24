; Assignment: Scheme Project1
; Class:      CMPS 450
; Semester:   Fall 2015
; Author;     Joseph DeHart
; Professor:  Dr. Mohsen Amini
; Due Date:   Sept. 30, 2015 

; Tail recursive function to return the length of an arbitrary list
; input:  list of integers
; output: integer representing the number of elements in the list
(define list-length 
	(lambda (L)
		(let incr ; internal structure to iterate through the list
			(
				(L L) ;the list to be counted
				(count 0) ; a counter starting at zero
			) 
			(if (null? L) ; if the end of the list is reached
				count ; return the count
				(incr ; recursive call to act as a loop
					(cdr L) ; pass the cdr of the list to the next iteration
					(+ count 1) ; increment count by one
				)
			)
		)
	)
)

; Function to compute the maximum and minimum of a list of integers
; input:  list of integers
; output: returns a list containing min and max
(define list-min-max 
	(lambda (L) 
		(let next ; internal structure to iterate through the list
			(
				(L L) ; list to be processed
				(min (car L)) ; current minimum value of the list
				(max (car L)) ; current maximum value of the list
			) 
			(if (null? L) ; if the list is empty
				(cons min max) ; return a list containing the min and max values
				(next ; recursive call to check the next value in the list
					(cdr L) ; pass the unchecked part of the list to recursive call
					(if (< (car L) min) ; pass the new min the recursive call 
						(car L) 
						min 
					)	 
					(if (> (car L) max) ; pass the new max to recursive call
						(car L) 
						max 
					)
				)
			) 
		)
	)
)

; collect integers from the user, returns list as entered
; input:  user inputs integers until 0 is received
; output: list of integers in the order entered
;         list containing minimum and maximum values of the list
(define collect-ints 
	(lambda ()
		(let getint
			(
				(L '()) ; list to store values
				(x (read)) ; input
			)
			(if (= x 0) ; termination clause
				(reverse L) ; return value
				(getint ; recursive call to collect user input
					(cons x L) 
					(read)
				)	
			)
		)
	)
)

; collect integers returns list with min and max values, 
; input:  user input terminated by an input of 0
; output: print the list of input in the order entered
;         print the minimum and maximum values from the input
(define get-list
	(lambda ()
		(let 
			(
				(L (collect-ints) ) ; list to store input
				(min '(min value =)) ; current minimum value
				(max '(max value =)) ; current maximum value
			)
			(display ; display the input followed by the min and max
				(cons 
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

; merges two lists together into a sorted list
; input:  two lists
; output: one sorted list containing all elements of the original list
(define merge 
	(lambda (left right)
		(if (null? left)
			right ; return sorted right list if left list is empty
			(if (null? right)
				left ; return sorted left list if right list is empty
				(if (> (car right) (car left)) ; sort and merge recursively until one list is empty 
					(cons (car left)  (merge (cdr left) right))
					(cons (car right) (merge (cdr right) left))
				)
			)
		)
	)
)

; Splits a list into 2 half list
; input: a list
; output: a list containing a pair of lists; 
;         list 1 contains even elements of the original list 
;         list 2 contains odd elements of the original list
(define split
	(lambda (lis) ;func that receives a single list as a param
		(let div ; structure to iterate through the list
			(
				(lis lis) ; list to be split
				(R '()) 
				(L '())
			)
			(if (null? lis)
				(list (reverse L) (reverse R)) ; if list is input list is empty return a list of two new lists
				(div ; recursive call to traverse list
					(if (null? (cdr lis))
						'()
						(if (null? (cddr lis))
							'()
							(cddr lis)
						)
					)
					(cons (car lis) L)	; add 1st element to left list
					(if (null? (cdr lis))
						R
						(cons (cadr lis) R) ; add 2nd element to right list		
					)
				)
			)
		)
	)
)

; Sort list using merge-sort algorithm
; input:  list of integers
; output: sorted list of integers
(define merge-sort 
	(lambda (lis)
		(if (null? lis)
			lis ; if empty list exit, considered sorted
			(if (null? (cdr lis)) 
				lis ; if only 1 element return, considered sorted
				(let ((x (split lis))) ; else: split list, calling merge with a recursive merge-sort on each half of list
					(
						merge ; merge two sorted list back together when falling out of recursion
						(merge-sort (car x)) ; call merge-sort on the left half of the list
						(merge-sort (cadr x)) ; call merge-sort on the right half of the list
					)
				)
			)
		)
	)
)

; Higher order function which increments another function input by n
; input:  integer
; output: function the increments any value passed to it by input 
(define inc_n 
	(lambda (x)
		(lambda (f) ; return function
			(+ f x) 
		)
	)
)