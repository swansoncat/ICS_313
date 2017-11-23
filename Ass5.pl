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
  write('The person you''re looking for is '),
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

did(Sem) --> [did], statement(_^_^_^Sem). 

did(Sem) --> [did], statement(_^_^Sem). 

yesno(Sem) --> [is, it, true, that], statement(_^_^Sem).

yesno(Sem) --> [is, it, true, that], statement(_^Sem).  

yesno(Sem) --> [is, it, true, that], statement(Sem). 

statement(S) --> singlestatement(S).

statement(_^S) --> singlestatement(_^S).

statement(_^_^Sem) --> singlestatement(_^_^S1), [and], statement(_^_^S2), {append(S1,S2,Sem)}.

statement(_^_^Sem) --> singlestatement(_^S1), [and], statement(_^_^S2), {append(S1,S2,Sem)}.

statement(_^_^Sem) --> singlestatement(_^_^S1), [and], statement(_^S2), {append(S1,S2,Sem)}.

statement(_^_^Sem) --> singlestatement(_^S1), [and], statement(_^S2), {append(S1,S2,Sem)}.

singlestatement(Subj^Sem) --> 
 noun_phrase(Subj),
 verb_phrase(Subj^Sem).

singlestatement(Subj^Obj^Sem) --> 
 noun_phrase(Subj),
 verb_phrase(Subj^Obj^Sem).
 
singlestatement(Subj^Obj^X^Sem) --> 
 noun_phrase(Subj),
 verb_phrase(Subj^Obj^X^Sem).

noun_phrase(Sem) --> proper_noun(Sem).

prep(X) --> [in], noun_phrase(X).

verb_phrase(Subj^Sem) -->
    verb(Subj^Sem).

verb_phrase(Subj^Obj^Sem) -->
    verb(Subj^Obj^Sem),
    noun_phrase(Obj).
	
verb_phrase(Subj^Obj^X^Sem) -->
    verb(Subj^Obj^X^Sem),
    noun_phrase(Obj),
	prep(X).

proper_noun(star_wars4) --> [star, wars, iv].
proper_noun(star_wars3) --> [star, wars, iii].
proper_noun(star_trek) --> [star, trek].	
proper_noun(star_trek_tv) --> [star, trek, tv].

proper_noun(george_lucas) --> [george, lucas].
proper_noun(jj_abrams) --> [jj, abrams].
proper_noun(marc_daniels) --> [mark, daniels].

proper_noun(mark_hamill) --> [mark, hamill].
proper_noun(harrison_ford) --> [harrison, ford].
proper_noun(carrie_fisher) --> [carrie, fisher].
proper_noun(peter_cushing) --> [peter, cushing].
proper_noun(alec_guiness) --> [alec, guiness].
proper_noun(anthony_daniels) --> [anthony, daniels].
proper_noun(kenny_baker) --> [kenny, baker].
proper_noun(peter_mayhew) --> [peter, mayhew].
proper_noun(david_prowse) --> [david, prowse].
proper_noun(phil_brown) --> [phil, brown].
proper_noun(luke_skywalker) --> [luke, skywalker].
proper_noun(han_solo) --> [han, solo].
proper_noun(leia_organa) --> [leia, organa].
proper_noun(grand_moff_tarkin) --> [grand, moff, tarkin].
proper_noun(obi_wan_kenobi) --> [obi, wan, kenobi].
proper_noun(c3p0) --> [c3p0].
proper_noun(r2d2) --> [r2d2].
proper_noun(chewbacca) --> [chewbacca].
proper_noun(darth_vader) --> [darth, vader].
proper_noun(uncle_owen) --> [uncle, owen].

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

proper_noun(william_shatner) --> [william, shatner].
proper_noun(deforest_kelly) --> [deforest, kelly].
proper_noun(nichelle_nichols) --> [nichelle, nichols].
proper_noun(james_doohan) --> [james, doohan].
proper_noun(eddie_paskey) --> [eddie, paskey].
proper_noun(george_takei) --> [george, takei].
proper_noun(walter_koenig) --> [walter, koenig].
proper_noun(nmajel_barrett) --> [majel, barrett].
proper_noun(dr_mccoy) --> [dr, mccoy].
proper_noun(lt_leslie) --> [lt, leslie].
proper_noun(nurse_chapel) --> [nurse, chapel].

verb(X^Y^[acts_in(X,Y)]) --> [acts, in].
verb(X^Y^[play(X,Y)]) --> [play].
verb(X^Y^[play(X,Y)]) --> [played].
verb(X^Y^[play(X,Y)]) --> [plays].
verb(X^Y^[directed(X,Y)]) --> [direct].
verb(X^Y^[directed(X,Y)]) --> [is, an, director].
verb(X^Y^[directed(X,Y)]) --> [is, a, director].
verb(X^Y^Z^[play_as(X,Y,Z)]) --> [play].
verb(X^[actor(X)]) --> [is, a, actor].
verb(X^[actor(X)]) --> [is, an, actor].

/* DATABASE. Obviously, you're going to have to fill this out a lot. */

director(george_lucas).
director(jj_abrams).
director(marc_daniels).
directed(george_lucas, star_wars3).
directed(george_lucas, star_wars4).
directed(jj_abrams, star_trek).
directed(marc_daniels, star_trek_tv).


actor(ewan_mcgregor).
actor(natalie_portman).
actor(hayden_christensen).
actor(ian_mcdiarmid).
actor(samuel_jackson).
actor(jimmy_smits).
actor(frank_oz).
actor(christopher_lee).
actor(keisha_castle_hughes).

