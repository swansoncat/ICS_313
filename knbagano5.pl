/* This is the prolog file for assignment 5 in ICS 313. I received help from the "Programming in Prolog" by The Simple Engineer
video series on Youtube, "Prolog Tutorial" by Derek Banas on Youtube, and www.tek-tips.com.
*/




/* This is the code for part 1, where we are trying to find the length of a list. This works by incrementing the variable Length by one in each
recursive all of the predicate. It recurses by calling itself on the tail of the list .

Self Notes: This works because...
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
last pair be the reverse of the first pair or else the third and fourth item would be the same. After checking for these inferred rules,
the predicate checks for the rule that no adjacent ball is the same color.
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
	

/* This is the code for situation two. It works via the fact that no adjacent pairs will ever be the same, and pairs (1,2),(3,4),and (5,6)
will never be the same. It checks to make sure that the three main pairs (A & B, C & D, E & F) are one of the 5 possibilities listed below, and
then applied the prior mentioned rules.
*/
color(black,red).
color(black,blue).	
color(red,black).
color(blue,black).
color(black,black).
sittwo(A,B,C,D,E,F) :-
	color(A,B), color(C,D), color(E,F),\+ (pair(A,B) = pair(C,D)), \+ (pair(C,D) = pair(E,F)), \+ (pair(A,B) = pair(E,F)),
	\+ (pair(B,A) = pair(C,D)), \+ (pair(B,A) = pair(E,F)), \+ (pair(D,C) = pair(E,F)), \+ (pair(A,B) = pair(B,C)),
	\+ (pair(B,C) = pair(C,D)), \+ (pair(C,D) = pair(D,E)), \+ (pair(D,E) = pair(E,F)).

	
	
/* Below is the code used for situation 3. The main predicate makes use of two helper predicates: count(), which was obtained from
www.tek-tips.com and counts how many of an element is in a list, and rg(), which was made myself and checks to make sure all red balls are
preceded by green balls (except for the first position, that is checked in the main predicate). rg() works by saying either the second item in
pair can't be red, or if it is red the first item has to be green. This is checks for by its argument variable 'Pair'.

The main predicate has a few main parts. First it puts all the items into a list so that it can be used for the count() predicate. Then it
says that all arguments have to be one of the four colors. Then is the application of the specific rules of the situation such as how many balls
of each color there are and the requirements of specific positions.


Notes for self below:
-Situation 3. 1 Black, 2 White, 2 Red, 3 green.
-2 and 5 have to be red. We are told 6 and 7 aren't red. 1 can't be red cause you can't put a green left of it. 3 and 4 can't be red
because 2 and green can't be green. So 1,3,4,6,7 can't be red. That leaves 2,5,8. Because 4 and 8 are the same color, 8 can't be red because 4
4 cannot be red. So we have (green,red,?,green,red,?,?,?).
-8 is the same color as 4. So we have (green,red,?,green,red,?,?,green).
-So we have 1 black, 2 white remaining and only positions 3,6,7 left. So 3 different formations: black at 3, black at 6, or black at 7.
*/

count(_, [], 0).
count(X, [X | T], N) :-
  !, count(X, T, N1),
  N is N1 + 1.
count(X, [_ | T], N) :-
  count(X, T, N). 	

rg(A,B,Pair) :- B \== red, Pair = 1; A == green, B == red, Pair = 1.

sit3c(black).
sit3c(white).
sit3c(red).
sit3c(green).
sit3(A,B,C,D,E,F,G,H) :-
	List = [A,B,C,D,E,F,G,H], 
	sit3c(A), sit3c(B), sit3c(C), sit3c(D), sit3c(E), sit3c(F), sit3c(G), sit3c(H),
	A \== red, A \== white, H \== white, B \== green, C \== green, D == H, A \== G, F \== red, G \== red,
	count(black,List,Bcount), Bcount is 1, count(white,List,Wcount), Wcount is 2, count(red,List,Rcount),
	Rcount is 2, count(green,List,Gcount), Gcount is 3, rg(A,B,Acount), Acount ==  1, rg(B,C,Bcount), Bcount ==  1,
	rg(C,D,Ccount), Ccount ==  1, rg(D,E,Dcount), Dcount ==  1, rg(E,F,Ecount), Ecount ==  1, rg(F,G,Fcount), Fcount ==  1,
	%note that you have issues with the below line because the variable Gcount was already used above.
	rg(G,H,GGcount), GGcount ==  1.
	

/* This is the code checking to see if a list of integers can be split into 3 parts whose total is less than N.
How I'm expecting this should work is that you need to get the first part by traversing till you find its greater than N, and then
with the remaining part do the same. This probably needs to be done recursively.

This is a greedy problem.
-Note to self: '=' and 'is' are not evaluated the same. = seems to concatenate, is does mathematics
Also cannot modify a argument that was passed as an outright number and not variable.
*/
countElements([], Remaining, Subsets,N).

countElements(List, Remaining, Subsets,N) :-
	[H|T] = List,
	%RetR & RetS are not insubstatiated, these are used to unify witha  value that will be passed to a recursive call of the prediate.
	testr(H,Remaining,RetR,Subsets,RetS,N), RemainingNew is RetR, SubsetsNew = RetS,
	countElements(T, RemainingNew, SubsetsNew,N).

testr(Head,Remainder,RetRemainder,Subsets,RetSubset,N) :-
	Head < Remainder, RetRemainder is Remainder - Head, RetSubset is Subsets, write(RetSubset), write(Head), write(Remainder),nl;
	Head == Remainder, RetRemainder is N, RetSubset is Subsets - 1, RetSubset >= 0, write(RetSubset), write(Head), write(Remainder),nl;
	Head > Remainder, RetRemainder is N - Head, RetSubset is Subsets - 1, RetSubset > 0, write(RetSubset), write(Head), write(Remainder),nl.
	
split3(List,N) :-
	countElements(List,N,3,N).
	
	

%Below is code used to test what ideas might would with the above code. Not part of homework
%With the rg predicate above and the A cannot be red rule, balls are restricted to having a green ball next to it.
k(blue).
k(red).
k(green).
tester(A,B,C) :- k(A), k(B), k(C), A \== red, rg(A,B,P1count), P1count ==  1, rg(B,C,P2count), P2count ==  1.
	

ismember(A, [A|_]). 

ismember(A, [_|T]) :- 
  ismember(A, T). 
  
kalentest(A,B) :- member(B,[1,2,3]).


