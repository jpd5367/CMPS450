(define testData1 '(1 8 4 2 8 45 -34 345))
(define testData2 '(434 60000 234234 -23 4 700))
(define testData3 '(1 2 3 4 5 6 7 8 9 10 11 
	                12 13 14 15 16 17 18 19 20))
(define testData4 '(5 4 3 2 1 0 -1 -2 -3 -4 -5))
(define testData5 '(1 2 3))

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
			'()
		)
	)
)

(define testUserInts
	(lambda ()
		(
			'()
		)
	)
)

(define testUserMinMax
	(lambda ()
		(
			'()
		)
	)
)

(define testMergeSort
	(lambda ()
		(
			'()
		)
	)
)

(define testHigherOrder
	(lambda ()
		(
			'()
		)
	)
)