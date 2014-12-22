% lengthL([1,2,3,4,5],N), open('out.txt', write, Out), write(Out,N),
% close(Out).

housePlan(T) :- polygon(T).
housePlan([H|T]) :- polygon(H), housePlan(T).

% line([[X1,Y1],[X2,Y2]]) :- integer(X1), integer(X2), integer(Y1),
% integer(Y2).

line([[X1,Y1],[X2,Y2]]) :- between(1,2,X1), between(1,2,X2),between(1,2,Y1),between(1,2,Y2).

lengthL([],0).
lengthL([H|T],N) :- lengthL(T,N2), N is N2+1.

% correct methods - definition of a polygon ******

%isClosed([[X1,Y1]|L]) :- last(L, [X2,X1]).

%isConnected([[X1,Y1],[Y1,Z1]]).
%isConnected([[X1,Y1]|[[Y1,Z1]|L]]):- isConnected([[Y1,Z1]|L]).


%polygon(X) :- isClosed(X), isConnected(X).

isClosed([[X1,Y1]|L]) :- last(L, [X2,X1]).

isConnected([[X1,Y1],[Y1,Z1],[Z1,U1]]):- line([X1,Y1]),line([Y1,Z1]),line([Z1,U1]).

isConnected([[X1,Y1]|[[Y1,Z1]|L]]):- isConnected([[Y1,Z1]|L]), line([X1,Y1]),line([Y1,Z1]).


polygon(X) :- isClosed(X), isConnected(X).


% find adjacent correct one ******

findNth([X|T],X) .
findNth([H|T],X) :- findNth(T,X).

adjacent(X,Y) :-( findNth(X,[A,B]), findNth(Y,[A,B])) ; ( findNth(X,[A,B]), findNth(Y,[B,A]) ).



addToList(H,[H|T],T).
addToList(X,[H|T],[H|R]) :- addToList(X,T,R).


% find the intersection of two lines using another method

min([X], X).
min([X,Y|L], Min) :- MinXY is min(X, Y), min([MinXY|L], Min).

% intersectionConventions([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]],[[L1X3,L1Y1],[L1X4,L1Y1]],[[L2X3,L2Y1],[L2X4,L2Y2]])
% :- min([L1X1,L1X2,L2X1,L2X2],L1X3), .
%
intersectionConventions([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]) :-  min([L1X1,L1X2,L2X1,L2X2],L1X3), findY(L1X3,MinY, [[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]).

%findY(L1X3,MinY, [[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]):-

lineNotIntersect([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]) :- L1X1<L1X2, L2X1<L2X2, (L1X1<L2X1 ; L1X1 is L2X1), (L1X2<L2X2 ; L1X2 is L2X2), (((L2Y1-L1Y2)*(L1X2-L1X1)) - ((L2Y1-L2Y2)*(L1X2-L2X1))) > 0.

lineNotIntersect([[L1X1,L1Y1],[L1X2,L1Y2]],[[L2X1,L2Y1],[L2X2,L2Y2]]) :- L1X1<L1X2, L2X1<L2X2, L1X1<L2X1, L1X2>L2X2, (((L2Y2-L1Y1)*(L1X2-L1X1)) - ((L1Y1-L1Y1)*(L2X2-L1X1))) > 0.

% polygon eke lines intersect wenawada kiyala balanne kohomada, whole
% lists deke iterate wenawada

% polygons dekak intersect wenawada balanna all lines eka list ekakata
% dagena check karana code eka ******
combineTwoPolygons([T1],[T2], BL) :- addToList(T1,BL,[]), addToList(T2,BL,[]).
combineTwoPolygons([H1|T1],[H2|T2],BL) :- addToList(H1,BL,T1), addToList(H2,BL,T2),combineTwoPolygons(T1,T2).


% checkPolygonInterSection(X,Y) :- combineTwoPolygons(X,Y,BL),
% checkIntersection(BL).
%

checkPolygonInterSection(X,Y) :- append(X,Y,R),checkIntersection(R).

checkIntersection([H,T]) :- lineNotIntersect(H,T).
checkIntersection([H|[H1|T]]) :- lineNotIntersect(H,H1), checkIntersection([H|T]), checkIntersection([H1|T]).


% to find overlapping of two polygons

findMiddlePoint([[X3,Y3],[X4,Y4]],MX,MY) :- MX is (X3+X4)/2 , MY is (Y3+Y4)/2.

overlapping([[[X1,Y1],[X2,Y2]]|T1], [[[X3,Y3],[X4,Y4]]|T2]) :- findMiddlePoint([[X3,Y3],[X4,Y4]],MX,MY), lineNotIntersect([[X1,Y1],[MX,MY]],[[X3,Y3],[X4,Y4]]),

