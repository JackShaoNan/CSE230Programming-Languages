(*
Problem #2: Random Art
At the end of this assignment, you should be able to produce pictures of the kind shown below. To do so, we shall devise a grammar for a certain class of expressions, design an OCaml datatype whose values correspond to such expressions, write code to evaluate the expressions, and then write a function that randomly generates such expressions and plots them thus producing random psychedelic art. 

c1  c2  c3
g1  g2  g3
(a)(expr.ml) 15+15 points
The expressions described by the grammar:
e ::= x | y | sin (pi*e) | cos (pi*e) | ((e + e)/2) | e * e | (e<e ? e : e)
where pi stands for the constant 3.142, are functions over the variables x,y, which are guaranteed to produce a value in the range [-1,1] when x and y are in that range. We can represent expressions of this grammar in ML using values of the following datatype:
type expr = 
      VarX 
    | VarY 
    | Sine of expr 
    | Cosine of expr 
    | Average of expr * expr 
    | Times of expr * expr 
    | Thresh of expr * expr * expr * expr 
First, write a function exprToString : expr -> string to enable the printing of expressions. Once you have implemented the function, you should get the following behavior at the OCaml prompt:
# exprToString (Thresh(VarX,VarY,VarX,(Times(Sine(VarX),Cosine(Average(VarX,VarY))))));;
- : string = "(x<y?x:sin(pi*x)*cos(pi*((x+y)/2)))" 

Next, write the function eval : expr * float * float -> float that takes an triple (e,x,y) and evaluates the expression e at the point x,y . You should use Ocaml Math library, in particular, sin, cos to build your evaluator. Recall that Sine(VarX) corresponds to the expression sin(pi*x). Once you have implemented the function, you should get the following behavior at the OCaml prompt:
# eval (Sine(Average(VarX,VarY)),0.5,-0.5);;
- :float = 0.0 
# eval (Sine(Average(VarX,VarY)),0.3,0.3);;
- = 0.809016994375 : float 
# eval (sampleExpr,0.5,0.2);;
- : float = 0.118612572815 

At the OCaml prompt, enter:
# #use "art.ml";; 
emitGrayscale (eval_fn sampleExpr, 150, "sample") ;;
to generate the grayscale image sample.jpg in your working directory. To receive full credit, this image must look like the leftmost grayscale image displayed above. Note that this requires your implementations of eval to work correctly. A message Uncaught exception ... is an indication that your eval is returning a value outside the range [-1.0,1.0].

*)


(*
 * expr.ml
 * cse130
 * based on code by Chris Stone
 *)

(* Please do not modify the names or types of any of the following
 * type constructors, or predefined functions, unless EXPLICITLY
 * asked to. You will loose points if you do.
 *)


(* REMEMBER TO DOCUMENT ALL FUNCTIONS THAT YOU WRITE OR COMPLETE *)

(* add two more operations: tan, subtract *)
type expr = 
    VarX
  | VarY
  | Sine     of expr
  | Cosine   of expr
  | Average  of expr * expr
  | Times    of expr * expr
  | Thresh   of expr * expr * expr * expr
  | Tan      of expr
  | Subtract of expr * expr;;  

(*
  exprToString: expr -> string
  recursively parse the expression
*)

let rec exprToString e = 
  match e with
  (* base case *)
  | VarX -> "x"
  | VarY -> "y"
  (* recursive rule *)
  | Sine x -> "sin(pi*" ^ (exprToString x) ^ ")"
  | Cosine x -> "cos(pi*" ^ (exprToString x) ^ ")"
  | Average (x, y) -> "((" ^ (exprToString x) ^ "+" ^ (exprToString y) ^ ")/2)"
  | Times (x, y) -> (exprToString x) ^ "*" ^ (exprToString y)
  | Thresh (x, y, z, j) -> "(" ^ (exprToString x) ^ "<" ^ (exprToString y) ^ "?" ^ 
                           (exprToString z) ^ ":" ^ (exprToString j) ^ ")"
  | Tan x -> "tan(pi*" ^ (exprToString x) ^ ")"
  | Subtract (x, y) -> "(" ^ (exprToString x) ^ "-" ^ (exprToString y) ^ ")";;


(* build functions:
     Use these helper functions to generate elements of the expr
     datatype rather than using the constructors directly.  This
     provides a little more modularity in the design of your program *)

let buildX()                       = VarX;;
let buildY()                       = VarY;;
let buildSine(e)                   = Sine(e);;
let buildCosine(e)                 = Cosine(e);;
let buildAverage(e1,e2)            = Average(e1,e2);;
let buildTimes(e1,e2)              = Times(e1,e2);;
let buildThresh(a,b,a_less,b_less) = Thresh(a,b,a_less,b_less);;
let buildTan(e)                    = Tan(e);;
let buildSubtract(e1,e2)           = Subtract(e1,e2);;


let pi = 4.0 *. atan 1.0;;

(* recursively evaluate expression *)
let rec eval (e,x,y) = 
  match e with
  (* base case *)
  | VarX -> x
  | VarY -> y
  (* recursive rule *)
  | Sine a -> sin(pi *. eval (a, x, y))
  | Cosine a -> cos(pi *. eval (a, x, y))
  | Average (a, b) -> (eval(a, x, y) +. eval(b, x, y)) /. 2.0
  | Times (a, b) -> eval(a, x, y) *. eval(b, x, y)
  | Thresh (a, b, c, d) -> if eval(a, x, y) < eval(b, x, y) then
                            eval(c, x, y) else eval(d, x, y)
  | Tan a -> tan(pi *. eval(a, x, y))
  | Subtract (a, b) -> (eval(a, x, y) -. eval(b, x, y));;

(* (eval_fn e (x,y)) evaluates the expression e at the point (x,y) and then
 * verifies that the result is between -1 and 1.  If it is, the result is returned.  
 * Otherwise, an exception is raised.
 *)
let eval_fn e (x,y) = 
  let rv = eval (e,x,y) in
  assert (-1.0 <= rv && rv <= 1.0);
  rv

let sampleExpr =
      buildCosine(buildSine(buildTimes(buildCosine(buildAverage(buildCosine(
      buildX()),buildTimes(buildCosine (buildCosine (buildAverage
      (buildTimes (buildY(),buildY()),buildCosine (buildX())))),
      buildCosine (buildTimes (buildSine (buildCosine
      (buildY())),buildAverage (buildSine (buildX()), buildTimes
      (buildX(),buildX()))))))),buildY())))

let sampleExpr2 =
  buildThresh(buildX(),buildY(),buildSine(buildX()),buildCosine(buildY()))


(************** Add Testing Code Here ***************)
