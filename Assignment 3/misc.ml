(*
Problem #1: Warm-Up (misc.ml)
(a) 10 points
Fill in the skeleton given for sqsum , which uses List.fold_left to get an OCaml function sqsum : int list -> int that takes a list of integers [x1;...;xn]) and returns the integer: x1^2 + ... + xn^2 . Your task is to fill in the appropriate values for (1) the folding function f and (2) the base case base. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# sqsum [];;
- : int = 0 
# sqsum [1;2;3;4] ;;
- : int = 30 
# sqsum [-1;-2;-3;-4] ;;
- : int = 30 

(b) 20 points
Fill in the skeleton given for pipe, which uses List.fold_left to get an OCaml function pipe : ('a -> 'a) list -> ('a -> 'a) . The function pipe takes a list of functions [f1;...;fn]) and returns a function f such that for any x, the application f x returns the result fn(...(f2(f1 x))). Again, your task is to fill in the appropriate values for (1) the folding function f and (2) the base case base. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# pipe [] 3;;
- : int = 3 
# pipe [(fun x-> 2*x);(fun x -> x + 3)] 3 ;;
- : int = 9 
# pipe [(fun x -> x + 3);(fun x-> 2*x)] 3;;
- : int = 12

(c) 15 points
Fill in the skeleton given for sepConcat, which uses List.fold_left to get an OCaml function sepConcat : string -> string list -> -> string. The function sepConcat is a curried function which takes as input a string sep to be used as a separator, and a list of strings [s1;...;sn]. If there are 0 strings in the list, then sepConcat should return "". If there is 1 string in the list, then sepConcat should return s1. Otherwise, sepConcat should return the concatination s1 sep s2 sep s3 ... sep sn. You should only modify the parts of the skeleton consisting of failwith "to be implemented". You will need to define the function f, and give values for base and l. Once you have filled in these parts, you should get the following behavior at the OCaml prompt:

# sepConcat ", " ["foo";"bar";"baz"];;
- : string = "foo, bar, baz"
# sepConcat "---" [];;
- : string = ""
# sepConcat "" ["a";"b";"c";"d";"e"];;
- : string = "abcde"
# sepConcat "X" ["hello"];;
- : string = "hello"

(d) 5 points
Implement the curried OCaml function stringOfList : ('a -> string) -> 'a list -> string. The first input is a function f: 'a -> string which will be called by stringOfList to convert each element of the list to a string. The second input is a list l: 'a list, which we will think of as having the elemtns l1, l2, ..., ln. Your stringOfList function should return a string representation of the list l as a concatenation of the following: "[" (f l1) "; " (f l2) "; " (f l3) "; " ... "; " (f ln) "]". This function can be implemented on one line without using any recursion by calling List.map and sepConcat with appropriate inputes. Once you have completed this function, you should get the following behavior at the OCaml prompt:

# stringOfList string_of_int [1;2;3;4;5;6];;
- : string = "[1; 2; 3; 4; 5; 6]"
# stringOfList (fun x -> x) ["foo"];;
- : string = "[foo]"
# stringOfList (stringOfList string_of_int) [[1;2;3];[4;5];[6];[]];;
- : string = "[[1; 2; 3]; [4; 5]; [6]; []]"

Problem #2: Big Numbers (misc.ml)
As you may have noticed, the OCaml type int only contains values upto a certain size. For example, entering 9999999999 results in the message int constant too large . You will now implement functions to manipulate large numbers represented as lists of integers.
(a) 5 + 5 + 5 points
Write a curried function clone : 'a -> int -> 'a list which first takes as input x and then takes as input an integer n. The result is a list of length n, where each element is x. If n is 0 or negative, clone should return the empty list. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# clone 3 5;;
- : int list = [3; 3; 3; 3; 3] 
# clone "foo" 2;;
- : string list = ["foo"; "foo"]
# clone clone (-3);;
- : ('_a -> int -> '_a list) list = []

Use the function clone to write a curried function padZero : int list -> int list -> int list * int list which takes two lists: [x1,...,xn] [y1,...,ym] and adds zeros in front to make the lists equal. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# padZero [9;9] [1;0;0;2];;
- : int list * int list = ([0;0;9;9],[1;0;0;2]) 
# padZero [1;0;0;2] [9;9];;
- : int list * int list = ([1;0;0;2],[0;0;9;9]) 

Now write a function removeZero : int list -> int list , that takes a list and removes a prefix of trailing zeros. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# removeZero [0;0;0;1;0;0;2];;
- : int list = [1;0;0;2] 
# removeZero [9;9];;
- : int list = [9;9] 
# removeZero [0;0;0;0];;
- : int list = [] 

(b) 15 points
Suppose we use the list [d1;d2;d3;...;dn], where each di is in the range [0..9], to represent the (positive) integer d1d2d3...dn. For example, the list [9;9;9;9;9;9;9;9;9;9] represents the integer 9999999999. Fill out the implementation for bigAdd : int list -> int list -> int list , so that it takes two integer lists, where each integer is in the range [0..9] and returns the list corresponding to the addition of the two big integers. Again, you have to fill in the implementation to supply the appropriate values to f, base, args . Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# bigAdd [9;9] [1;0;0;2];;
- : int list = [1;1;0;1] 
# bigAdd [9;9;9;9] [9;9;9];;
- : int list = [1;0;9;9;8] 

(c) 10 + 10 points
Next you will write functions to multiply two big integers. First write a function mulByDigit : int -> int list -> int list which takes an integer digit and a big integer, and returns the big integer list which is the result of multiplying the big integer with the digit. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# mulByDigit 9 [9;9;9;9];;
- : int list = [8;9;9;9;1] 

Now, using the function mulByDigit, fill in the implementation of bigMul : int list -> int list -> int list . Again, you have to fill in implementations for f , base , args only. Once you are done, you should get the following behavior at the prompt:
# bigMul [9;9;9;9] [9;9;9;9];;
- : int list = [9;9;9;8;0;0;0;1] 
# bigMul [9;9;9;9;9] [9;9;9;9;9];;
- : int list = [9;9;9;9;8;0;0;0;0;1] 
*)

