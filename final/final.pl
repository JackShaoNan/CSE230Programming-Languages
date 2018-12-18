% fa13
% 5
% a

link(san_diego, seattle).
link(seattle, dallas).
link(dallas, new_york).
link(new_york, chicago).
link(new_york, seattle).
link(chicago, boston).
link(boston, san_diego).

path_2(A,B) :- link(A,C), link(C,B).

% b
path_3(A,B) :- link(A,C), path_2(C,B).

% c
% N = 1
path_N(A,B,N) :- N=1,link(A,B). 
% N > 1
path_N(A,B,N) :- N>1,M is N-1,link(A,C),path_N(C,B,M).

% d
path_helper(A, B, Seen) :- link(A,B), not(member(B, Seen)).
path_helper(A, B, Seen) :-
link(A,C),
not(member(C, Seen)),
path_helper(C, B, [C|seen]).

path(A, B) :- path_helper(A, B, []).


% sp13
% 3
zip([],[],[]).
zip([H1|T1],[H2|T2],[[H1,H2]|T3]) :- zip(T1,T2,T3).

% 4
part([],P,[],[]).
part([H|T],P,[H|T1],B) :- H =< P, part(T,P,T1,B).
part([H|T],P,A,[H|T2]) :- H > P, part(T,P,A,T2).

qsort([],[]).
qsort([H|T],R) :- part(T,H,X,Y), qsort(X,R1), qsort(Y,R2), append(R1,[H|R2],R).

% wi13
remove_all(_,[],[]).
remove_all(X,[H|T],R) :- X = H, remove_all(X,T,R).
remove_all(X,[H|T],[H|T1]) :- X \= H, remove_all(X,T,T1).

remove_first(_,[],[]).
remove_first(X,[H|T],R) :- X = H, T = R.
remove_first(X,[H|T],[H|T1]) :- X \= H, remove_first(X,T,T1). 


prefix([],_).
prefix([H1|T1],[H2|T2]) :- H1=H2, prefix(T1,T2).


segment(A,B) :- prefix(A,B).
segment(A,[H|T]) :- segment(A,T).


% wi12
% 4
sorted([]).
sorted([H|[]]).
sorted([A,B|T]) :- A =< B, sorted([B|T]).

mysort(L1,L2) :- permutation(L1,L2), sorted(L2), !.

split([],[],[]).
split([H],[H],[]).
split([X|T],[X|T1],T2) :- split(T,T2,T1).

merge([],L,L).
merge(L,[],L).
merge([H1|T1],[H2|T2],[H1|R]) :- H1 =< H2, merge(T1,[H2|T2],R).
merge([H1|T1],[H2|T2],[H2|R]) :- H2 < H1, merge([H1|T1],T2,R).



merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(L,S) :- split(L,L1,L2),merge_sort(L1,S1),merge_sort(L2,S2),merge(S1,S2,S).

% wi11
% 5
sat(var(X)) :- X = 1.
sat(not(var(X))) :- X = 0.
sat(and([])).
%% Fill in the other case(s) for ‘‘and’’ here:
sat(and([X|T])) :- sat(X), sat(and(T)).

sat(or([])) :- fail.
%% Fill in the other case(s) for ‘‘or’’ here:
%sat(or([X|T])) :- sat(X), not sat(or(T)).
sat(or([_|T])) :- sat(or(T)).

bool(X) :- X = 0.
bool(X) :- X = 1.
bools([]).
bools([X | Tail]) :- bool(X),bools(Tail).


allsat(X, var(X)) :- bool(X), sat(var(X)).
%allsat(X, not(var(X)) :- bool(X), sat(not(var(X))).
allsat(L,and(T)) :- bools(L), sat(and(T)).
allsat(L,or(T)) :- bools(L), sat(or(T)).

com([],[]).
com([X],[X]).
com([X,Y|T],R) :- X = Y, com([Y|T],R).
com([X,Y|T],[X|R]) :- X \= Y, com([Y|T],R). 

sum([],0).
sum([H|T],R) :- sum(T,R1),R is R1+H.


inclass(a,130,88).
inclass(b,130,89).
inclass(c,130,899).
%class_grade(C,G) :- inclass(_,C,G).

class_grade(C,Bag) :- bagof(G, inclass(_, C, G), Bag).















