actor(mark_hamill).
actor(harrison_ford).
actor(carrie_fisher).
actor(peter_cushing).
actor(alec_guiness).
actor(anthony_daniels).
actor(kenny_baker).
actor(peter_mayhew).
actor(david_prowse).
actor(phil_brown).

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

actor(william_shatner).
actor(deforest_kelly).
actor(nichelle_nichols).
actor(james_doohan).
actor(eddie_paskey).
actor(george_takei).
actor(walter_koenig).
actor(majel_barrett).

acts_in(ewan_mcgregor, star_wars3).
acts_in(natalie_portman, star_wars3).
acts_in(hayden_christensen, star_wars3).
acts_in(ian_mcdiarmid, star_wars3).
acts_in(samuel_jackson, star_wars3).
acts_in(jimmy_smits, star_wars3).
acts_in(frank_oz, star_wars3).
acts_in(anthony_daniels, star_wars3).
acts_in(christopher_lee, star_wars3).
acts_in(keisha_castle_hughes, star_wars3).

acts_in(mark_hamill, star_wars4).
acts_in(harrison_ford, star_wars4).
acts_in(carrie_fisher, star_wars4).
acts_in(peter_cushing, star_wars4).
acts_in(alec_guiness, star_wars4).
acts_in(anthony_daniels, star_wars4).
acts_in(kenny_baker, star_wars4).
acts_in(peter_mayhew, star_wars4).
acts_in(david_prowse, star_wars4).
acts_in(phil_brown, star_wars4).

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

acts_in(leonard_nimoy, star_trek_tv).
acts_in(william_shatner, star_trek_tv).
acts_in(deforest_kelly, star_trek_tv).
acts_in(nichelle_nichols, star_trek_tv).
acts_in(james_doohan, star_trek_tv).
acts_in(eddie_paskey, star_trek_tv).
acts_in(george_takei, star_trek_tv).
acts_in(walter_koenig, star_trek_tv).
acts_in(majel_barrett, star_trek_tv).

play(ewan_mcgregor, obi_wan_kenobi).
play(natalie_portman, padme).
play(hayden_christensen, anakin_skywalker).
play(ian_mcdiarmid, palpatine).
play(samuel_jackson, mace_windu).
play(jimmy_smits, bail_organa).
play(frank_oz, yoda).
play(christopher_lee, count_dooku).
play(keisha_castle_hughes, queen_of_naboo).

play(mark_hamill, luke_skywalker).
play(harrison_ford, han_solo).
play(carrie_fisher, leia_organa).
play(peter_cushing, grand_moff_tarkin).
play(alec_guiness, obi_wan_kenobi).
play(anthony_daniels, c3p0).
play(kenny_baker, r2d2).
play(peter_mayhew, chewbacca).
play(david_prowse, darth_vader).
play(phil_brown, uncle_owen).

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

play(leonard_nimoy, spock).
play(william_shatner, kirk).
play(deforest_kelly, dr_mccoy).
play(nichelle_nichols, uhura).
play(james_doohan, scotty).
play(eddie_paskey, lt_leslie).
play(george_takei, sulu).
play(walter_koenig, chekov).
play(majel_barrett, nurse_chapel).

play_as(ewan_mcgregor, obi_wan_kenobi, star_wars3).
play_as(natalie_portman, padme, star_wars3).
play_as(hayden_christensen, anakin_skywalker, star_wars3).
play_as(ian_mcdiarmid, palpatine, star_wars3).
play_as(samuel_jackson, mace_windu, star_wars3).
play_as(jimmy_smits, bail_organa, star_wars3).
play_as(frank_oz, yoda, star_wars3).
play_as(anthony_daniels, c3p0, star_wars3).
play_as(christopher_lee, count_dooku, star_wars3).
play_as(keisha_castle_hughes, queen_of_naboo, star_wars3).

play_as(mark_hamill, luke_skywalker, star_wars4).
play_as(harrison_ford, han_solo, star_wars4).
play_as(carrie_fisher, leia_organa, star_wars4).
play_as(peter_cushing, grand_moff_tarkin, star_wars4).
play_as(alec_guiness, obi_wan_kenobi, star_wars4).
play_as(anthony_daniels, c3p0, star_wars4).
play_as(kenny_baker, r2d2, star_wars4).
play_as(peter_mayhew, chewbacca, star_wars4).
play_as(david_prowse, darth_vader, star_wars4).
play_as(phil_brown, uncle_owen, star_wars4).

play_as(chris_pine, kirk, star_trek).
play_as(zachary_quinto, spock, star_trek).
play_as(leonard_nimoy, spock_prime, star_trek).
play_as(eric_bana, nero, star_trek).
play_as(bruce_greenwood, pike, star_trek).
play_as(karl_urban, bones, star_trek).
play_as(zoe_saldana, uhura, star_trek).
play_as(simon_pegg, scotty, star_trek).
play_as(john_cho, sulu, star_trek).
play_as(anton_yelchin, chekov, star_trek).
play_as(ben_cross, sarek, star_trek).

play_as(leonard_nimoy, spock, star_trek_tv).
play_as(william_shatner, kirk, star_trek_tv).
play_as(deforest_kelly, dr_mccoy, star_trek_tv).
play_as(nichelle_nichols, uhura, star_trek_tv).
play_as(james_doohan, scotty, star_trek_tv).
play_as(eddie_paskey, lt_leslie, star_trek_tv).
play_as(george_takei, sulu, star_trek_tv).
play_as(walter_koenig, chekov, star_trek_tv).
play_as(majel_barrett, nurse_chapel, star_trek_tv).

