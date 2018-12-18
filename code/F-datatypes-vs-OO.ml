type tree = 
| Leaf of int
| Node of tree*tree ;;


Leaf 0;;

let x = Node(Node(Leaf 1, Leaf 2), Leaf 3);;

(* sum all leaves *)
let rec sum t =































(* solution *)
let rec sum t =
   match t with
   | Leaf i -> i
   | Node (t1,t2) -> sum t1 + sum t2;;

sum x;;


















(* delete all occurances of i by replacing them with 0 *)
let rec delete t i = 



















































(* solution *)

let rec delete t i =
   match t with
   | Leaf i' -> if i = i' then Leaf 0 else Leaf i'
   | Node (t1,t2) -> Node(delete t1 i,delete t2 i);;




(* Now, add Empty case to datatype, and update sum, delete *)





















(* solution: need to change functions sum and delete, on the
 * other hand, adding a function like find_max does not require
 * changing any other functions -- it can be done modularly *)
type tree = 
| Empty
| Leaf of int
| Node of tree*tree ;;

let rec sum t =
   match t with
   | Empty -> 0
   | Leaf i -> i
   | Node (t1,t2) -> sum t1 + sum t2;;

let rec delete t i =
   match t with
   | Empty -> Empty
   | Leaf i' -> if i = i' then Empty else Leaf i'
   | Node (t1,t2) -> Node(delete t1 i,delete t2 i);;






(* Let's do the same exercise, but in an OO language like java *)

(* OCaml *)
type tree = 
| Leaf of int
| Node of tree*tree ;;

let rec sum t =
   match t with
   | Leaf i -> i
   | Node (t1,t2) -> sum t1 + sum t2;;

let rec delete t i = 
   match t with
   | Leaf i' -> Leaf (if i = i' then 0 else i')
   | Node (l,r) -> Node (delete l i, delete r i);;

(* Java *)















































































(* solution *)

abstract class Tree {
   abstract public int sum();
   abstract public Tree delete(int i);
}

class Leaf extends Tree {
   private int data;
   public Leaf(int i) { data = i; }
   int sum () { return data; }
   Tree delete(int i) {
      if (data == i) {
         return Leaf(0)
      } else {
         return this
      }
}

class Node extends Tree {
   private Tree left;
   private Tree right;
   public Node(Tree l, Tree r) { left = l; right = r; }
   int sum () { return left.sum() + right.sum() }
   Tree delete(int i) {
      return Node(left.delete(), right.delete())
   }
}


x = Node(Node(Leaf(1), Leaf(2)), Leaf (3))
x.sum()

(* note: the code of "sum" and "delete" is spread through several classes, 
   whereas in ocaml, all the code for "sum" and "delete" were in one
   place

   OCaml organizes computation by operations
      given an operation, write all cases for that operation in one place
      in other words, write each operation, and inside you list each kind of data

   OO organizes computation by cases
      given a case, write all operations for that case in one place   
      in other words, write each kind of data, and inside you list each operation
*)



(* In java, let's add Empty *)




















(* solution *)
class Empty extends Tree {
   public int sum() { return 0; }
   public Tree delete(int i) { return Empty; }
}

(* note: can add Empty case in a modular way, by just adding code,
  without modifying any code *)

(* Key lesson:
   OCAML pattern matching vs OO encoding


   OCAML: allows for modular addition of "operations" like "sum":
    - in OCaml, can add a new operation all in one place
    - in OO, requires changing many different classes
  
   OO: allows for modular addition of cases like "Empty":
    - in OO, can add "Empty" all in one place
    - in OCaml, requires changing all functions that match on Tree
*)




