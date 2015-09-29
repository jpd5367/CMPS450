-- Assignment: Haskell Project1
-- Class:      CMPS 450
-- Semester:   Fall 2015
-- Author:     Joseph DeHart
-- CLID:       jpd5367
-- Professor:  Dr. Mohsen Amini
-- Due Date:   Sept. 30, 2015 

-- Tail recursive function to return the length of an arbitrary List
-- Input:  List of Integers
-- Output: Integer representing the number of elements in the List
listLength :: (Num b) => [a] -> b
listLength lis = incr lis 0 where -- incr is recursive tag to iterate through List and count iterations
	-- Pattern if there are remaining elements in the List
	incr (x:xs) i = incr xs (i + 1)
	-- Pattern if the List is empty
	incr [] i = i

-- Function to compute the minimum and maximum value in a list of integers
-- Input:  List of Integers
-- Output: returns a pair containing minimum and maximum value in a list
listMinMax :: [Int] -> (Int, Int)
listMinMax lis = next lis (head lis) (head lis) where -- next is the iterating structure, both min and max are initialized to the 1st element
	-- if list is not empty, compare current element to current min and max recurse with appropriate values and remaining list
	next (x:xs) min max = next (xs) (if x < min then x else min) (if x > max then x else max)
	-- if the list is empty, return min max pair
	next [] min max = (min,max)

-- IO Function, Collects Integers from the user, return a List of Integers in the order entered
-- Input:  User inputs integers until 0 is received
-- Output: List of Integers in the order entered
getNumbers :: IO [Int]
getNumbers = do
	putStrLn "\nEnter an Integer, 0 to exit"
	input <- getNumber -- get number returns an Integer provided by the User
	if input == 0 -- Terminal condition 
	then return [] -- return an empty string to any previous calls if 0 is entered
	else do 
		n <- getNumbers -- if valid input continue to collect more numbers recursively
		return (input:n) -- after each recursive call returns concatenate Integer with the List of previous Integers

-- IO Function, Collect Integers from user, Print to screen: List of Integers as entered, Minimum value, Maximum value 
-- Input:  None at function call, At Runtime: User input Integers, terminated by an input of 0
-- Output: Print to screen the List of Input in the order entered
--         Print the minimum and maximum values from the input
getNumbersMinMax :: IO ()
getNumbersMinMax = do
	nums <- getNumbers -- get number returns an Integer provided by the User
	let minMax = listMinMax nums -- get minimum and maximun value from the list
	putStrLn "\nThe Numbers you entered were:" 
	print nums
	putStrLn "The Minimum Value was: "
	print (fst minMax) -- minimum value is the 1st element of the minMax pair
	putStrLn "The Maximum Value was: "
	print (snd minMax) -- maximum value is the 2nd element of the minMax pair

-- Sort list using merge-sort algorithm
-- Input:  List of Integers
-- Output: Sorted List of Integers
mergeSort ::  [Int] -> [Int]
mergeSort lis =
	if (null lis) 
		then lis -- if list is empty return the empty list
		else if (null (tail lis))
			then lis -- if the List has one element it is sorted return original list
			else -- List needs to be sorted
				let x = (split lis) -- Split the list into Two smaller lists
				in -- continue to recursively split the list until each list has only one element
				   -- then use merge to combine each sorted list until only one sorted List remains
					merge (mergeSort (head x)) (mergeSort (head (tail x))) 

-- Higher order function which returns a function to increment its parameter by n
-- Input:  Integer
-- Output: Function that increments its parameter by n 
inc_n :: (Num a) => a -> a -> a
inc_n n = (\f -> f + (n)) -- returns a function x + n

----   HELPER FUNCTIONS

-- Definition of a digit represented as a Char
digits = ['0','1','2','3','4','5','6','7','8','9']

-- Check if a char is a valid digit
-- Input:  Char
-- Output: Bool representing if input is a numberic digit between 0 and 9
charIsDigit :: Char -> Bool
charIsDigit c = 
	if c `elem` digits -- if char c is an element of digits return True
	then True
	else False

-- Converts a char type numberic character to an Integer
-- Input:  Char, must be an element of digit
-- Output: Integer equivelent to the Input
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

