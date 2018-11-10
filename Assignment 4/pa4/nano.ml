exception MLFailure of string

type binop = 
  Plus 
| Minus 
| Mul 
| Div 
| Eq 
| Ne 
| Lt 
| Le 
| And 
| Or          
| Cons

type expr =   
  Const of int 
| True   
| False      
| NilExpr
| Var of string    
| Bin of expr * binop * expr 
| If  of expr * expr * expr
| Let of string * expr * expr 
| App of expr * expr 
| Fun of string * expr    
| Letrec of string * expr * expr
	
type value =  
  Int of int		
| Bool of bool          
| Closure of env * string option * string * expr 
| Nil                    
| Pair of value * value     
| NativeFunc of string

and env = (string * value) list

let binopToString op = 
  match op with
      Plus -> "+" 
    | Minus -> "-" 
    | Mul -> "*" 
    | Div -> "/"
    | Eq -> "="
    | Ne -> "!="
    | Lt -> "<"
    | Le -> "<="
    | And -> "&&"
    | Or -> "||"
    | Cons -> "::"

let rec valueToString v = 
  match v with 
    Int i -> 
      Printf.sprintf "%d" i
  | Bool b -> 
      Printf.sprintf "%b" b
  | Closure (evn,fo,x,e) -> 
      let fs = match fo with None -> "Anon" | Some fs -> fs in
      Printf.sprintf "{%s,%s,%s,%s}" (envToString evn) fs x (exprToString e)
  | Pair (v1,v2) -> 
      Printf.sprintf "(%s::%s)" (valueToString v1) (valueToString v2) 
  | Nil -> 
      "[]"
  | NativeFunc s ->
      Printf.sprintf "Native %s" s

and envToString evn =
  let xs = List.map (fun (x,v) -> Printf.sprintf "%s:%s" x (valueToString v)) evn in
  "["^(String.concat ";" xs)^"]"

and exprToString e =
  match e with
      Const i ->
        Printf.sprintf "%d" i
    | True -> 
        "true" 
    | False -> 
        "false"
    | NilExpr -> 
        "[]"
    | Var x -> 
        x
    | Bin (e1,op,e2) -> 
        Printf.sprintf "%s %s %s" 
        (exprToString e1) (binopToString op) (exprToString e2)
    | If (e1,e2,e3) -> 
        Printf.sprintf "if %s then %s else %s" 
        (exprToString e1) (exprToString e2) (exprToString e3)
    | Let (x,e1,e2) -> 
        Printf.sprintf "let %s = %s in \n %s" 
        x (exprToString e1) (exprToString e2) 
    | App (e1,e2) -> 
        Printf.sprintf "(%s %s)" (exprToString e1) (exprToString e2)
    | Fun (x,e) -> 
        Printf.sprintf "fun %s -> %s" x (exprToString e) 
    | Letrec (x,e1,e2) -> 
        Printf.sprintf "let rec %s = %s in \n %s" 
        x (exprToString e1) (exprToString e2) 

(*********************** Some helpers you might need ***********************)

let rec fold f base args = 
  match args with [] -> base
    | h::t -> fold f (f(base,h)) t

let listAssoc (k,l) = 
  fold (fun (r,(t,v)) -> if r = None && k=t then Some v else r) None l

(*********************** Your code starts here ****************************)

(*
function lookup: string * env -> value that finds the most recent binding for a variable 
(i.e. the first from the left) in the list representing the environment
*)


