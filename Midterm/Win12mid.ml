(*
	1
*)
let length l = 
	let f acc elmt = acc+1 in
	List.fold_left f 0 l;;

let rec split l =
	(* additional let declarations if you need any *)
	let len = (length l) / 2 in
	let base = (0,[],[]) in
	let fold_fn (i,l1,l2) elmt = if i < len then (i+1,l1@[elmt],l2) else (i+1,l1,l2@[elmt]) in
	let (_, l1, l2) = List.fold_left fold_fn base l in
	(l1,l2);;

let rec merge l1 l2 =
	match (l1, l2) with
	| ([], l) -> l
	| (l, []) -> l
	| (h1::t1,h2::t2) -> if h1 < h2 then h1::(merge t1 l2) else h2::(merge l1 t2);;

let rec merge_sort l =
	match l with 
	|[] -> []
	|h::t -> if t = [] then [h] else 
	let (l1,l2) = split l in 
		match (l1,l2) with
		|([],l) -> l
		|(l,[]) -> l
		|(h1::t1,h2::t2) -> 
			match (t1,t2) with
			|([],[]) -> if h1 < h2 then [h1;h2] else [h2;h1]
			|_ -> merge (merge_sort l1) (merge_sort l2);;

let explode s = List.init (String.length s) (String.get s);;
let implode cl = String.concat "" (List.map (String.make 1) cl);;

let replace s =
	let cl = explode s in
	let f a = if a = '-' then ' ' else a in
	implode (List.map f cl);;


let app flist x = 
	let f f1 = f1 x in
	List.map f flist;;





























