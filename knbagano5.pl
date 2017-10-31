/*This is the prolog file for assignment 5 in ICS 313. | */

ismember(A, [A|_]). 

ismember(A, [_|T]) :- 
  ismember(A, T). 
  
kalentest(A,B) :- member(B,[1,2,3]).

/*Self Notes: This works because...
-In the situation where the user passes a variable for the second parameter, when you get to the empty list the length is automatically zero.
This assigns length to 1 + the result of another variable which is passed into and evaluated by the predicate being called again recursively.
-In the situation where the user passes an actual number for the second parameter, it checks for equality between the number passed and 
1 + the result of another variable which is described above.
-Basically if the second parameter is a variable, "is" assigns value. If it's a actual number, "is" tests for equality.
*/
listlength([],Length) :-
	Length = 0.

listlength(List, Length) :-
	[H|T] = List,
	listlength(T, Length2),
	Length is 1 + Length2.



/* This is the code for situation 1. It works by having predicates for each possible pair, and then following a set of rules.
First you can't have the same pair back to back cause that would mean the last two items or first two are the same color. Second
you can't have the first and last pair be the same or else the third and fourth item would be the same. Lastly you can't have the
last pair be the reverse of the first pair or else the third and fourth item would be the same. After these is the rule given 
*/
pair(blue,yellow).
pair(blue,green).
pair(yellow,blue).
pair(yellow,green).
pair(green,blue).
pair(green,yellow).
sitone(A,B,C,D,E,F) :- 
	pair(A,B), pair(C,D), pair(E,F), \+ (pair(A,B) = pair(C,D)), \+ (pair(A,B) = pair(E,F)),
	\+ (pair(C,D) = pair(E,F)), \+ (pair(B,A) = pair(E,F)),\+ (A = B), \+ (B = C), \+ (C = D), \+ (D = E), \+ (E = F).
	

	



