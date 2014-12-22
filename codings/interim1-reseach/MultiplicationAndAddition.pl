% Depth Limit Code
prove(true,N):-N>0.
prove((Goal1,Goal2),N):-N>0,prove(Goal1,N),prove(Goal2,N).
prove(Goal,D):-D>0,dif(true,Goal),X is D-1,clause(Goal,Body),prove(Body,X).

adda(M,K,L) :- L is M+K.


% Multiplication

multiplication([X|A],[B],W) :- mulByOneDeleteZero([X|A],B,W).
multiplication([X|A],[Y|B],W) :- multiplyRow([X|A],Y,R1),append(R1,[0],R11), plus1(R11,R2,W) , multiplication([X|A],B,R2).


%mulByOneDeleteZero([H|T],X,R2) :- mulByOne([H|T],X,R), addToList(0,R,R2).

% To multiply a row by a particular number
multiplyRow([X],M,R,Q) :- mul(X,M,R,Q).
multiplyRow([X|A],M,[Y|R],Q) :- multiplyRow(A,M,R,Q2), mul(X,M,N,L), da(N,Q2,Y,F), da(F,L,Q,0).

% Multiplication chart
mul(0,0,0,0).
mul(0,1,0,0).
mul(0,2,0,0).
mul(0,3,0,0).
mul(0,4,0,0).
mul(0,5,0,0).
mul(0,6,0,0).
mul(0,7,0,0).
mul(0,8,0,0).
mul(0,9,0,0).

mul(1,0,0,0).
mul(1,1,1,0).
mul(1,2,2,0).
mul(1,3,3,0).
mul(1,4,4,0).
mul(1,5,5,0).
mul(1,6,6,0).
mul(1,7,7,0).
mul(1,8,8,0).
mul(1,9,9,0).

mul(2,0,0,0).
mul(2,1,2,0).
mul(2,2,4,0).
mul(2,3,6,0).
mul(2,4,8,0).
mul(2,5,0,1).
mul(2,6,2,1).
mul(2,7,4,1).
mul(2,8,6,1).
mul(2,9,8,1).

mul(3,0,0,0).
mul(3,1,3,0).
mul(3,2,6,0).
mul(3,3,9,0).
mul(3,4,2,1).
mul(3,5,5,1).
mul(3,6,8,1).
mul(3,7,1,2).
mul(3,8,4,2).
mul(3,9,7,2).

mul(4,0,0,0).
mul(4,1,4,0).
mul(4,2,8,0).
mul(4,3,2,1).
mul(4,4,6,1).
mul(4,5,0,2).
mul(4,6,4,2).
mul(4,7,8,2).
mul(4,8,2,3).
mul(4,9,6,3).

mul(5,0,0,0).
mul(5,1,5,0).
mul(5,2,0,1).
mul(5,3,5,1).
mul(5,4,0,2).
mul(5,5,5,2).
mul(5,6,0,3).
mul(5,7,5,3).
mul(5,8,0,4).
mul(5,9,5,4).

mul(6,1,6,0).
mul(6,2,2,1).
mul(6,3,8,1).
mul(6,4,4,2).
mul(6,5,0,3).
mul(6,6,6,3).
mul(6,7,2,4).
mul(6,8,8,4).
mul(6,9,4,5).

mul(7,0,0,0).
mul(7,1,7,0).
mul(7,2,4,1).
mul(7,3,1,2).
mul(7,4,8,2).
mul(7,5,5,3).
mul(7,6,2,4).
mul(7,7,9,4).
mul(7,8,6,5).
mul(7,9,3,6).

mul(8,0,0,0).
mul(8,1,8,0).
mul(8,2,6,1).
mul(8,3,4,2).
mul(8,4,2,3).
mul(8,5,0,4).
mul(8,6,8,4).
mul(8,7,6,5).
mul(8,8,4,6).
mul(8,9,2,7).

mul(9,0,0,0).
mul(9,1,9,0).
mul(9,2,8,1).
mul(9,3,7,2).
mul(9,4,6,3).
mul(9,5,5,4).
mul(9,6,4,5).
mul(9,7,3,6).
mul(9,8,2,7).
mul(9,9,1,8).


% Addition

