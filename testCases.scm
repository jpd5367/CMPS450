(define testData1 '(1 8 4 2 8 45 -34 345))
(define testData2 '(434 60000 234234 -23 4 700))
(define testData3 '(1 2 3 4 5 6 7 8 9 10 11 
	                12 13 14 15 16 17 18 19 20))
(define testData4 '(5 4 3 2 1 0 -1 -2 -3 -4 -5))
(define testData5 '(1 2 3))
(define sorted1   '(-34 1 2 4 8 45 345))
(define sorted2   '(-23 4 434 700 60000 234234))
(define sorted3   testData3)
(define sorted4   testData4)
(define sorted5   testData5)

(define isListSorted
	(lambda (l)
		(if (null? l)
			#t
			(if (null? (cdr l))
				#t
				(if (> (car l) (cadr l))
					#f
					(
						isListSorted (cdr l)
					)
				)
			)
		)
	)
)

(define testCount
	(lambda ()
		(and
			(= 
				(list-length testData1)
				8
			)
			(= 
				(list-length testData2)
				6
			)
			(= 
				(list-length testData3)
				20
			)
			(= 
				(list-length testData4)
				11
			)
			(= 
				(list-length testData5)
				3
			)
		)
	)
)

(define testMinMax
	(lambda ()
		(
			and
			(= ; test min of data 1 
				(car (list-min-max testData1))
				-34
			)
			(= ; test max of data 1
				(cdr (list-min-max testData1))
				345
			)
			(= ; test min of data 2 
				(car (list-min-max testData2))
				-23
			)
			(= ; test max of data 2
				(cdr (list-min-max testData2))
				234234
			)
			(= ; test min of data 3 
				(car (list-min-max testData3))
				1
			)
			(= ; test max of data 3
				(cdr (list-min-max testData3))
				20
			)
			(= ; test min of data 4 
				(car (list-min-max testData4))
				-5
			)
			(= ; test max of data 4
				(cdr (list-min-max testData4))
				5
			)
			(= ; test min of data 5 
				(car (list-min-max testData5))
				1
			)
			(= ; test max of data 5
				(cdr (list-min-max testData5))
				3
			)
		)
	)
)

(define testMergeSort
	(lambda ()
		(and 
			(isListSorted (merge-sort testData1))
			(isListSorted (merge-sort testData2))
			(isListSorted (merge-sort testData3))
			(isListSorted (merge-sort testData4))
			(isListSorted (merge-sort testData5))
		)
	)
)

(define testHigherOrder
	(lambda ()
		(and
			(= 
				((inc_n 2) 3)
				5
			)
			(= 
				((inc_n 55) 25)
				80
			)
			(= 
				((inc_n -2) 3)
				1
			)
			(= 
				((inc_n 128) 4)
				132
			)
			(= 
				((inc_n 24) 30)
				54
			)
			(= 
				((inc_n 1) 3)
				4
			)
			(= 
				((inc_n 100000) 3000)
				103000
			)
			(= 
				((inc_n -200) 3)
				-197
			)

		)
	)
)