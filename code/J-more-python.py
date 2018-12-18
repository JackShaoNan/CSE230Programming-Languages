

z = [1,2,3,4,5,6,7,8,9,10]
z[3:6] = ["a","b","c"]
z 

# What about?
a = (1,2,3,4,5,6,7,8,9,10)
a[3:6] = ["a","b","c"]
a[3] = 3

# What's the moral? How are tuples and lists different?

z[3:6] = ["a", "b"] * 2 
z
z[4:]=[]
z
z[:0] = ["al", "be"]
z

# go back to slides

























# membership testing!

"a" in "cat" 
"a" in "entebbe"
"a" in ("c" , "a", "t") 
2 in [1,2,3,4,5]
2 in [1,4,"92",2.4]



# go back to slides
































# for loops!

for x in ["Midterms", "ain't", "cool"]:
        for y in x:
                print(y*3)



for c in "chimichanga":
  print(c*3)





s=0
z=(1,2,3,4.0,"5")    #tuple
for i in z:
  s = s + i

# What's the value of s here?

























































# Can bind multiple vars in for loop

craigslist = [("alien",3.50),
              ("dinosaur",1.90),
              ("quesadilla",3.00),
              ("good grade in Lerner's class","priceless")] 

for (i,p) in craigslist:
  print("One " + str(i) + " costs " + str(p))

# go back to slides


























# What about old style for loops
range(10)

for i in range(10): print(i)

range(5,15)

range(5,15,2)
for i in range(5,15,2): print(i)


range(15,5,-2)
for i in range(15,5,-2): print(i)


























# What does this do?
s = [1,2,3,4,5]
s[len(s):] = [1]














# What does this do?
def funny_fun(s):
   for x in s:
      print(x)
      s[len(s):] = [x]


funny_fun([])

funny_fun([1])

funny_fun([1,2,3])




















def funny_fun(s):
   for x in s:
      print(x)
      s.append(x)

def funny_fun(s):
   for x in s:
      print(x)
      s = s + [x]
   print(s)
























# Moral of the story: what is the difference between
#    s.append(x) or s[len(s):] = [x] 
#       and 
#    s = s + [x]















# If you want to be sure...
   for x in s[:]:
     ...
#go back to slides


































def dup(x):
  return 2*x

z = range(10)
list(map(dup,z))

list(map(dup,"chimichanga"))



def even(x): return x%2==0
for i in filter(even,range(10)): print(i)
for i in filter(even,"1234096001234125"): print(i)
for i in filter(even,["1234096001234125"]): print(i)
for i in filter(even,(1,2.0,3.2,4)): print(i)

def add(x,y): return x+y

import functools

functools.reduce(add,range(10),0)





def fac(x):
   def mul(x,y): return x*y
   return functools.reduce(mul, range(x), 1)




































def fac(x): 
  def mul(x,y): return x*y
  return functools.reduce(mul,range(1,x+1),1)


# back to slides
























        


# List comprehension

[ x*x for x in range(10) ]

[2*x for x in "this sentence is false"]















# let's do it using map:





















def sq(x): return x*x
map(sq, range(10))





# More generally,
# [ex for x in s] equialent to:

# def map_fn(x): return ex 
# map(map_fn, s)













































# List comprehension more advanced

[ 2*x for x in "0123456" if int(x)>5]

























# let's do it using map/filter























def t2(x):
   return 2*x
map(t2,filter(even,"0123456"))

# More generally:
# [ex for x in s if cx ]
# equivalent to 

# def map_fn(x): return ex 
# def filter_fn(x): return cx
# map(map_fn, filter(filter_fn, s))




# say we want to know what elements on craigslist cost less than 3?

craigslist = [("alien",3.50),
              ("dinosaur",1.90),
              ("quesadilla",3.00),
              ("good grade in Lerner's class","priceless")] 








































[z[0] for z in craigslist if str(z[1])<str(3.0)]




































# Even more advanced

[(x,y) for x in range(3) for y in range(3)]

[(x,y) for x in range(3) for y in range(3) if x > y]


# back to slides













#Quicksort in Pyhon: fill in the blanks!
def sort(L):
  if L==[]: return L
  else: # use L[0] as pivot
    l=sort( [ ____ for ____ in ____ if _____ ] )
    r=sort( [ ____ for ____ in ____ if _____ ] )
    return (_____)

























#Quicksort in Pyhon

def sort(L):
  if L==[]: return L
  else:
    l=sort([x for x in L[1:] if x < L[0]])
    r=sort([x for x in L[1:] if x >= L[0]])
    return(l+L[0:1]+r)


sort([1,44,12,31,34])

# back to slides



































# Dictionaries

d={}
d=dict(craigslist)
d
d["alien"]
d["dictionary"] = 0.50
d
d["bad grade in 130"]



d.keys()
d.values()

"alien" in d
3.5 in d

def freq(s):
  d={}
  for c in s:
    if c in d: d[c]+=1
    else: d[c]=1
  return d

freq([1,3,"A",3,"A","A",1,2,3,1,"A",3,3])

def plotfreq(s):
  d=freq(s)
  for k in d.keys():
    print(str(k) + ": " + "*"*d[k])
  return d
		

plotfreq([1,3,"A",3,"A","A",1,2,3,1,"A",3,3])
plotfreq("Do you know how to code in Python?")

