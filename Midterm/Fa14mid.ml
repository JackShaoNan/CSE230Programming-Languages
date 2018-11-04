(*
	1.1
*)
type expr =
| Const of int
| Var of string
| Op of string * expr * expr;;

rename_var : expr -> string -> string -> expr

let rec rename_var e n1 n2 =
	match e with
	|Const c -> Const c
	|Var x -> Var (if x = n1 then n2 else x)
	|Op (s,e1,e2) -> Op(s,(rename_var e1 n1 n2),(rename_var e2 n1 n2));;

(*
	1.2
*)
let to_str e =
	let rec str_helper e top_level =
		match e with
		|Const c -> string_of_int c
		|Var x -> x
		|Op (s,e1,e2) -> 
			if top_level 
			then
				(str_helper e1 false)^s^(str_helper e2 false)
			else
				"("^(str_helper e1 false)^s^(str_helper e2 false)^")"
	in
	str_helper e true;;

(*
	2.
*)
let even x = x mod 2 = 0;;

let average_if f l =
	let folding_fn (sum,num) x =
		if f x then (sum+x,num+1) else (sum,num) 
	in
	let base = (0,0) 
	in
	let (a,b) = List.fold_left folding_fn base l in
	if b = 0 then 0 else a/b;;


(*
	3.
*)
let length_2 l =
	List.fold_left (+) 0 (List.map List.length l);;
let length_3 l =
	List.fold_left (+) 0 (List.map length_2 l);;
(*
	4
*)
let f1 = List.map (fun x->2*x);;
f1 [1;2;3;4];;
(* [2,4,6,8] *)
let f2 = List.fold_left (fun x y -> (y+2)::x) [];;
f2 [3;5;7;9];;
(* [11,9,7,5] *)
let f3 = List.fold_left (fun x y -> x@[3*y]) [];;
f3 [1;3;6];;
(* [3,9,18] *)
let f = List.fold_left (fun x y -> y x);;
f 1 [(+) 1; (-) 2];;
(* 0 *)
f "abc" [(^) "zzz"; (^) "yyy"];;
(* "yyyzzzabc" *)
f [1;2;3] [f1;f2;f3];;
(* [2,4,6] -> [8,6,4] -> [24,18,12] *)










