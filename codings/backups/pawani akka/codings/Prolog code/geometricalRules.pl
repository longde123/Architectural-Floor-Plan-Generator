% Write the output of a predicate to a text file
% lengthL([1,2,3,4,5],N), open('out.txt', write, Out), write(Out,N),
% close(Out).

housePlan(T) :- polygon(T).
housePlan([H|T]) :- polygon(H), housePlan(T).

line([[X1,Y1],[X2,Y2]]) :- integer(X1), integer(X2), integer(Y1),  integer(Y2).

line([[X1,Y1],[X2,Y2]]) :- between(1,10,X1), between(1,10,X2),between(1,10,Y1),between(1,10,Y2).

%  polygon(T):-
% polygonBasic([[X1,Y1],[X2,Y2]],[[X2,Y2],[X3,Y3]],[[X3,Y3],[X1,Y1]]).
% polygon([H|T]) :- line(H), polygon(T).

% polygonBasic([[X1,Y1],[X2,Y2]],[[X2,Y2],[X3,Y3]],[[X3,Y3],[X1,Y1]]).


% adjacentLine([[X1,Y1],[X2,Y2]],[[X3,Y3],[X4,Y4]], T1, T2) :- T1 is
% (Y2-Y1)/(X2-X1), T2 is (Y4-Y3)/(X4-X3), T1 is T2, (Y1-Y3)/(X1-X3) = T1,
% Sqrt(2,(((X1-X2)*(X1-X2))+((Y1-Y2)*(Y1-Y2)))) = (Sqrt(2,
% (((X1-X3)*(X1-X3))+((Y1-Y3)*(Y1-Y3)))) + Sqrt(2, (((X3-X2)*(X3-X2) +
% ((Y3-Y2)*(Y3-Y2)))))).



%area(T,A) :- line(T), findArea(T,A).
%area([H|T],A) :- line(H), area(T,A1), A is A+A1.

%findArea([[X,Y],[X1,Y1]],A) :- A is (((Y1+Y)/2) * (X1-X)).

%  polygon code

% polygonNew(T) :-
% polygonNew([[[X1,Y1],[X2,Y2]]|[[[X3,Y3],[X4,Y4]]|T]]) :- line()

lengthL([],0).
lengthL([H|T],N) :- lengthL(T,N2), N is N2+1.

%  checkPolygon([H|T]) :- lengthL([H|T],N), findNth([H|T],N,X),
% checkFirstAndLast(H,X).

% polygonNew([H|[HT|T]]).
% polygonNew([H|[HT|T]]) :- line(H), line(HT),
% checkFirstAndSecond(H,HT).

%  checkFirstAndSecond([[X1,Y1],[X2,Y2]], [[X3,Y3],[X4,Y4]]) :- X2=X3,
% Y2=Y3.

%  checkFirstAndLast([[X1,Y1],[X2,Y2]], [[X3,Y3],[X4,Y4]]) :- X1=X4,
% Y1=Y4.


% correct methods - definition of a polygon ******

isClosed([[X1,Y1]|L]) :- last(L, [X2,X1]).

isConnected([[X1,Y1],[Y1,Z1]]).
isConnected([[X1,Y1]|[[Y1,Z1]|L]]):- isConnected([[Y1,Z1]|L]).


polygon(X) :- isClosed(X), isConnected(X).

% check adjacency of two polygons

% adjacent([H|T],[H1|T1]) :- findNth([H|T],X), findNth([H1|T1],X).

adjacentNew(X,Y) :- findNth(X,A), findNth(Y,A).


% find adjacent correct one ******

findNth([X|T],X) .
findNth([H|T],X) :- findNth(T,X).

adjacent(X,Y) :-( findNth(X,[A,B]), findNth(Y,[A,B])) ; ( findNth(X,[A,B]), findNth(Y,[B,A]) ).



%  lineIntersect([[X1,Y1],[X2,Y2]],[[X3,Y3],[X4,Y4]]) :- ([X1+X,Y1+Y]) =
% ([X3-U],[Y3+V]).


% drawline([[X2,Y2],[X2,Y2]], M1, X2, Y2).
%  drawLine([[X1,Y1],[X2,Y2]], M1, X3, Y3) :- X3 is X1+1, Y3 is Y1+
% (M1*Y1), drawLine([[X3,Y3],[X2,Y2]], M1).

% check that intersection of two lines - Bresenham's line drawing
% algorithm - but this is not much good enough since sime time we have
% calculate millions of pixels and it is hard to identify decimal
% intersecting points

addToList(H,[H|T],T).
addToList(X,[H|T],[H|R]) :- addToList(X,T,R).

checkIntersection([P1,P2], [P3,P4]) :- lineDraw([P1,P2], L1), lineDraw([P3,P4], L2), findNth(L1,X), findNth(L2,X).

lineDraw([[X1,Y1],[X2,Y2]],R) :- X1<X2, getPo([[X1,Y1],[X2,Y2]], Po), getLine([[X1,Y1],[X2,Y2]],R , Po, DeltaY, DeltaX), DeltaY is Y2-Y1, DeltaX is X2-X1.

getPo([[X1,Y1],[X2,Y2]], Po) :- Po is 2*(Y2-Y1) - (X2-X1).

getLine([[X2,Y2],[X2,Y2]],R, Po,  DeltaY, DeltaX).
getLine([[X1,Y1],[X2,Y2]],[H|T], Po,  DeltaY, DeltaX) :- ( Po<0, addToList(N,R,[H|T]), N is (X1+1,Y1), Pk1 is Po + (2*DeltaY), getLine(N,[X2,Y2],R ,Pk1 ,DeltaY, DeltaX) ) ; ( Po>0,  addToList(N,R,[H|T]), N is (X1+1,Y1+1), Pk1 is Po + (2*DeltaY-2*DeltaX), getLine(N,[X2,Y2],R, Pk1, DeltaY, DeltaX) ).


% find the intersection of two lines using another method

lineNotIntersect([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]) :- L1X1<L2X1 ; L1X1 is L2X1,(L1X2<L2X2),  (((L2Y1-L1Y2)*(L1X2-L1X1)) - ((L2Y1-L2Y2)*(L1X2-L2X1))) > 0.

lineNotIntersect([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]) :- (L1X2>L2X2 ; L1X2 is L2X2), L1X1<L2X1 ; L1X1 is L2X1,  (((L2Y2-L1Y1)*(L1X2-L1X1)) - ((L1Y1-L1Y1)*(L2X2-L1X1))) > 0.

% polygon eke lines intersect wenawada kiyala balanne kohomada, whole
% lists deke iterate wenawada

% to find overlapping of two polygons

findMiddlePoint([[X3,Y3],[X4,Y4]],MX,MY) :- MX is (X3+X4)/2 , MY is (Y3+Y4)/2.

overlapping([[[X1,Y1],[X2,Y2]]|T1], [[[X3,Y3],[X4,Y4]]|T2]) :- findMiddlePoint([[X3,Y3],[X4,Y4]],MX,MY), lineNotIntersect([[X1,Y1],[MX,MY]],[[X3,Y3],[X4,Y4]]),

