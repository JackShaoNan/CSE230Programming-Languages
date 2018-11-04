(*
	1
*)
let rec find d k =
	match d with
	| [] -> raise Not_found
	| (k',v') :: t -> 
	if k' = k then v' 
	else if k < k' then raise Not_found else find t k;;

let rec add d k v =
	match d with
	| [] -> [(k,v)]
	| (k',v') :: t -> 
	if k' = k then (k,v)::t else
	if k' > k then (k,v)::d else (k',v')::(add t k v);;

let keys d =
	let f (k,v) = k in
	List.map f d;; 

let values d =
	let f (k,v) = v in
	List.map f d;;

let key_of_max_val d =
	(* definition of fold_fn *)
	let fold_fn acc elmt = let (k1,v1) = acc in let (k2,v2) = elmt in
	if v2 > v1 then (k2,v2) else acc in
	match d with
	| [] -> raise Not_found
	(* the call to fold should be: fold_left fold_fn base t *)
	| base::t -> let (res,_) = List.fold_left fold_fn base d in res;;
