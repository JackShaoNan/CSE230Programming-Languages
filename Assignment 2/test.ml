(*
(b)(art.ml) 20 points
Next, you must fill in an implementation for the function build that generates random expressions. The function is of type build : (int*int -> int)*int -> expr . The function is called with the argument pair (rand,depth) .
The first element rand is a random number generator of type int * int -> int . Each call rand (i,j) returns a random integer between i inclusive and j exclusive. Use this function to randomly select operators when composing subexpressions to build up larger expressions.

The second element depth is a maximum nesting depth. A random expression of depth d built by randomly composing sub-expressions of maximum depth d-1 , and the only expressions of depth 0 are VarX or VarY .

With this in place you can generate random art using the functions

doRandomGray : int * int * int -> unit 
doRandomColor : int * int * int -> unit 
Each function takes as a parameter a triple (depth,seed1,seed2) where depth is the depth of the expression to be generated and seed1,seed2 are two seeds for the random number generator. The functions generate JPEG files called
art_g_1_<depth>_<seed1>_<seed2>.jpg,
art_c_1_<depth>_<seed1>_<seed2>.jpg .
The first is a gray scale image, built by mapping out a single randomly generated expression over the plane, and the second is a color image built using three functions for the intensities of red, green and blue.
Play around with how you generate the expressions, using the tips below. Name your best three color files color1.jpg, color2.jpg, color3.jpg, and save their parameters, i.e. the depth and the seeds in the bodies of c1,c2,c3. Name your best three gray files gray1.jpg, gray2.jpg, gray3.jpg , and save their parameters in the bodies of g1,g2,g3.

Note:
Don't build the datatypes directly -- use the build functions provided in expr.ml. The purpose is to hide the actual implementation, i.e. the datatype, for the expressions from the random art code, thus enabling modular code. We will see more of modules later.
Depths of 8-12 produce interesting pictures, but play around!
Make sure your expressions don't get "cut-off" early with VarX,VarY, as small expressions give simple pictures. In general, play around to bias the generation towards more interesting operators.
(c)(art.ml) 20 points
Finally, add two new operators to the grammar, i.e. to the datatype, by introducing two new datatype constructors, and adding the corresponding cases to exprToString and eval . Write a new function build2 , which behaves exactly like your function build, except which generates expressions using your two new operators. Test these functions using doRandomGray2 and doRandomColor2 which behave exactly like the previous versions, except which use build2 instead of build. The only requirements are that the operators must return values in the range [-1.0,1.0] if their arguments are in that range, and that one of the operators take three arguments, i.e. one of the datatype constructors is of the form:
C of expr * expr * expr
You can include images generated with these new operators when choosing your best images for part (b).


*)

(* CSE 130 PA 2. Autotester *)

#use "misc.ml"
#use "expr.ml" 
#use "art.ml"

let key = "" (* change *)
let prefix130 = "130" (* change *)
let print130 s = print_string (prefix130^">>"^s^"\n")


exception ErrorCode of string

type result = Pass | Fail | ErrorCode of string

let score = ref 0
let max = ref 0
let timeout = 300

exception TimeOutException

let runWTimeout (f,arg,out,time) = 
  try if compare (f arg) out = 0 then Pass else Fail
  with e -> (print130 ("Uncaught Exception: "^(Printexc.to_string e)); ErrorCode "exception") 



exception TestException
let testTest () =
  let testGood x = 1 in
  let testBad x = 0 in 
  let testException x = raise TestException in
  let rec testTimeout x = testTimeout x in
    runWTimeout(testGood,0,1,5) = Pass &&  
    runWTimeout(testBad,0,1,5) = Fail &&  
    runWTimeout(testException,0,1,5) = ErrorCode "exception" && 
    runWTimeout(testTimeout,0,1,5) = ErrorCode "timeout"


let runTest (f,arg,out,points,name) =
  let _ = max := !max + points in
  let outs = 
	match runWTimeout(f,arg,out,timeout) with 
	    Pass -> (score := !score + points; "[pass]")
 	  | Fail -> "[fail]"
	  | ErrorCode e -> "[error: "^e^"]"  in
  name^" "^outs^" ("^(string_of_int points)^")"

(* explode : string -> char list *)
let explode s = 
  let rec _exp i = 
    if i >= String.length s then [] else (s.[i])::(_exp (i+1)) in
  _exp 0

let implode cs = 
  String.concat "" (List.map (String.make 1) cs)

let drop_paren s = 
  implode (List.filter (fun c -> not (List.mem c ['(';' ';')'])) (explode s))

let eq_real p (r1,r2) = 
  (r1 -. r2) < p || (r2 -. r1) < p

let runAllTests () =
    let _ = (score := 0; max := 0) in
    let _ = Sys.command ("rm art_*.jpg"), (), 0, "" in
    let report =
      [runTest (assoc, (-1,"william",[("ranjit",85);("william",23);("moose",44)]), 23, 2, "assoc 1");
       runTest (assoc, (-1,"bob",[("ranjit",85);("william",23);("moose",44);("margaret",99)]), -1, 2, "assoc 2");
       runTest (removeDuplicates,[1;6;2;4;12;2;13;6;9],[1;6;2;4;12;13;9],2,"removeDuplicates 1")]
      @
	(let f x = let xx = x*x*x in (xx,xx<100) in
	let g x = truncate (1e6 *. cos (1e-6 *. float x)) in
	  [runTest (wwhile, (f,2), 512, 2, "wwhile 1");
	   runTest (fixpoint, (g,0), 739085, 2, "fixpoint 1")])
      @
	[ runTest (emitGrayscale, (eval_fn sampleExpr,150,"art_g_sample"),(),5,"eval_fn 1 : manual");
	  runTest (emitGrayscale, (eval_fn sampleExpr2,150,"art_g_sample2"),(),5,"eval_fn 2 : manual");
	  runTest ((fun () -> doRandomGray (g1 ())), (), (),2,"Gray 1 : manual"); 
	  runTest ((fun () -> doRandomGray (g2 ())), (), (),2,"Gray 2 : manual"); 
	  runTest ((fun () -> doRandomGray (g3 ())), (), (),2,"Gray 3 : manual"); 
	  runTest ((fun () -> doRandomColor (c1 ())), (), (),2,"Color 1 : manual"); 
	  runTest ((fun () -> doRandomColor (c2 ())), (), (),2,"Color 2 : manual"); 
	  runTest ((fun () -> doRandomColor (c3 ())), (), (),2,"Color 3 : manual");
	  runTest ((fun () -> doRandomGray2 (g1 ())), (), (),2,"Gray2 1 : manual"); 
	  runTest ((fun () -> doRandomGray2 (g2 ())), (), (),2,"Gray2 2 : manual"); 
	  runTest ((fun () -> doRandomGray2 (g3 ())), (), (),2,"Gray2 3 : manual"); 
	  runTest ((fun () -> doRandomColor2 (c1 ())), (), (),2,"Color2 1 : manual"); 
	  runTest ((fun () -> doRandomColor2 (c2 ())), (), (),2,"Color2 2 : manual"); 
	  runTest ((fun () -> doRandomColor2 (c3 ())), (), (),2,"Color2 3 : manual")]
    in
    let s = Printf.sprintf "Results: Score/Max = %d / %d" !score !max in
    let _ = List.iter print130 (report@([s])) in
    (!score,!max)


let _ = runAllTests ()

let _ = print130 ("Compiled"^key)
    
