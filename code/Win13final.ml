
(*
	1.
*)
let sum_matrix m =
	let fold_fun acc elem = 
		acc + (List.fold_left (+) 0 elem)
	in 
	List.fold_left fold_fun 0 m;;