(*
	1
*)
type 'a maybe =
| None
| Some of 'a;;

let first f l =
	let base = None in
	let fold_fn acc elmt = 
		match acc with
		| None -> if f elmt then Some elmt else None
		| Some v -> Some v
	in List.fold_left fold_fn base l;;


(*
	2
*)
let rec zip l1 l2 =
	match (l1,l2) with
	|(h1::t1,h2::t2) -> (h1,h2)::(zip t1 t2)
	|_ -> [];;

let map2 f l1 l2 =
	let fold_fn acc elmt = let (a,b) = elmt in acc@[f a b] in
	List.fold_left fold_fn [] (zip l1 l2);;

let map3 f l1 l2 l3 =
	let f1 a b = (a,b) in
	let fold_fn acc elmt = let (a,(b,c)) = elmt in acc@[f a b c] in
	List.fold_left fold_fn [] (map2 f1 l1 (map2 f1 l2 l3));;

(*
	3
*)
let rec unzip l =
	match l with
	|[] -> ([],[])
	|h::t -> let (a,b) = h in let (l1,l2) = unzip t in (a::l1,b::l2);; 


 












