
(*
	1.
*)
let sum_matrix m =
	let fold_fun acc elem = 
		acc + (List.fold_left (+) 0 elem)
	in 
	List.fold_left fold_fun 0 m;;














let m = [[ 1; 2; 3];[ 4; 5; 6]];;









let rec sum_matrix m =
	let base = 0 in
	let f acc elmt = acc + (List.fold_left (+) 0 elmt) in
	List.fold_left f base m;;