(*
	1
*)
let count l x =
	let f acc elem = 
		if elem = x then acc + 1 else acc
	in
	List.fold_left f 0 l;;

let make_palyndrome l =
	match l with 
	|[] -> []
	|h::t -> let f acc elem = elem::acc in (List.fold_left f [] l)@l;;


(*
	2.
*)
let fold_2 f b l = (*？？？？？？？？？？？？？？？？*)
	let base = (0,b) in
	let fold_fn (idx,acc) elem = (idx+1,f acc elem idx) in
	let (_,res) = List.fold_left fold_fn base l in res;;

let rec ith l i d =
	let f acc elmt idx = if idx=i then elmt else acc in
	fold_2 f d l;; 

	



(*
	3.
*)
type 'a fun_tree =
| Leaf of ('a -> 'a)
| Node of ('a fun_tree) * ('a fun_tree);;

let rec apply_all t x =
	match t with
	|Leaf f1 -> f1 x
	|Node (t1,t2) -> apply_all t2 (apply_all t1 x);;


let rec compose t1 t2 =
	match (t1,t2) with
	|(Leaf l1,Leaf l2) -> Leaf (fun x -> l1 (l2 x))
	|(Node (l1,l2),Node (l3,l4)) -> Node ((compose l1 l3),(compose l2 l4));;


















