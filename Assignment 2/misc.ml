(*
Problem #1: Tail Recursion (misc.ml)
(a) 15 points
Without using any built-in OCaml functions, write an OCaml function assoc : int * string * (string * int) list -> int (or more generally, 'a * 'b * ('b * 'a) list -> 'a) that takes a triple (d,k,l) where l is a list of key-value pairs [(k1,v1);(k2,v2);...] and finds the first ki that equals k. If such a ki is found, then vi is returned. Otherwise, the default value d is returned.

Your function should be tail recursive. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# assoc (-1,"jeff",[("sorin",85);("jeff",23);("moose",44)]);;
- : int = 23 
# assoc (-1,"bob",[("sorin",85);("jeff",23);("moose",44);("margaret",99)]);;
- : int = -1 

(b) 15 points
Without using any built-in OCaml functions, modify the skeleton for removeDuplicates to obtain a function of type int list -> int list (or more generally, 'a list -> 'a list) that takes a list l and returns the list of elements of l with the duplicates, i.e. second, third, etc. occurrences, removed, and where the remaining elements appear in the same order as in l .

For this function only, you may use the library functions List.rev and List.mem. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# removeDuplicates [1;6;2;4;12;2;13;6;9];;
- : int list = [1;6;2;4;12;13;9] 

(c) 15 points
Without using any built-in OCaml functions, or the while or for construct, write an OCaml function:
wwhile : (int -> int * bool) * int -> int (or more generally, ('a -> 'a * bool) * 'a -> 'a ) that takes as input a pair (f,b) and calls the function f on input b to get a pair (b',c'). wwhile should continue calling f on b' to update the pair as long as c' is true. Once f returns a c' that is false, wwhile should return b'.

Your function should be tail recursive. Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# let f x = let xx = x*x*x in (xx,xx<100);; 
val f : int -> int * bool = fn 
# wwhile (f,2);; 
- : int = 512 

(d) 10 points
Without using any built-in OCaml functions, modify the skeleton for fixpoint to obtain a function of type (int -> int) * int -> int (or more generally, ('a -> 'a) * 'a -> 'a) which repeatedly updates b with f(b) until b=f(b) and then returns b.

Once you have implemented the function, you should get the following behavior at the OCaml prompt:

# let g x = truncate (1e6 *. cos (1e-6 *. float x));; 
val f : int -> int = fn 
# fixpoint (g,0);; 
- : int = 739085 
*)


(* CSE 130: Programming Assignment 2
 * misc.ml
 *)

(* ***** DOCUMENT ALL FUNCTIONS YOU WRITE OR COMPLETE ***** *)

(*
  assoc: 'a * 'b * ('b * 'a) list -> 'a

  basic idea: check the k, which is to be searched, in l one by one,
  if we find it just return its value, or we recursively search k in 
  remaining list, until we come to the end(the [] case), in that case 
  we just return the default d. 
*)
let rec assoc (d,k,l) = (* failwith "to be written" *)
  match l with
  | [] -> d   (* base case *)
  | h::t -> let key, value = h in   (* recursive rule *)
              if key = k then value else assoc (d, k, t);;


(* fill in the code wherever it says : failwith "to be written" *)
(* 
  removeDuplicates: int list -> int list

  basic idea: use List.mem to check whether the current element is 
  in the seen list(list_so_far), if it is, just skip it; if not, 
  we add it into seen. In both case we recursively process the remainder.
 *)
let removeDuplicates l = 
  let rec helper (seen,rest) = 
      match rest with 
      | [] -> seen
      | h::t ->   (* base case *)
        let seen' = if (List.mem h seen) then seen else (h :: seen) in  (* recursive rule *)
        let rest' = t in 
	  helper (seen',rest') 
  in
      List.rev (helper ([],l));;  (* cuz we insert the unique element into the head of the seen, we should reverse the result *)


(* Small hint: see how ffor is implemented below *)
(*
  wwhile: ('a -> 'a * bool) * 'a -> 'a 
  basic idea: it is very obvious to just follow the description
*)
let rec wwhile (f,b) = 
  let (tmp, isTrue) = f b in
  if isTrue then wwhile (f, tmp)  (* recursive rule *)
  else tmp;;  (* base case *)

(* fill in the code wherever it says : failwith "to be written" *)
let fixpoint (f,b) = wwhile ((fun b -> if f b = b then (b, false) else (f b, true)),b);;


(* ffor: int * int * (int -> unit) -> unit
   Applies the function f to all the integers between low and high
   inclusive; the results get thrown away.
 *)

let rec ffor (low,high,f) = 
  if low>high 
  then () 
  else let _ = f low in ffor (low+1,high,f)
      
(************** Add Testing Code Here ***************)
