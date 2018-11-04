(*
	1
*)
let length l =
	let f acc elem = acc + 1 in
	List.fold_left f 0 l;;

let remove l x =
	let f acc elem = if elem = x then acc else acc@[elem] in
	List.fold_left f [] l;;

(*
	2
*)
let rec ith l i d =
	match l with
	| [] -> d
	| h::t -> if i = 0 then h else ith t (i-1) d;;

let rec update l i n =
	match l with
	| [] -> []
	| h::t -> if i = 0 then n::t else h::(update t (i-1) n);;

let rec update2 l i n d =
	match l with
	| [] -> if i<0 then [] else if i=0 then [n] else update2 [d] i n d
	| h::t -> if i = 0 then n::t else h::(update2 t (i-1) n d);;


(*
	3
*)
let categorize f l =
	let base = [] in
	let fold_fn acc elmt =
		update2 acc (f elmt) ((ith acc (f elmt) [])@[elmt]) []
	in List.fold_left fold_fn base l;;


























