% miscellaneous prolog problems

% fall 13, 5) graph of cities

% spring 13, 3) zip
% spring 13, 4) quicksort
% winter 13, 2) list functions

remove_all(_, [], []).
remove_all(X, [X|R], Result) :- remove_all(X,R,Result).
remove_all(RemoveMe, [X|R], [X|Result]) :- not(RemoveMe = X), remove_all(RemoveMe, R, Result).


remove_first(_, [], []).
remove_first(X, [X|R], R).
remove_first(RemoveMe, [X|R], [X|Result]) :- not(RemoveMe = X), remove_first(RemoveMe, R, Result).

% true iff A is a list prefix of B
prefix([],[]).
prefix([],[_|_]).
prefix([H|TA],[H|TB]) :- prefix(TA,TB).

% Winter 12, 4) mergesort
% winter 11, 5) SAT solving