% Addition main function
plus1(A,B,R):-  plusMy(A,B,[0|R]).

	% Ommit unncessary zeros and prepare two lists into same length and call addition predicate
	plusMy(A,B,[0|R]) :- alignTwoLists(A,B,[0|X],[0|Y]), plusMy(X,Y,R).
	plusMy(A,B,[D|C]) :- alignTwoLists(A,B,X,Y), myPlusNew(X,Y,C,D).

		% Prepare two lists into same length by adding zeros infront of the small list, and manage the lists in same length also
		alignTwoLists(X,Y,X,B) :- (longOrEqual(X,Y,R1),addZeros(R1,Z1), append(Z1,Y,B)).
		alignTwoLists(X,Y,A,Y) :-  (longOrEqual(Y,X,R2),  addZerosEqual(R2,Z2), append(Z2,X,A)).

			% Check whether the lists are in same length and if not return the exceeding elements of long list
			longOrEqual(X,[],X).
			longOrEqual([H1|P],[H2|Q],X) :- longOrEqual(P,Q,X).

			% Provide a list with zeros similar to the number of elements given by above method
			addZeros([],[]).
			addZeros([H|X],[0|Y]) :- addZeros(X,Y).

			% Provide an empty list if the exceeding list is empty
			addZerosEqual([X],[0]).
			addZerosEqual([H|X],[0|Y]) :- addZerosEqual(X,Y).

		% Add two numbers similar in length and provide the output
		myPlusNew([A], [B], [C], D) :- da(A,B,C,D).
		myPlusNew([X|A], [Y|B], [Z|R], Q) :- myPlusNew(A,B,R,Q1), da(X,Q1,R2,Q2), da(R2,Y,Z,Q3), da(Q3,Q2,Q,0).

% Addition Chart

da(0,0,0,0).
da(0,1,1,0).
da(0,2,2,0).
da(0,3,3,0).
da(0,4,4,0).
da(0,5,5,0).
da(0,6,6,0).
da(0,7,7,0).
da(0,8,8,0).
da(0,9,9,0).

da(1,0,1,0).
da(1,1,2,0).
da(1,2,3,0).
da(1,3,4,0).
da(1,4,5,0).
da(1,5,6,0).
da(1,6,7,0).
da(1,7,8,0).
da(1,8,9,0).
da(1,9,0,1).

da(2,0,2,0).
da(2,1,3,0).
da(2,2,4,0).
da(2,3,5,0).
da(2,4,6,0).
da(2,5,7,0).
da(2,6,8,0).
da(2,7,9,0).
da(2,8,0,1).
da(2,9,1,1).

da(3,0,3,0).
da(3,1,4,0).
da(3,2,5,0).
da(3,3,6,0).
da(3,4,7,0).
da(3,5,8,0).
da(3,6,9,0).
da(3,7,0,1).
da(3,8,1,1).
da(3,9,2,1).

da(4,0,4,0).
da(4,1,5,0).
da(4,2,6,0).
da(4,3,7,0).
da(4,4,8,0).
da(4,5,9,0).
da(4,6,0,1).
da(4,7,1,1).
da(4,8,2,1).
da(4,9,3,1).

da(5,0,5,0).
da(5,1,6,0).
da(5,2,7,0).
da(5,3,8,0).
da(5,4,9,0).
da(5,5,0,1).
da(5,6,1,1).
da(5,7,2,1).
da(5,8,3,1).
da(5,9,4,1).


da(6,0,6,0).
da(6,1,7,0).
da(6,2,8,0).
da(6,3,9,0).
da(6,4,0,1).
da(6,5,1,1).
da(6,6,2,1).
da(6,7,3,1).
da(6,8,4,1).
da(6,9,5,1).


da(7,0,7,0).
da(7,1,8,0).
da(7,2,9,0).
da(7,3,0,1).
da(7,4,1,1).
da(7,5,2,1).
da(7,6,3,1).
da(7,7,4,1).
da(7,8,5,1).
da(7,9,6,1).

da(8,0,8,0).
da(8,1,9,0).
da(8,2,0,1).
da(8,3,1,1).
da(8,4,2,1).
da(8,5,3,1).
da(8,6,4,1).
da(8,7,5,1).
da(8,8,6,1).
da(8,9,7,1).


da(9,0,9,0).
da(9,1,0,1).
da(9,2,1,1).
da(9,3,2,1).
da(9,4,3,1).
da(9,5,4,1).
da(9,6,5,1).
da(9,7,6,1).
da(9,8,7,1).
da(9,9,8,1).
