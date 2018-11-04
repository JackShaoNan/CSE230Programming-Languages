(*
	1.a
# insert [] 10;;
- : int list = [10]
# insert [1;2;3;4] 3;;
- : int list = [1; 2; 3; 3; 4]
# insert [10;15;20;30] 40;;
- : int list = [10; 15; 20; 30; 40]
# insert [10;15;20;30] 5;;
- : int list = [5; 10; 15; 20; 30]
*)
let rec insert l i =
	match l with
	|[] -> [i]
	|h::t -> if i < h then i::l else h::(insert t i);;

let insertion_sort =
	List.fold_left insert [];;

(*
	2.
*)
type expr =
| Var of string
| Const of int
| Plus of expr * expr;;

let rec simpl e =
	match e with
	|Plus (e1,e2) -> e
	|_ -> e;;

let e11 = simpl e1 in
		let e22 = simpl e2 in
		match (e11,e22) with
		|(Const a, Const b) -> Const (a+b)
		|(_,_) -> Plus (e11, e22)










