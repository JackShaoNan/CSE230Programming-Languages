#Int Expressions:

2

2+4

6

(2+5) * (3-5)

-14
































#Float Expressions:

2.7 + 4.5

(2 + 3.5) * (2.7 -4)

0.1 + 0.11
    
# What's different from OCaml?


























# Note: Type coersion! Python does type conversion on its own. 
# OCaml would have simply rejected this expression.

# Note: its the same + for ints and floats and as we'll see, a lot
# of other things. It's just the same "+" message name, and the
# objects take care of doing the right thing.
# In python, its actually exploiting the fact that everything is an object...




















#What about this?

2 + 3j

-5.2 + 6j

(2 + 3j) * (-5.2 + 6j)
    













# Can someone tell me why it's j, not i?
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    














#String Expressions:

"this "
"this is " + "cool"
"this is w" + "a"*10 + "y cool"
"this is so cool you'll fall off your seat"

# say I want the string: Prof says: "this is way cool"






































'Prof says: "this is way cool"'
'Prof says: "this is so cool you' + "'" + 'll fall of your seat"'

# conversion functions...

str(50)

str(92.7)

str("cool stuff, dude!")

int("22")

int("abc")

int(3.9)

float(22)

float("3.14")

# These are special built-in functions that do the conversion. Note again
# dynamic typing: the int function can take anything as a
# parameter. The correct "method" is determined dynamically.































# assignment statements

x = 3

y = x + 4

s = "so "

t = "cse130 is " + s * y + "much fun" + "!" * x



# Now, it turns out that strings are a "Sequence" Types. Such types have many
# cool properties, the first of which is that they have lengths:

s

len(s)

t

len(t)
























# We can access the i'th element of a sequence...

s[0]

s[1]

t[7]


# slicing: s[i:j] is the (sub)sequence of characters from position i
# through j-1.

t

t[0:3]

t[3:6]

t[3:] 

t[:4] 

# What about t[100]? What about t[-1]

t[100]

t[-1]

#forall t. t[:i] + t[i:] is always equal to t

t[:2] + t[2:]

t[:6] + t[6:]

t[:-1] + t[-1:]

























#Tuples:

t1 = (3,5)

t2 = ("abc",2.9,99)

t3 = (t1,t2)


# What do you think this will do?
(1,2) + (3, 4)
















# What about this?
t4 = ("abc",10) * 4




























# tuples are also sequences

t1

len(t1)

t3

len(t3)

t4

len(t4)


#Can select:

t1[0]

t2[2]

t2[1:2]

t2[1:]


# What other type do you think is a sequence?




































# Another sequence type: Lists!


l1 = [9,1,1]

# no resriction on types! "heterogeneous lists"
l2 = [1, "a", 3.0, ["moo", "stew", "bamboo", "woohoo"]]

len(l1)

len(l2)


l1[0]

l2[1]

l2[3]

l2[3][0]


l2[1:3]


l1 + l2

l1 * 3

2 * l2


# next: let's do some OCaml sins...




























# mutation

l2

l2[0] = "zzz"

l2


x = [1,2,3,4,5]

y = x

y[0] = "a"

y

x

# what's the moral?


























# moral: there is aliasing!


# slice assignment

l2
l1
l2[0:3] = l1 * 7
























#Statements:

#if

x = -10
if x < 0:
  x = abs(x)
  print("Negative, flipped", x)
elif x == 0:
  print("Zero!")
else:
  print("Positive", x)




# Overall structure is:
# if <cond>:
# 	<if-body-statement>
# elif <cond>:
# 	<elif-body-statement>
# elif <cond>:
# 	<elif-body-statement>
# .
# .
# .
# else:
# 	<else-body-statement>
	
# Here the "elif" stands for "else if" -- a convenient shorthand. This is how
# you can do switch/case statements in Python.

# indentation matters!!!
pass
if x==15:
   y = 0
   print("is 15")

# different from above!!!

pass
if x==15:
  y = 0
print("is 15")

# What do you all think about this?

# Another question: what do think pass does?
































# "pass" is a dummy statement that is used when you need to have something in
# a statement block (like the above). Its to ensure that the statement block
# is not empty. As the name suggests, it doesnt do anything.

































# Conditions (for if, elif) are like the usual. Can use comparators
# ==, <,>,<=,>=,!=. Unlike in OCaml you dont have to use an explicit boolean
# type. Anything thats "not zero" is true and zero is false. However, you 
# CANNOT use = because thats assignment and you cannot assign inside an if
# conditional. Thats a separate statement!


if 1: print("true")

if 0: print("true")

if ["a"]: print("true")

# what about this?

if []: print("true")

# moral?



























# while - statement
a,b = 0,1
while b < 20:
  print(b)
  a, b = b, a+b


# Notice:
# 1. Multiple assignment: This is really "simultaneous assignment" all of rhs
# is evaluated and then "simultaneously" stuck into LHS. Actually, whats
# happening is "tuple" assignment (like pattern-matching in OCaml). We are
# assigning to the tuple (a,b) the value (0,1).

# 2. The body of the while is indented appropriately.
#
# while <cond>:
#	<while-body-statement>
#
# For nested while loops, make sure you get indentation right!
























# Up next: functions!

def fib(n):
  a,b = 0,1
  while (b < n):
    print(b)
    a,b = b,a+b




# Easy enough. Note that the "body" of the function is indented
# appropriately. General form:
#
# def fname(x1,x2,...):
#	<fbody-statement>























fib(20)

# What does this function return?

print(fib(20))


























# It returns a special value called "None".

# Can return something different using a return statement:

def fac(n):
  if n == 0:
    return 1
  else:
    return n * fac(n-1)


fac(10)

# This returns an integer, but python is dynamically-typed 
# so it can return different values.

def fac(n):
  if n < 0:
    return "Rubbish negative arg"
  elif n == 0:
    return 1
  else:
    return n * fac(n-1)


fac(-10)

fac(10)

#"default" parameters.


def greet(i,name="Bob"):
	print("H" + "e"*i + "y", name)



greet(3, "Sally")


greet(3)


# More details and other cute shortcuts in the Python Tutorial on 
# readings webpage.































# Ok, now the big bang!!! You all thought we were done with functional
# stuff... haha, you were wrong!


fac

# So this means that ...
# 1. You can nest function definitions -- just defines a "local" function
# 2. You can take functions as arguments
# 3. You can return functions as return values

# All of the functional goodness is still there!!! Woohoo, party time!
# Check it out:

def compose(f,g):
  def foo(x):
    return f(g(x))
  return foo


def times_3(x):
  return 3*x

def first_2_elems(x):
  return x[0:2]

baz = compose(times_3,first_2_elems)

baz([1, 2, "three", 4, "five"])     #works for sequences

















baz("this is the end, my friend.")  #works for sequences





