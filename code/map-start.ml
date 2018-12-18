(*

For this section, we will cover map and fold_left in detail. The outline:

0), a very brief motivation for map and fold_left.
1), a brief recap of the definition of map.
2), a number of easy map problems.
3), a brief recap of the definition of fold_left.

HINT: A lot of these problems were pulled from past midterms! You'll probably
see a map and/or fold_left problem on the midterm :).


*)

(*

0): Why are map and fold_left cool?

Lists are very common in functional programming. One way to manipulate and
process list data is by recursive functions. This is a general technique, but
can get tedious and error-prone very quickly. Recursion is hard!

Map and fold_left are two ways to calculate over lists that abstract over recursion.

*)

(*

1): THE DEFINITION OF MAP

The idea behind the map function is that, for list transformation functions, it's easy
to define a function on each individual element. For example, consider incrementNumbers,
which takes a list of ints, increments each int, and returns a list of the results.
A natural way to phrase the problem is "increment each int in the list", i.e.


incrementNumbers xs:

[1; 2; 4; 7; 3]    <- xs
 |  |  |  |  |
   increment
 |  |  |  |  |
 v  v  v  v  v
[2; 3; 5; 8; 4]    <- result

Map generalizes this problem by abstracting over the input list and input function:

map func xs:

[a; b; c; d; e]    <- xs
 |  |  |  |  |
   func
 |  |  |  |  |
 v  v  v  v  v
[g; h; i; j; k]    <- result

*)


(*
  2) Easy map problems. These all look like:

  let func xs =
    let worker x = failwith "TODO" in
  map worker xs

  first, an alias

*)

let map = List.map

(* double, triple: double, triple each element of a list. mulBy: multiply each
element of a list by a value. square: square each element of a list.

Produces a list of results.
 *)
let double xs =
  let worker x = failwith "TODO" in
  map worker xs

let double xs = failwith "TODO"

let double = failwith "TODO"

let triple xs =
  let worker x = failwith "TODO" in
  map worker xs


let mulBy xs v =
  let worker x = failwith "TODO" in
  map worker xs


let square xs =
  let worker x = failwith "TODO" in
  map worker xs

let square xs = failwith "TODO"

(* applyAll : takes a list of functions, and a value, and applies each functions
  to the value. Produces a list of results.
*)

(* applyAll [incr; decr] 10 *)

(* [10; 10] *)

let applyAll xs v =
  let worker x = failwith "TODO"in
  map worker xs

(*
heads, tails: given a list of tuples, take the first (or second) element of each
tuple. Produces a list of results.
*)

(* let test = [(1,2); (3,4)]

heads test = [1;3]
tails test = [2; 4] *)

let heads xs =
  let worker x = failwith "TODO" in
  map worker xs
let tails xs =
  let worker x = failwith "TODO" in
  map worker xs

(*

countChars: given a list of strings, return a list of character counts.
Helpful for this function: String.length.

*)

(* countChars ["foo"; "ab"] = [3; 2] *)

let countChars xs =
  let worker x = failwith "TODO" in
  map worker xs

(*

3): THE DEFINITION OF FOLD_LEFT

The idea behind fold_left is that some functions *need* to be recursive, but
it's easy to make errors with recursion. For general list-processing, fold_left
abstracts over the recursion

let rec recFunc xs = match xs with
  | []  -> ...base case...
  | h:t -> ...recursive case, a function of h and *the result so far*...

for example, sumInts:
let rec sumInts xs = match xs with
  | []  -> 0
  | h:t -> h + (sumInts t)

fold_left abstracts over the pattern matching and recursion and takes as input
the worker function for the recursive case, the base case, and the list to fold over:

fold_left : ('a -> 'b -> 'a) ->  'a       -> list 'b -> 'a
                  ^^             ^^             ^^
            recursive case    base case     input list

graphically, this looks like:
https://upload.wikimedia.org/wikipedia/commons/5/5a/Left-fold-transformation.png

(the "left" in fold_left refers to the fact that the list is processed in a left-associated
manner, i.e. from left-to-right. Don't think too much about it.)


*)
