% envtype(Bindings,Var,Ty) :- fail.
envtype([[H,T]|_],H,T).
envtype([_|R],Var,Ty) :- envtype(R,Var,Ty).


int_op(plus).
int_op(minus).
int_op(mul).
int_op(div).

comp_op(eq).
comp_op(neq).
comp_op(lt).
comp_op(leq).

bool_op(and).
bool_op(or).

typeof(_,const(_),int).
typeof(_,boolean(_),bool).
typeof(_,nil,list(_)).
typeof(Env,var(X),T) :- envtype(Env,X,T).

typeof(Env,bin(E1,Bop,E2),int) :- 
int_op(Bop), typeof(Env, E1, int), typeof(Env, E2, int).

typeof(Env,bin(E1,Bop,E2),bool) :- 
comp_op(Bop), typeof(Env, E1, int), typeof(Env, E2, int).

typeof(Env,bin(E1,Bop,E2),bool) :- 
bool_op(Bop), typeof(Env, E1, bool), typeof(Env, E2, bool).

typeof(Env,bin(E1,cons,E2),list(T)) :- 
typeof(Env, E1, T), typeof(Env, E2, list(T)).

typeof(Env,ite(E1,E2,E3),T) :- 
typeof(Env,E1,bool), typeof(Env,E2,T),typeof(Env,E3,T).

typeof(Env,let(X,E1,E2),T) :- 
typeof(Env,E1,K), typeof([[X,K]|Env],E2,T).

typeof(Env,letrec(X,E1,E2),T) :- 
typeof([[X,T1]|Env],E1,K), typeof([[X,K]|Env],E2,T).

typeof(Env,fun(X,E),arrow(T1,T2)) :- 
typeof([[X,T1]|Env],E,T2).

typeof(Env,app(E1,E2),T) :- 
typeof(Env, E1, arrow(K,T)), typeof(Env,E2,K).




% eval ([],Letrec("f",Fun("x",Const 0),Var "f"));;
% typeof([], Letrec(f,fun(x, const(0),var(f))), T).
% T = 
% ?- typeof([],let(x,const(10),var(x)),T).
% T = int ;
% false.