let lookup (x,evn) = (* failwith "to be written" *)
  match listAssoc(x,evn) with
  | Some x -> x
  | None ->
    if x = "map" then
    Closure([],Some "map","f",Fun("l",If(App(Var "null",Var "l"),NilExpr,
                        Let("h",App(Var "hd",Var "l"),Let("t",App(Var "tl",Var "l"),
                        Bin(App(Var "f",Var "h"),Cons,App(App(Var "map", Var "f"),Var "t")))))))
    else if x = "foldl" then
    Closure([],Some "foldl","f",
    Fun ("acc",
     Fun ("next",
      If (App (Var "null", Var "next"), Var "acc",
       App
        (App (App (Var "foldl", Var "f"),
          App (App (Var "f", Var "acc"), App (Var "hd", Var "next"))),
        App (Var "tl", Var "next"))))))
    else raise (MLFailure ("variable not bound: " ^ x)) (* we didn't find it *)


let rec eval (evn,e) = (* failwith "to be written" *)
  match e with
  |Const x -> Int x
  |True -> Bool true
  |False -> Bool false
  |NilExpr -> Nil
  |Var x -> if x = "hd" || x = "tl" || x = "null" then NativeFunc x else lookup(x,evn)
  |Bin (e1, bi, e2) ->
    let a = eval(evn,e1) in
    let b = eval(evn,e2) in
      begin match (a,bi,b) with
        | Int a, Plus, Int b -> Int (a + b)
        | Int a, Minus, Int b -> Int (a - b)
        | Int a, Mul, Int b -> Int (a * b)
        | Int a, Div, Int b -> Int (a / b)
        | Int a, Eq, Int b -> Bool (a = b)
        | Int a, Ne, Int b -> Bool (a <> b)
        | Int a, Lt, Int b -> Bool (a < b)
        | Int a, Le, Int b -> Bool (a <= b)
        | Bool a, Eq, Bool b -> Bool (a = b)
        | Bool a, Ne, Bool b -> Bool (a <> b)
        | Bool a, And, Bool b -> Bool (a && b)
        | Bool a, Or, Bool b -> Bool (a || b)
        | Int a, Cons, Nil -> Pair (Int a,Nil) 
        | Int a, Cons, Pair(x,y) -> Pair (Int a, Pair(x,y))
        | _ -> raise (MLFailure ("Invalid operation"))
      end
  |If (p,t,f) ->
    let pResult = eval(evn,p) in
      begin match pResult with
        |Bool true-> eval(evn,t)
        |Bool false -> eval(evn,f)
        |_ -> raise (MLFailure ("Invalid if condition"))
      end
  |Let (b,e1,e2) -> 
    let newEvn = (b,eval(evn,e1))::evn in eval(newEvn,e2)
  |Letrec (b,e1,e2) -> 
    let v = eval(evn,e1) in
    let evn1 = (
      match v with
      |Closure(env,None,x,e) -> Closure(env,Some b,x,e)
      |_ -> v
    ) in
    let newEvn = (b,evn1)::evn in eval(newEvn,e2)
  |App (e1,e2) -> (
    let listfun = eval (evn,e1) in
    if listfun = NativeFunc "null" then 
      let testnull (evn,e) = 
        let res = eval (evn,e2) in 
        match res with
        |Nil -> Bool true
        |Pair(Int a,Nil) -> Bool false
        |Pair(Int a,Pair(x,y)) -> Bool false
        |_ -> raise (MLFailure ("Non-list")) 
      in testnull (evn,e2) 
    else if listfun = NativeFunc "hd" then
      let hd (evn,e2) = 
        let res = eval (evn,e2) in
        match res with
        |Pair (Int a,Nil) -> Int a
        |Pair (Int a,Pair(x,y)) -> Int a
        |_ -> raise (MLFailure ("Empty or Non-list"))
      in hd (evn,e2)
    else if listfun = NativeFunc "tl" then
      let tl (evn,e2) = 
        let res = eval (evn,e2) in
        match res with
        |Pair (Int a,Nil) -> Nil
        |Pair (Int a,Pair(x,y)) -> Pair(x,y)
        |_ -> raise (MLFailure ("Empty or Non-list"))
      in tl (evn,e2)
    else 
    match listfun with
    |Closure(evn1,None,x',e') -> eval((x',eval(evn,e2))::evn1,e')
    |Closure(evn1,Some ff,x',e') -> eval((ff,listfun)::(x',eval(evn,e2))::evn1,e')
    |_ ->
    (*if listfun = NativeFunc "hd" || listfun = NativeFunc "tl" || listfun = NativeFunc "null"
    then

    else*)
      let otherfun = eval (evn,e1) in
      match otherfun with
      |Closure (evn1,f,x,e) ->
        let v = eval (evn, e2) in
        let evn' = (
          match f with
          | Some n -> (n, Closure (evn1,f,x,e))::(x,v)::evn1
          | None -> (x,v)::evn1
        ) in eval (evn', e)
      |_ -> raise (MLFailure ("App input error: first args non-func"))
  )
  |Fun (x,e) -> Closure(evn,None,x,e)


      
(*
| App (a,b) -> (match a with
      | Var ("hd") -> (match eval (evn,b) with Pair (x,y) -> x)
      | Var ("tl") -> (match eval (evn,b) with Pair (x,y) -> y)
      | _ -> match eval (evn,a) with
       | Closure (place,choice,domain,range) -> (match choice with
        | Some i -> eval (((i, Closure(place,choice,domain,range))::((domain,eval (evn,b))::place)),range)
        | None -> eval (((domain, eval (evn,b))::place),range))) 
*)

(*
type binop = 
  Plus 
| Minus 
| Mul 
| Div 
| Eq 
| Ne 
| Lt 
| Le 
| And 
| Or          
| Cons

type expr =   
  Const of int 
| True   
| False      
| NilExpr
| Var of string    
| Bin of expr * binop * expr 
| If  of expr * expr * expr
| Let of string * expr * expr 
| App of expr * expr 
| Fun of string * expr    
| Letrec of string * expr * expr
  
type value =  
  Int of int    
| Bool of bool          
| Closure of env * string option * string * expr 
| Nil                    
| Pair of value * value     
| NativeFunc of string
*)
(**********************     Testing Code  ******************************)