(* CSE 130: Programming Assignment 3
 * misc.ml
 *)

(* For this assignment, you may use the following library functions:

   List.map
   List.fold_left
   List.fold_right
   List.split
   List.combine
   List.length
   List.append
   List.rev

   See http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html for
   documentation.
*)



(* Do not change the skeleton code! The point of this assignment is to figure
 * out how the functions can be written this way (using fold). You may only
 * replace the   failwith "to be implemented"   part. *)



(*****************************************************************)
(******************* 1. Warm Up   ********************************)
(*****************************************************************)

(* 
  sqsum : int list -> int
  
  f helps us add the result till now "a" to the current element x^2
  so we should initialize the base to 0
 *)
let sqsum xs = 
  let f a x = a + x * x in
  let base = 0 in
    List.fold_left f base xs


(*
  pipe : ('a -> 'a) list -> ('a -> 'a)

  f takes two parameters, a and x, both are functions,
  a just return what it takes in, x takes in the return value of a,
  x returns a function that can be first parameter in f
*)
let pipe fs = 
  let f a x = fun xx -> x (a xx) in
  let base = fun x -> x in
    List.fold_left f base fs

(*
  sepConcat : string -> string list -> -> string

  it's obvious that we just concact the string_so_far with the next
  element in the remaining list
*)
let rec sepConcat sep sl = match sl with 
  | [] -> ""
  | h :: t -> 
      let f a x = a ^ sep ^ x in
      let base = h in
      let l = t in
        List.fold_left f base l;;

(*
  stringOfList : ('a -> string) -> 'a list -> string

  we can just do it by making use of the List.map and sepConcat
*)
let stringOfList f l = 
  "[" ^ sepConcat "; " (List.map f l) ^"]";;

(*****************************************************************)
(******************* 2. Big Numbers ******************************)
(*****************************************************************)

(*
  clone : 'a -> int -> 'a list

  if n <= 0, we just return empty list;
  else we recursively build list with n x;
*)
let rec clone x n = 
  if n <= 0 then [] 
  else
    x :: clone x (n-1);; 

(*
  padZero : int list -> int list -> int list * int list

  I check the length of both l1 and l2 first, if equal, just return;
  if different, we use clone to add zeros to the short list and return
*)
let rec padZero l1 l2 = 
  let len1 = List.length l1 in
  let len2 = List.length l2 in
  if len1 = len2 then (l1,l2)
  else
    if len1 < len2 
    then (List.append (clone 0 (len2 - len1)) l1, l2)
    else (l1, List.append (clone 0 (len1 - len2)) l2);;

(*
  removeZero : int list -> int list

  if empty, just return; else recursively remove the prefix of zeros
*)
let rec removeZero l = 
  match l with
  | [] -> []
  | h :: t ->
    if h = 0 then removeZero t
    else h :: t;;

(*
  bigAdd : int list -> int list -> int list 

  we add two two list(number) from end to start.
  first we make two list the same size by adding zeros in the head,
  then we add one more zero in head for potential carry number, then
  reverse the lists and combine them into pairs(args).
  second we initialize the base to (0,[]), which means the initial carry
  number is 0, and the result_so_far is [].
  finally we add numbers in the first pair(the last digits in both number),
  get the carry, and add the sum to the head of result_so_far. Repeat this 
  process will get the final result.
*)
let bigAdd l1 l2 = 
  let add (l1, l2) = 
    let f a x = 
      let (carry,r) = a in
      let (x1,x2) = x in
      let sum = x1 + x2 + carry in
      (sum/10,sum mod 10 :: r) in 
    let base = (0,[]) in
    let args = 
      let (list1,list2) = padZero l1 l2 in 
      List.combine(List.rev (0::list1)) (List.rev (0::list2)) in
    let (_, res) = List.fold_left f base args in
      res
  in 
    removeZero (add (padZero l1 l2));;

(*
  mulByDigit : int -> int list -> int list

  we assume that the input are all positve numbers.
  first we add a zero to l for carry and reverse the l,
  then multiply i to each digit and add to result_so_far.
  finally remove the zero in the head of result.
*)
let rec mulByDigit i l = 
  if i = 0 then [0]
  else
    let f a b = 
      let (carry,r) = a in
      let mul = i * b + carry in 
      (mul/10,mul mod 10 :: r) in
    let base = (0,[]) in
    let args = List.rev (0::l) in
    let (_,res) = List.fold_left f base args in
    removeZero res;;

(*
  bigMul : int list -> int list -> int list

  we just use mulByDigit to multiply each element in l2 to l1 and append 0(s)
  to the end of each sub-result, and add all sub-results together.
*)
let bigMul l1 l2 = 
  let f a x = 
    let (flag,r) = a in
    let list = mulByDigit x l1 in
    (flag+1,bigAdd (List.append list (clone 0 flag)) r)  
    in
  let base = (0,[]) in
  let args = List.rev l2 in
  let (_, res) = List.fold_left f base args in
    res
