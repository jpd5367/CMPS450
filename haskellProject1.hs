-- Assignment: Haskell Project1
-- Class:      CMPS 450
-- Semester:   Fall 2015
-- Author:     Joseph DeHart
-- CLID:       jpd5367
-- Professor:  Dr. Mohsen Amini
-- Due Date:   Sept. 30, 2015 


-- Tail recursive function to return the length of an arbitrary list
-- input:  list of integers
-- output: integer representing the number of elements in the list
listLength l = incr l 0 where 
	incr (x:xs) i = incr xs (i + 1)
	incr [] i = i

-- Function to compute the maximum and minimum of a list of integers
-- input:  list of integers
-- output: returns a list containing min and max
listMinMax l = next l (head l) (head l) where
	next (x:xs) min max = next (xs) (if x < min then x else min) (if x > max then x else max)
	next [] min max = (min,max)

-- collect integers from the user, returns list as entered
-- input:  user inputs integers until 0 is received
-- output: list of integers in the order entered
--         list containing minimum and maximum values of the list

breakString s = next s c where
	next (x:xs) ' ' =  if (head xs == ' ')

main = main2 [] where 
	main2 l = do
	putStrLn "enter Ints"
	input <- getLine
	if input == "0" 
	then return l -- call function to process data
	else do 
		main2 (input:l)



		


-- collect integers returns list with min and max values, 
-- input:  user input terminated by an input of 0
-- output: print the list of input in the order entered
--         print the minimum and maximum values from the input








-- merges two lists together into a sorted list
-- input:  two lists
-- output: one sorted list containing all elements of the original list








-- Splits a list into 2 half list
-- input: a list
-- output: a list containing a pair of lists; 
--         list 1 contains even elements of the original list 
--         list 2 contains odd elements of the original list







-- Sort list using merge-sort algorithm
-- input:  list of integers
-- output: sorted list of integers






-- Higher order function which increments another function input by n
-- input:  integer
-- output: function the increments any value passed to it by input 