-- IO Function, Takes user input Integer and returns a List containing each digit of the Integer
-- Input:  none at call, user input Integer at runtime
-- Output: List of Integers, each containing 1 digit of a number 
getListOfDigits :: IO [Int]
getListOfDigits = do 
		c <- getChar
		if (c == '\n' || c == ' ' || not (charIsDigit c)) -- Terminal Case: c is equal to: newline, space, or non-numeric character
			then  
				return []
			else
				do
					n <- getListOfDigits -- recursive call to collect a single digit number
					return ((charToInt c):n) -- concatenate list of each digit

-- Converts a List of Integer digits to a single Integer
-- Input:  List of single Digit Integers
-- Output: Returns an Integer derived from a list of individual Integer digits
digitsToNum :: [Int] -> Int
digitsToNum = foldl sumDigits 0 where -- take a list of digits and fold each element from last to first
	-- each fold applies the following function to current digit and adds it to the sum of previous folds
	sumDigits num dig = 10 * num + dig

-- IO Function, Gets a Single Integer from user
-- Input:  None at call, a single Integer from user
-- Output: An Integer
getNumber :: IO Int
getNumber = do
	neg <- getChar -- get first character to later determine if we are working with a negative number
	d <- getListOfDigits -- get a List of Integer digits, done this way to get an Integer instead of a string
	if (neg == '-')
		then do -- if first character is '-' then multiply the Integer by -1 to make it negative
			let x = digitsToNum d
			return (-1 * x)
		else -- else then 1st character is either a digit or something else, but not a negative sign
			if charIsDigit neg
				then do -- if it is a digit the convert to an Integer digit and fold into the rest of the Integer
					let t = (charToInt neg):d
					let x = digitsToNum t
					return x
				else do -- if it is anything else disreguard first character input and return the Integer
					return (digitsToNum d)

-- IO Function, gets Input from the user, returns a string of Characters with no spaces
-- Function is similar to getLine, except a space terminates input as well as newline
-- Input:  None at call, String of characters from user at runtime
-- Output: Returns an IO String
getWord :: IO String
getWord = do 
	c <- getChar 
	if (c == '\n' || c == ' ') -- terminate input if newline or space
		then return ""
		else
			do
				w <- getWord -- recursive call to get more characters
				return (c:w) -- build a string by concatenating each char as the recursive calls return

-- Merges two sorted lists together into a single sorted list
-- Input:  two sorted lists
-- Output: one sorted list containing all elements of the two original sorted lists
merge :: (Ord a, Num a) => [a] -> [a] -> [a]
merge left right
	-- if left List is empty, return right List since it is already sorted
	| null left = right
	-- if right List is empty, return left List since it is already sorted
	| null right = left
	-- otherwise the two list will be joined in a manner which retains sorting
	| otherwise = 
		if ((head right) > (head left))
		-- Concatenate the head of the left list with the result of a recursive call to
		--     merge the remainder of the left list and the right list
		then ((head left) :(merge (tail left)  right ))
		-- Concatenate the head of the right list with the result of a recursive call to
		--     merge the remainder of the right list and the left list
		else ((head right):(merge (tail right) left  ))
		
-- Splits a list into 2 half lists
-- Input: a list
-- Output: a list containing a pair of lists; 
--         list 1 contains even elements of the original list 
--         list 2 contains odd elements of the original list
split :: (Num a) => [a] -> [[a]]
split lis = div lis [] [] where
	div lis left right = 
		if (null lis) -- if the list is empty then list is split and return the reverse of right and left list in a List
			-- reverse helps keep the input order
			then [reverse left, reverse right]
			-- if there is only one element in the list
			else if (null (tail lis))
				-- then recurse one last time adding the last element to the Left List  
				then div [] ((head lis):left) right
				-- if there are exactly two elements left in the original list
				else if (null (tail (tail lis)))
					-- then add the 1st to the left list and the second to the right
					then div [] ((head lis):left) ((head (tail lis)):right)
					-- there are at least 3 elements in the list
					--     add 1st element to left list, second element to right list, 
					--     and continue to process the rest of the list recursively
					else div (tail (tail lis)) ((head lis):left) ((head (tail lis)):right)