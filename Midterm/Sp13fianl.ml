(*
	1.
*)
let count f l =
	let newf acc elem = if (f elem) then acc + 1 else acc in
	List.fold_left newf 0 l;;

let stretch l =
	match l with
	|[] -> []
	|h::t -> let f acc elem = acc@[elem;elem] in
				List.fold_left f [] l;;


(*
	2.
*)
exception Mismatch of string;;

type 'a tree =
| Empty
| Node of 'a * 'a tree list;;

let rec tree_zip t1 t2 =
	match (t1,t2) with
	|(Empty,Empty) -> Empty
	|(Node (a1,l1),Node (a2,l2)) ->
		let rec zip l1 l2 =
			match (l1,l2) with
			| ([],[]) -> []
			| (h1::t1, h2::t2) -> (h1,h2)::(zip t1 t2)
			| _ -> raise (Mismatch("structure mismatch"))
		in
		let f (n1,n2) = tree_zip n1 n2
		in
		Node ((a1,a2),List.map f (zip l1 l2))
	|_ -> raise (Mismatch("structure mismatch"));; 