let rec foldl = 
 fun f -> fun acc -> fun next -> if null next then acc else foldl f (f acc (hd next)) (tl next) in
  foldl
