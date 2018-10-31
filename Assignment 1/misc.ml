(*
Problem #1: Digital Roots and Additive Persistence (misc.ml)
(a) 10 points
Now write an OCaml function sumList : int list -> int that takes an integer list l and returns the sum of the elements of l . Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# sumList [];;
- : int = 0 
# sumList [1;2;3;4];;
- : int = 10
# sumList [1;-2;3;5];;
- : int = 7
# sumList [1;3;5;7;9;11];;
- : int = 36

(b) 10 points
Write an OCaml function digitsOfInt : int -> int list that takes an integer n as an argument and if the integer is positive (i.e. I don't care what you return for the argument 0 or any negative number), returns the list of digits of n in the order in which they appear in n . Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# digitsOfInt 3124;;
- : int list = [3;1;2;4] 
# digitsOfInt 352663;;
- : int list = [3;5;2;6;6;3]

(c) 10+10 points
Consider the process of taking a number, adding its digits, then adding the digits of the number derived from it, etc., until the remaining number has only one digit. The number of additions required to obtain a single digit from a number n is called the additive persistence of n, and the digit obtained is called the digital root of n. For example, the sequence obtained from the starting number 9876 is (9876, 30, 3), so 9876 has an additive persistence of 2 and a digital root of 3. Write two OCaml functions additivePersistence : int -> int and digitalRoot : int -> int that take positive integer arguments n and return respectively the additive persistence and the digital root of n . Once you have implemented the functions, you should get the following behavior at the OCaml prompt:

# additivePersistence 9876;;
- : int = 2
# digitalRoot 9876;;
- : int = 3

Problem #2: Palindromes (misc.ml)
(a) 15 points
Without using any built-in OCaml functions, write an OCaml function listReverse : 'a list -> 'a list that takes a list l as an argument and returns a list of the elements of l in the reversed order. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# listReverse [];;
- : int list = []
# listReverse [1;2;3;4];;
- : int list = [4;3;2;1]
# listReverse ["a";"b";"c";"d"];;
- : string list = ["d";"c";"b";"a"]

(b) 5 points
A palindrome is a word that reads the same from left-to-right and right-to-left. Write an OCaml function palindrome : string -> bool that takes a string w and returns true if the string is a palindrome and false otherwise. Your function should be case sensitie. You may want to use the OCaml function explode . (Hint: You may call your listReverse function from your palindrome function.) Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# palindrome "malayalam";;
- : bool = true
# palindrome "Malayalam";;
- : bool = false
# palindrome "myxomatosis";;
- : bool = false
# palindrome "";;
- : bool = true
*)


(* CSE 130: Programming Assignment 1
 * misc.ml
 * Name : Nan Shao
 * UID : A53272795
 *)

(* sumList : int list -> int 
   
   Basic idea : Use recursion to solve the sum of all elements of l
   This sumList function takes an argument l, which is a list, if l
   is empty, we just return 0; else we return the head value plus the 
   recursion call to the tail list.
*) 

let rec sumList l = (* failwith "to be written" *)
	match l with
	| [] -> 0 (* base case *)
	| hd :: tl -> hd + sumList tl (* recursive rule *)
;;


(* digitsOfInt : int -> int list 
   (see the digits function below for an example of what is expected)
   
   I assume that the input of digitsOfInt is positive numvber.
   This digitsOfInt function takes an argument n, and we aim to return a list including
   all digits in n. with the help of helper function, we can avoid the use of "@" operator.
   The helper function takes two arguments: positive integer num and list l. if the num is small 
   than 10, we just put it into list and return it; if num bigger than 10, we first put (num mod 10)
   in list, and we call recursion function on (num / 10).
 *)

(* helper func: to avoid using "@" *)
let rec helper num l =
	if num < 10 then num :: l (* base case *)
	else helper (num / 10) ((num mod 10) :: l)  (* recursive rule *)
;;

(* we just pass the n and a empty list to helper *)
let rec digitsOfInt n = (* failwith "to be written" *)
	helper n []
(*
	if n = 0 then [] (* base case *)
	else digitsOfInt (n/10) @ (n mod 10 :: []) (* recursive rule *)
*)
;;



(* digits : int -> int list
 * (digits n) is the list of digits of n in the order in which they appear
 * in n
 * e.g. (digits 31243) is [3,1,2,4,3]
 *      (digits (-23422) is [2,3,4,2,2]
 *)
 
let digits n = digitsOfInt (abs n)


(* From http://mathworld.wolfram.com/AdditivePersistence.html
 * Consider the process of taking a number, adding its digits, 
 * then adding the digits of the number derived from it, etc., 
 * until the remaining number has only one digit. 
 * The number of additions required to obtain a single digit from a number n 
 * is called the additive persistence of n, and the digit obtained is called 
 * the digital root of n.
 * For example, the sequence obtained from the starting number 9876 is (9876, 30, 3), so 
 * 9876 has an additive persistence of 2 and a digital root of 3.
 *)


(* ***** PROVIDE COMMENT BLOCKS FOR THE FOLLOWING FUNCTIONS ***** *)

(*
* A helper function to get sum of all digits of n
  This sumOfDigits function help us get each intermidiate result in the process of adding 
  every digits together. It takes n in it and if n < 10, there is only one digit, we just 
  return n; else we return (n mod 10) plus the recursion call on (n / 10).
*)
let rec sumOfDigits n = 
	if n < 10 then n (* base case *)
	else n mod 10 + sumOfDigits (n / 10) (* recursive rule *)
;; 

(* According to the math definition of additive persistence, if n < 10, we just return 0, 
   else we make use of helper function (sumOfDigits) and recursion call to get the result.
*)
let rec additivePersistence n = (* failwith "to be written" *)
	if n < 10 then 0 (* base case *)
	else additivePersistence (sumOfDigits n) + 1 (* recursive rule : use helper function to get the result needed for next step *)
;;

(* According to the math definition of digital root, if n < 10, we just return it,
   else we just recursively add all digits together untill we get only one digit.
*)
let rec digitalRoot n = (* failwith "to be written" *)
	if n < 10 then n (* base case *)
	else digitalRoot (n mod 10 + n / 10) (* recursive rule *)
;;


(* helper func : to avoid using "@" 
   This helper function is to help concatinate two list, first if l1 is empty, we just
   return l2; else we put the head of l1 into the last position and recursively call helper 
   function to the remainder of l1 
*)
let rec helper l1 l2 =
	match l1 with
	| [] -> l2
	| hd :: tl -> helper tl (hd :: l2)
;;

(* To use helper function, we only need to pass list l and a empty list to it. *)
let rec listReverse l = (* failwith "to be written" *)
	helper l []
(*
	match l with 
	| [] -> [] (* base case *)
	| hd :: tl -> listReverse tl @ (hd::[]) (* recursive rule *)
*)
;;

(* explode : string -> char list 
 * (explode s) is the list of characters in the string s in the order in 
 *   which they appear
 * e.g.  (explode "Hello") is ['H';'e';'l';'l';'o']
 *)
let explode s = 
  let rec _exp i = 
    if i >= String.length s then [] else (s.[i])::(_exp (i+1)) in
  _exp 0
;;

(* It is really obvious that we just check if the reverse of list of input string and 
   the list of input string itself are equal.
*)
let palindrome w = (* failwith "to be written" *)
	if listReverse (explode w) = explode w then true 
	else false
;;

(************** Add Testing Code Here ***************)
