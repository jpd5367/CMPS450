/*------------------------------------------------------------------------*/
/* Assignment: Prolog, Logic Programming, parts B-D                       */
/* Class:      CMPS 450                                                   */
/* Semester:   Fall 2015                                                  */
/* Author:     Joseph DeHart                                              */
/* CLID:       jpd5367                                                    */
/* Professor:  Dr. Mohsen Amini                                           */
/* Due Date:   Oct. 31, 2015                                              */
/*------------------------------------------------------------------------*/


/*  B)  Compute the Min and Max of a list                                 */
/* ---------------------------------------------------------------------- */

/* Function Takes a list and outputs the minimum and maximum values       */
/* Input:  L: List of Integers                                            */ 
/* Output: Minimum and Maximum Value printed to console                   */
listMinMax(L):- 
	[H|T] = L, 
	Min = H, 
	Max = H, 
	loopMinMax(Min, Max, T), 
	!.  

/* Function takes 2 comparable values and returns the larger of the two   */
/* Input:  A: first comparable value                                      */
/*         B: second comparable value                                     */
/* Output: X: larger value of A and B                                     */
isLarger(A,B,X):- 
	A > B, 
	X = A; 

	B > A, 
	X = B.                           

/* Function takes 2 comparable values and returns the Smaller of the two  */
/* Input:  A: first comparable value                                      */
/*         B: second comparable value                                     */
/* Output: X: smaller value of A and B                                    */
isSmaller(A,B,X):- 
	A < B, 
	X = A; 

	B < A, 
	X = B. 

/* Terminating Function for Processing loop of listMinMax                 */
/* Input:  Min: first comparable value                                    */
/*         Max: second comparable value                                   */
/* Output: Minimum and Maximum values are printed to console              */
loopMinMax(Min, Max, []):- 
	write("Min = "), 
	write(Min), 
	write("\nMax = "), 
	write(Max), 
	!.

/* Recursive Function for Processing loop of listMinMax                   */
/* Input:  Min: first comparable value                                    */
/*         Max: second comparable value                                   */
/*         L:   Remaining Portion of List                                 */
/* Output: None                                                           */
loopMinMax(Min, Max, L):- 
	[H|T] = L, 
	isLarger(H, Max, NewMax), 
	isSmaller(H, Min, NewMin), 
	loopMinMax(NewMin, NewMax, T).


/* C) Read from standard input until 0 is entered,                                 */
/*    create a list from input excluding 0                                         */
/*    then print the list in the order entered                                     */
/* ------------------------------------------------------------------------------- */

/* Function collects Integers from the user until 0 is entered, then display input */
/* Input:  User input from terminal                                                */
/* Output: List of integers, entered by the user                                   */
getInts():-
	getIntsLoop([], _).

/* Processing Loop for getInts Function                                            */
/* Input:  TempList: cumulative list of user input                                 */
/* Output: Writes List containing, user provided integer are printed to console    */
getIntsLoop(TempList, FinalList):-
	write("Please enter an Integer...\n"),
	write("terminate each integer with '. [enter]'\n"), 
	write("enter '0.' finish input\n\n"),
	read(N),
	not(=(N,0)),
	append(TempList,[N], Y),
	getIntsLoop(Y, Y);
	
	write("Input = "),
	write(FinalList).
	

/* D) Implement Merge-Sort for a list of integers */
/* ------------------------------------------------------------------------ */

/* Function to sort a list of integer using the Merge-Sort algorithm               */
/* Input:  L:      Unsorted list of Integers                                       */
/* Output: Result: Sorted list of Integers                                         */
mergeSort(L, Result):- 
	(
		=(L, []), 
		Result = L; 
		(
			[_|T] = L, 
			=(T,[]), 
			Result = L;
			( 
				splitList(L, Left, Right),
				mergeSort(Left, LeftResult),
				mergeSort(Right, RightResult),
				mergeLists(LeftResult, RightResult, Result),
				!
			)
		)
	).


/* Function to merge two sorted lists into a single sorted list                    */
/* Input:  Left:   Sorted list of Integers                                         */
/*         Right:  Sorted list of Integers                                         */ 
/* Output: Result: Sorted list containing all Integers from Left and Right list    */
mergeLists(Left, Right, Result):- 
	=(Left, []), 
	Result = Right;
	
	=(Right, []), 
	Result = Left;
	
	(
		[HR|_] = Right,
		[HL|TL] = Left,
		HR >= HL, 
		mergeLists(TL, Right, PartialResult), 
		append([HL], PartialResult, Result);
	
		[HR|TR] = Right,
		[HL|_] = Left,
		HL > HR, 
		mergeLists(TR, Left, PartialResult),
		append([HR], PartialResult, Result)
	).

/* Function splits one list into 2 list of similar list(+- one element)            */
/* Input:  L: List of Integers                                                     */
/* Output: Left:  List containing half of the integers of L                        */
/*         Right: List containing the remaining half of integers of L              */
splitList(L, Left, Right):- 
	=(L,[]);
	(splitListLoop(L, [], [], X, Y)),
	Left = X,
	Right = Y.

/* Processing Loop Function for splitList                                            */
/* Input:  L:           Remaining portion of the list to be processed                */
/*         Left:        List containing even elements of L previously processed      */
/*         Right:       List containing odd elements of L previously processed       */
/* Output: LeftResult:  List containing even elements of L Post processing loop      */
/*         RightResult: List containing odd elements of L Post processing loop       */
splitListLoop(L, Left, Right, LeftResult, RightResult):-
	=(L,[]),
	myReverse(Left, LeftResult),
	myReverse(Right, RightResult);
	(
		[H|T] = L,
		=(T, []),
		append([H], Left, NewLeft),
		splitListLoop([], NewLeft, Right, LeftResult, RightResult);
		(
			[H|T] = L,
			[H2|T2] = T,
			=(T2, []),
			append([H], Left, NewLeft),
			append([H2], Right, NewRight),
			splitListLoop([], NewLeft, NewRight, LeftResult, RightResult);
			(
				[H|T] = L,
				[H2|T2] = T,
				append([H], Left, NewLeft),
				append([H2], Right, NewRight),
				splitListLoop(T2, NewLeft, NewRight, LeftResult, RightResult)
			)
		)
	).

/* Function takes a list as input and returns a list in reverse order              */
/* Input:  L: List of Integers                                                     */
/* Output: Left:  List containing L elements in reverse order                      */
myReverse(L, Result):-
	=(L,[]),
	Result = L;
	
	[H|T] = L,
	myReverse(T,X),
	append(X, [H], Result).