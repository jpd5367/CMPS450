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
getNumbers :: IO [Int]
getNumbers = do
	putStrLn "\nenter an Integer, 0 to exit"
	input <- getNumber
	if input == 0 
	then return [] -- call function to process data
	else do 
		n <- getNumbers
		return (input:n)


-- collect integers returns list with min and max values, 
-- input:  user input terminated by an input of 0
-- output: print the list of input in the order entered
--         print the minimum and maximum values from the input
getNumbersMinMax :: IO ()
getNumbersMinMax = do
	nums <- getNumbers
	let minMax = listMinMax nums
	putStrLn "\nThe Numbers you entered were:"
	print nums
	putStrLn "The Minimum Value was: "
	print (fst minMax)
	putStrLn "The Maximum Value was: "
	print (snd minMax)

-- Sort list using merge-sort algorithm
-- input:  list of integers
-- output: sorted list of integers
mergeSort lis =
	if (null lis)
		then lis
		else if (null (tail lis))
			then lis
			else 
				let x = (split lis)
				in
					merge (mergeSort (head x)) (mergeSort (head (tail x))) 

-- Higher order function which increments another function input by n
-- input:  integer
-- output: function the increments any value passed to it by input 



----   HELPER FUNCTIONS
digits = ['0','1','2','3','4','5','6','7','8','9']

isDigit :: Char -> Bool
isDigit c = 
	if c `elem` digits
	then True
	else False

charToInt :: Char -> Int
charToInt c
	| c == '0' = 0
	| c == '1' = 1
	| c == '2' = 2
	| c == '3' = 3
	| c == '4' = 4
	| c == '5' = 5
	| c == '6' = 6
	| c == '7' = 7
	| c == '8' = 8
	| c == '9' = 9
	| otherwise = 0


getListOfDigits :: IO [Int]
getListOfDigits = do 
		c <- getChar
		if (c == '\n' || c == ' ' || not (isDigit c))
			then  
				return []
			else
				do
					n <- getListOfDigits 
					return ((charToInt c):n)

fromDigits = foldl addDigits 0 where
	addDigits num dig = 10 * num + dig

getNumber :: IO Int
getNumber = do
	neg <- getChar
	if (neg == '-')
		then do
			d <- getListOfDigits
			let x = fromDigits d
			return (-1 * x) 
		else do
			d <- getListOfDigits
			let t = ((charToInt neg):d)
			let x = fromDigits t 
			return x

getWord :: IO String
getWord = do 
	c <- getChar
	if (c == '\n' || c == ' ')
		then return ""
		else
			do
				w <- getWord
				return (c:w)

-- merges two lists together into a sorted list
-- input:  two lists
-- output: one sorted list containing all elements of the original list
merge left right
	| null left = right
	| null right = left
	| otherwise = 
		if ((head right) > (head left))
		then ((head left) :(merge (tail left)  right ))
		else ((head right):(merge (tail right) left  ))
		
-- Splits a list into 2 half list
-- input: a list
-- output: a list containing a pair of lists; 
--         list 1 contains even elements of the original list 
--         list 2 contains odd elements of the original list
split lis = div lis [] [] where
	div lis l r = 
		if (null lis)
			then [reverse l, reverse r] 
			else if (null (tail lis))
				then div [] ((head lis):l) r
				else if (null (tail (tail lis)))
					then div [] ((head lis):l) ((head (tail lis)):r)
					else div (tail (tail lis)) ((head lis):l) ((head (tail lis)):r)

