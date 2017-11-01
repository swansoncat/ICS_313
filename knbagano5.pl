
/* This is the prolog file for assignment 5 in ICS 313. I received help from the "Programming in Prolog" by The Simple Engineer
video series on Youtube, "Prolog Tutorial" by Derek Banas on Youtube, and www.tek-tips.com.
*/

ismember(A, [A|_]). 

ismember(A, [_|T]) :- 
  ismember(A, T). 
  
kalentest(A,B) :- member(B,[1,2,3]).

/* This is the code for part 1, where we are trying to find the length of a list.

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
	

/* This is the code for situation two. It works via the fact that no adjacent pairs will ever be the same, and pairs (1,2),(3,4),and (5,6)
will never be the same.
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

	
	
/* Situation 3. 1 Black, 2 White, 2 Red, 3 green.
-2 and 5 have to be red. We are told 6 and 7 aren't red. 1 can't be red cause you can't put a green left of it. 3 and 4 can't be red
because 2 and green can't be green. So 1,3,4,6,7 can't be red. That leaves 2,5,8. Because 4 and 8 are the same color, 8 can't be red because 4
4 cannot be red. So we have (green,red,?,green,red,?,?,?).
-8 is the same color as 4. So we have (green,red,?,green,red,?,?,green).
-So we have 1 black, 2 white remaining and only positions 3,6,7 left. So 3 different formations: black at 3, black at 6, or black at 7.
-Note to self: This worked completely after having rg(C,D,Dcount).
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
	
	

%Below is code used to test what ideas might would with the above code. Not part of homework
%With the rg predicate above and the A cannot be red rule, balls are restricted to having a green ball next to it.
k(blue).
k(red).
k(green).
tester(A,B,C) :- k(A), k(B), k(C), A \== red, rg(A,B,P1count), P1count ==  1, rg(B,C,P2count), P2count ==  1.
	




