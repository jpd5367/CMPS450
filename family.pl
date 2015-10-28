/**************************************************************************/
/* Assignment: Prolog, Logic Programming, part A                          */
/* Class:      CMPS 450                                                   */
/* Semester:   Fall 2015                                                  */
/* Author:     Joseph DeHart                                              */
/* CLID:       jpd5367                                                    */
/* Professor:  Dr. Mohsen Amini                                           */
/* Due Date:   Oct. 31, 2015                                              */
/**************************************************************************/

/*========================================================================*/
/*  Facts                                                                 */

/* Male family member names  ------------------------------------------------*/
male( 'Joseph').
male( 'Jesse').
male( 'Roy').
male( 'Will').
male( 'Ronald').
male( 'Norman').
male( 'Joe').
male( 'Michael').
male( 'Zach').
male( 'Richard').
male( 'Grant').
male( 'Scott'). 
male('Cameron').
male( 'Justin').

/* Female family member names -----------------------------------------------*/
female( 'Irma').
female( 'Ida').
female( 'Jackie').
female( 'Joan').
female( 'Lisa').
female( 'Ashley').
female( 'Terri').
female( 'Ruth').
female( 'Vicki').
female( 'Peggy').
female( 'Julaine').
female( 'Angie').
female( 'Shari').
female( 'Shawn').
female( 'Lauren').
female( 'Erica').
female( 'Morgan').
female( 'Monica').
female( 'Madeline').
female( 'Julie').
female( 'Sarah').
female( 'Gabby').
female('Monique').
female( 'Lanie').

/* Parent Relationships ----------------------------------------------------*/
parent( 'Jackie', 'Joe').
parent( 'Ronald', 'Joe').
parent( 'Jackie', 'Angie').
parent( 'Ronald', 'Angie').
parent( 'Jackie', 'Shari').
parent( 'Ronald', 'Shari').
parent( 'Ida', 'Ronald').
parent( 'Jesse', 'Ronald').
parent( 'Irma', 'Jackie').
parent( 'Joseph', 'Jackie').
parent( 'Joan', 'Shawn').
parent( 'Wayne', 'Shawn').
parent( 'Joan', 'Micheal').
parent( 'Wayne', 'Micheal').
parent( 'Joan', 'Lauren').
parent( 'Wayne', 'Lauren').
parent( 'Peggy', 'Lanie').
parent( 'Tim', 'Lanie').
parent( 'Joseph', 'Joan').
parent( 'Irma', 'Joan').
parent( 'Ida', 'Peggy').
parent( 'Jesse', 'Peggy').
parent( 'Ida', 'Julaine').
parent( 'Jesse', 'Julaine').
parent( 'Jesse', 'Norman').
parent( 'Ida', 'Norman').
parent( 'Irma', 'Roy').
parent( 'Joseph', 'Roy').
parent( 'Irma', 'Will').
parent( 'Joseph', 'Will').
parent( 'Irma', 'Lisa').
parent( 'Joseph', 'Lisa').
parent( 'Irma', 'Ashley').
parent( 'Joseph', 'Ashley').
parent( 'Irma', 'Vicky').
parent( 'Joseph', 'Vicky').
parent( 'Irma' , 'Ruth').
parent( 'Joseph', 'Ruth').
parent( 'Irma', 'Terri').
parent( 'Joseph', 'Terri').
parent( 'Will', 'Richard').
parent( 'Annete', 'Richard').
parent( 'Will', 'Erica').
parent( 'Annete', 'Erica').
parent( 'Will', 'Zach').
parent( 'Anette', 'Zach').
parent( 'Lisa', 'Morgan').
parent( 'Lisa', 'Monica').
parent( 'Lisa', 'Justin').
parent( 'Ashley', 'Madeline').
parent( 'Terri', 'Julie').
parent( 'Terri', 'Scott').
parent( 'Ruth', 'Sarah').
parent( 'Ruth', 'Grant').
parent( 'Ruth', 'Gabby').
parent( 'Vicky', 'Cameron').
parent( 'Vicky', 'Monique').

/* Rules ==========================================================================*/
father(X,Y):- parent(X,Y), male(X).
mother(X,Y):- parent(X,Y), female(X).
sibling(X,Y):- parent(Z,X), parent(Z,Y), not(=(X,Y)).
sister(X,Y):-  sibling(X,Y), female(X).
brother(X,Y):- sibling(X,Y), male(X).
grandParent(X, Y):- parent(X,Z), parent(Z,Y).
grandMother(X, Y):- grandParent(X, Y), female(X).
grandFather(X, Y):- grandParent(X, Y), male(X).
paternalGrandMother(X, Y):- father(Z, Y), mother(X, Z).
maternalGrandMother(X, Y):- mother(Z, Y), mother(X, Z).
paternalGrandFather(X, Y):- father(Z, Y), father(X, Z).
maternalGrandFather(X, Y):- mother(Z, Y), father(X, Z).
grandChild(X, Y):- grandParent(Y, X).
grandSon(X, Y):- grandChild(X, Y), male(X).
grandDaughter(X, Y):- grandChild(X, Y), female(X).
child(X, Y):- parent(Y, X).
son(X, Y):- child(X, Y), male(X).
daughter(X, Y):- child(X, Y), female(X).
cousin(X,Y):- sibling(Z,P), parent(Z,X), parent(P,Y).
aunt(X, Y):- parent(P, Y), sibling(X,P), female(X).
uncle(X, Y):- parent(P, Y), sibling(X,P), male(X).

/* My Goals ----------------------------------------------------------------------*/
myGoals():-
	write("My name is 'Joe' in these examples\n"),
	write("Goal 1: Who are my Grandparents? \n"),
	grandParent(X, 'Joe'),
	write(X),
	write(", "),
	fail;

	write("\n\n"),
	write("Goal 2, Who are my Cousins? \n"),
	setof(X,cousin(X, 'Joe'), Out),
	write(Out),
	fail;

	write("\n\n"),
	write("Goal 3, Who are my Aunts? \n"),
	setof(X, aunt(X, 'Joe'), Out),
	write(Out),
	fail;

	write("\n\n"),
	write("Goal 4, my Paternal Grandmother is? \n"),
	paternalGrandMother(X, 'Joe'),
	write(X),
	fail;

	write("\n\n"),
	write("Goal 5, my Maternal Grandfather is? \n"),
	maternalGrandFather(X, 'Joe'),
	write(X),
	fail;

	write("\n\n"),
	write("Goal 6, Who are my Uncles? \n"),
	setof(X, uncle(X, 'Joe'), Out),
	write(Out),
	fail.

