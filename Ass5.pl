/* NOTE: This file is just a starting point! It is very much incomplete. You will have to modify the given clauses, and add new ones. 

Try these: 

?- top([is, it, true, that, mark, hamill, acts, in, star, wars, iv]).

?- top([who, acts, in, star, wars, iv]).

*/

/* TOP/1

ARG1 is a sentence represented as a list of atoms (e.g. [is, it, true, that, mark, hamill, acts, in, star, wars, iv]).

TOP/1 will succeed or fail. Either way, it should write out a sensible answer.

*/

top(Sentence) :-
  yesno(Query, Sentence, []), % This is a call to the DCG.
  showresults(Query).
  
top(Sentence) :-
  did(Query, Sentence, []),
  showresults(Query).

top(Sentence) :-
  who(Who, Sentence, []), % This is a call to the DCG.
  write("The person you're looking for is "),
  write(Who). % Can you make this better? It really should write out the text of the answer, not just the symbol. 
  


/* SHOWRESULTS/1 writes out positive text if ARG1 is a list of true predicates, negative text otherwise. */
showresults(Query) :-
  test(Query),
  write('Yes, that''s true.').

showresults(_) :-
  write('Sorry, that''s false.').

/* TEST/1 takes a list of predicates, and succeeds if all the predicates are true, otherwise fails.*/

test([Query]) :-
  Query.

test([Query|Rest]):-
  Query,
  test(Rest).

/* DCG: Here's the grammar. Right now it's very simple. */


who(X) --> [who], verb_phrase(X^_^[Query]), {Query}. 

did(Sem) --> [did], statement(_^_^Sem). 

yesno(Sem) --> [is, it, true, that], statement(_^_^Sem). 

statement(S) --> singlestatement(S).

statement(_^_^Sem) --> singlestatement(_^_^S1), [and], statement(_^_^S2), {append(S1,S2,Sem)}.

singlestatement(Subj^Obj^Sem) --> 
 noun_phrase(Subj),
 verb_phrase(Subj^Obj^Sem).

noun_phrase(Sem) --> proper_noun(Sem).

verb_phrase(Subj^Obj^Sem) -->
    verb(Subj^Obj^Sem),
    noun_phrase(Obj).

proper_noun(mark_hamill) --> [mark, hamill].
proper_noun(harrison_ford) --> [harrison, ford].
proper_noun(chris_pine) --> [chris, pine].
proper_noun(zachary_quinto) --> [zachary, quinto].
proper_noun(leonard_nimoy) --> [leonard, nimoy].
proper_noun(eric_bana) --> [eric, bana].
proper_noun(bruce_greenwood) --> [bruce, greenwood].
proper_noun(karl_urban) --> [karl, urban].
proper_noun(zoe_saldana) --> [zoe, saldana].
proper_noun(simon_pegg) --> [simon, pegg].
proper_noun(john_cho) --> [john, cho].
proper_noun(anton_yelchin) --> [anton, yelchin].
proper_noun(ben_cross) --> [ben, cross].
proper_noun(star_wars4) --> [star, wars, iv].
proper_noun(star_wars3) --> [star, wars, iii].
proper_noun(star_trek) --> [star, trek].
proper_noun(luke_skywalker) --> [luke, skywalker].
proper_noun(kirk) --> [kirk].
proper_noun(spock) --> [spock].
proper_noun(spock_prime) --> [spock, prime].
proper_noun(nero) --> [nero].
proper_noun(pike) --> [pike].
proper_noun(bones) --> [bones].
proper_noun(uhura) --> [uhura].
proper_noun(scotty) --> [scotty].
proper_noun(sulu) --> [sulu].
proper_noun(chekov) --> [chekov].
proper_noun(sarek) --> [sarek].
proper_noun(star_trek) --> [luke, skywalker].
verb(X^Y^[acts_in(X,Y)]) --> [acts, in].
verb(X^Y^[play(X,Y)]) --> [play].
verb(X^Y^[play(X,Y)]) --> [played].

/* DATABASE. Obviously, you're going to have to fill this out a lot. */

actor(mark_hamill).
actor(harrison_ford).
actor(chris_pine).
actor(zachary_quinto).
actor(leonard_nimoy).
actor(eric_bana).
actor(bruce_greenwood).
actor(karl_urban).
actor(zoe_saldana).
actor(simon_pegg).
actor(john_cho).
actor(anton_yelchin).
actor(ben_cross).
acts_in(mark_hamill, star_wars4).
acts_in(harrison_ford, star_wars4).
acts_in(chris_pine, star_trek).
acts_in(zachary_quinto, star_trek).
acts_in(leonard_nimoy, star_trek).
acts_in(eric_bana, star_trek).
acts_in(bruce_greenwood, star_trek).
acts_in(karl_urban, star_trek).
acts_in(zoe_saldana, star_trek).
acts_in(simon_pegg, star_trek).
acts_in(john_cho, star_trek).
acts_in(anton_yelchin, star_trek).
acts_in(ben_cross, star_trek).
play(chris_pine, kirk).
play(zachary_quinto, spock).
play(leonard_nimoy, spock_prime).
play(eric_bana, nero).
play(bruce_greenwood, pike).
play(karl_urban, bones).
play(zoe_saldana, uhura).
play(simon_pegg, scotty).
play(john_cho, sulu).
play(anton_yelchin, chekov).
play(ben_cross, sarek).