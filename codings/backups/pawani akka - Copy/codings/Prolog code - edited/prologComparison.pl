% multiplication

simpleAdd(A,B,R):- R is A+B.

multipli(A,B,R) :- R is A.
multipli(A,B,R) :- B1>0, B1 is B-1, multipli(A,B1,R1), R is R1+A.

%multipli(A,B,R) :- plusMy(A,R1,R), B1 is B-1, multipli(A,B1,R1), B1>0.


% addition

plusMy(A,B,[D|C]) :- myPlus(A,B,C,D).
myPlus([A], [B], [C], D) :- da(A,B,C,D).
myPlus([X|A], [Y|B], [Z|R], Q) :- myPlus(A,B,R,Q1), da(X,Q1,R2,Q2), da(R2,Y,Z,Q3), da(Q3,Q2,Q,0).

% comparison

longOrEqual(X,[],X).
longOrEqual([H1|P],[H2|Q],X) :- longOrEqual(P,Q,X).

addZeros([X],[0]).
addZeros([H|X],[0|Y]) :- addZeros(X,Y).


alignTwoLists(X,Y,A,B) :- (longOrEqual(X,Y,R1),addZeros(R1,Z1), append(Z1,Y,B), append([],X,A)) ; (longOrEqual(Y,X,R2),  addZeros(R2,Z2), append(Z2,X,A), append([],Y,B)).

large(0,1).
large(0,2).
large(0,3).
large(0,4).
large(0,5).
large(0,6).
large(0,7).
large(0,8).
large(0,9).

large(1,2).
large(1,3).
large(1,4).
large(1,5).
large(1,6).
large(1,7).
large(1,8).
large(1,9).

large(2,3).
large(2,4).
large(2,5).
large(2,6).
large(2,7).
large(2,8).
large(2,9).

large(3,4).
large(3,5).
large(3,6).
large(3,7).
large(3,8).
large(3,9).

large(4,5).
large(4,6).
large(4,7).
large(4,8).
large(4,9).

large(5,6).
large(5,7).
large(5,8).
large(5,9).

large(6,7).
large(6,8).
large(6,9).

large(7,8).
large(7,9).

large(8,9).
