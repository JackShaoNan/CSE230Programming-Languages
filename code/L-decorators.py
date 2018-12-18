
########################

# Decorators



# Background defns

class Point:
   def __init__(self,x,y):
        self.x = x
        self.y = y
   def jump(self,x,y):
        self.x += x
        self.y += y


# Say I want to make this into a Point where each Point has a unique id

class Point:
   counter = 0
   def __init__(self,x,y):
        self.x = x
        self.y = y
        Point.counter = Point.counter + 1
        self.id = Point.counter
   def jump(self,x,y):
        self.x += x
        self.y += y



















class Point:
   id_counter = 0
   def __init__(self,x,y):
        self.x = x
        self.y = y
        self.id = Point.id_counter
        Point.id_counter += 1
   def jump(self,x,y):
        self.x += x
        self.y += y

# Do the same for Counter class:

class Counter:
    counter = 0
    def __init__(self,n):
        self.ctr = n
        self.id = Counter.counter
        Counter.counter += 1
    def next(self):
        self.ctr += 1
        return self.ctr


















class Counter:
    id_counter = 0
    def __init__(self,n):
        self.ctr = n
        self.id = Counter.id_counter
        Counter.id_counter += 1
    def next(self):
        self.ctr += 1
        return self.ctr




# suckiness 1: change all classes
# suckiness 2: may not be able to modify other's code

























#--------------------------------------------------
# please... don't have a heart attack when you see this...

def counted(C):
  class CC(C): # CC extends C
    id_counter = 0
    def __init__(self,*args):
      C.__init__(self,*args)
      self.id = CC.id_counter
      CC.id_counter += 1
  return CC





























# Whoa, this is really neat. We're taking a class as a parameter, and
# returning a class!!!

#--------------------------------------------------

class Point:
   def __init__(self,x,y):
        self.x = x
        self.y = y
   def jump(self,x,y):
        self.x += x
        self.y += y

CPoint = counted(Point)

p1 = CPoint(0,0)
p2 = CPoint(1,10)
p3 = CPoint(100,100)
p4 = CPoint(25,45)

p2.id #2nd instance
p3.id #3rd instance


CPoint.id_counter  #total number of instances so far


p1.jump(20,20) # can still call Point methods


class Counter:
    def __init__(self,n):
        self.ctr = n
    def next(self):
        self.ctr += 1
        return self.ctr

CCounter = counted(Counter)
c1 = CCounter(10)
# c1 is indeed a counter...
for i in range(10):print(c1.next())
c2 = CCounter(0)
c3 = CCounter(-1992)
c4 = CCounter(1000)
c5 = CCounter(10)
# c2,c3,c4,c5 are all counters
for i in range(10):
    print(c2.next(),c3.next(),c4.next(),c5.next())

class Fish:
   length = 0
   weight = 0

CFish = counted(Fish)

c5.id  #fifth instance
c1.id  #first instance
CCounter.id_counter #total number of instances



# What are the problems with this?









































# To help:


class ListCell:
    def __init__(self,n):
        self.data = 0
        if n > 1: self.next = ListCell(n-1)
        else: self.next = None
    def str(self):
        if self.next: rest = " --> " + str(self.next)
        else: rest = ""
        return str(self.data) + rest
    def __repr__(self):
        return ListCell.str(self)

OldListCell = ListCell
ListCell = counted(ListCell)
ListCell = OldListCell






ListCell = counted(ListCell)

l = CListCell(5)
l
l.data = 1
l.next.data = 2
l.next.next.data = 3
l

#but we see that:
CListCell.id_counter
l.id
l.next.id

























# Problems:
#  1. Must change all creation points (intead of Point(), do CPoint())
#  2. What if the class refers to itself?

# How can we fix this? ie: want all cells to be counted...


























#instead if we did:
class ListCell:
    def __init__(self,n):
        self.data = 0
        if n > 1: self.next = ListCell(n-1)
        else: self.next = None
    def str(self):
        if self.next: rest = " --> " + str(self.next)
        else: rest = ""
        return str(self.data) + rest
    def __repr__(self):
        return ListCell.str(self)

CListCell = counted(ListCell)

l = ListCell(10)
l.data = "a"
l.next.data = "b"
l.next.next.data = "c"
l
ListCell.id_counter
l.id
l.next.id
l.next.next.id

m = ListCell(120)
n = ListCell(25)

n.id

ListCell.id_counter

#and we can tell for each cell, when was it created
n.next.next.next.id





































#-------------------------------------------------
#can do this with ANY class

class Point:
    def __init__(self,x,y):
        self.x = x
        self.y = y
        
Point=counted(Point)

class Counter:
    def __init__(self,n):
        self.ctr = n
    def next(self):
        self.ctr += 1
        return self.ctr

Counter=counted(Counter)


class ListCell:
    def __init__(self,n):
        self.data = 0
        if n > 1: self.next = ListCell(n-1)
        else: self.next = None
    def __str__(self):
        if self.next: rest = " --> " + str(self.next)
        else: rest = ""
        return str(self.data) + rest

ListCell = counted(ListCell)


























# In fact this is such a common idiom that Python has special syntax
# for it:
#   @decorator
#   definition d
# is equivalent to:
#   definition d
#   d = decorator(d)


@counted
class Point:
   def __init__(self,x,y):
      self.x = x
      self.y = y

# equivalent to:

class Point:
    def __init__(self,x,y):
        self.x = x
        self.y = y
        
Point=counted(Point)


































#---------------------------------------------------------- 
# can decorate functions...

# The following:
#   @decorator
#   def f(...):
#      <body>
# is equivalent to:
#   def f(...):
#     <body>
#   f = decorator(f)
#

def by_two(f):
   def g(x): return f(x)*2
   return g


@by_two
def incr(x): return x + 1


# equivalent to:

#   def incr(x): return x + 1
#   incr = by_two(incr)

incr(4)

@by_two
@by_two
def incr(x): return x + 1

# is equiv to:

def incr(x): return x+1
incr = by_two(incr)
incr = by_two(incr)

incr(4)


















# what if we get the type wrong?
def by_two(f):
   def g(x): return f(x)*2
   return 0

@by_two
def incr(x): return x + 1


incr
incr(3)































# Let's see a more complicated example... We want to log a function



def logged(f):
    def g(x):
        print("Call " + f.__name__  + " arg: " + str(x))
        rv = f(x)
        print("Returns " + str(rv))
        return rv
    return g



@logged
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)

# is equivalent:

def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)
fac = logged(fac)


fac(5)



@logged
def plus(x,y):
  return x+y

# is equivalent:

def plus(x,y):
  return x+y
plus = logged(plus)

plus(10,10)


































# So, we need to handle variable number of args
def f(x,*args):
   print(x)
   print(args)

f(2,3,4)
f(2)
f()
f(2,3,4,5,6,7)

def g(x,y,z):
  return x+y+z

g(1,2,3)
g(1,[2,3])
g(1,*[2,3])
g(1,*(2,3))



f(2,[3,4])
f(2,*(3,4))
f(2,*[3,4])




















#--------------------------------------------------
# ok, now we are ready to rewrite our logged decorator again
def logged(f):
    def g(*args):
        print("Call " + f.__name__ + " args: " + str(args))
        rv = f(*args)
        print("Returns " + str(rv))
        return rv
    g.__name__ = f.__name__
    return g

#--------------------------------------------------

@logged
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)

fac(5)

@logged
def plus(x,y):
  return x+y

plus(10,10)
































#---------------------------------------------------------
# decorators are first class too...
# checkargtype takes an integer and a type, and returns a decorator
def checkargtype(id,type):
  def decorator(f):
    def decorated(*args):
      if not(isinstance(args[id],type)):    
        raise Exception("Arg %d (%s) not of type %s"
                        % (id,repr(args[id]),repr(type)))
      return f(*args)
    decorated.__name__ = f.__name__
    return decorated
  return decorator












# note that checkargtype(1,int) returns a function, in this case
# a decorator. How do we know it's a decorator?
checkargtype(1,int)




















def g(s,i):
    print(s)
    print(i)


@checkargtype(1,int)
def g(s,i):
    print(s)
    print(i)


def g(s,i):
    print(s)
    print(i)
g = checkargtype(1,int)(g)
g(10,10)


@checkargtype(1,int)
@checkargtype(0,str)
def g(s,i):
    print(s)
    print(i)

g(11,31)
g("a","b")
g("a",10)

#---------------------------------------------------------

# Up until now our decorators have not stored any state inside of
# them. Suppose we wanted to do that...

# let's say we want to keep track of how many times a function is
# called...

def profiled(f):
   def g(*args):
      return f(*args)
   return g


@profiled
def incr(x): return x+1

# equivalent to:
def incr(x): return x+1
incr = profiled(incr)


incr(10)

@profiled
def decr(x): return x-1



























# solution
def profiled(f):
   def g(*args):
      g.cnt = g.cnt+1
      return f(*args)
   g.__name__ = f.__name__
   g.cnt = 0
   return g













# Another more elegant solution: use a class!
# But let's first take a closer look at functions...

def f(x): return x + x

f(10)

f.__call__(10)

# So... a function is an object that has a special call method.
# check it out:

class f:
   def __call__(self,x):
      return x + x

f(10)
















f() # constructing the function

f()(10) # constructing and calling it...






























#---------------------------------------------------------
# ok, so let's take a look at how to do the profile example:
class profiled:
    def __init__(self,f):
        self.count=0
        self.f=f
        self.__name__ = f.__name__
    def __call__(self,*args):
        self.count += 1
        return self.f(*args)
    def reset(self):
        self.count = 0



#---------------------------------------------------------
@profiled
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)

# the same as saying:
# def fac(n):...
# fac = profiled(fac)

fac(10)
fac.__call__(10)
fac(5)
fac(10)
fac(4)
fac.count





#---------------------------------------------------------
# write profiled(i) where you increment counter by i each time


@profiled(10)
def mult(x): return x*100

# def mult(x): return x*100
# mult = profiled(10)(mult)

@profiled(1)
def decr(x): return x-1




@profiled(10)
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)


























# soln

def profiled(i):
   def deco(f):
      def g(*args):
         g.counter = g.counter + i
         return f(*args)
      g.counter = 0
      return g
   return deco

def profiled_with_param(i):
  class profiled:
      def __init__(self,f):
          self.count=0
          self.f=f
          self.__name__=f.__name__
      def __call__(self,*args):
          self.count += i
          return self.f(*args)
      def reset(self):
          self.count = 0
  return profiled

@profiled_with_param(10)
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)



# let's write logged using a class:




















#soln
class logged:
  def __init__(self, f):
     self.f = f
     self.__name__ = f.__name__
  def __call__(self,*args):
     print("Call " + self.f.__name__  + " arg: " + str(args))
     rv = self.f(*args)
     print("Returns " + str(rv))
     return rv

#---------------------------------------------------------
#can compose decorators


@profiled
@logged
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)


@logged
@profiled
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)

fac = profiled(fac)
fac = logged(fac)


@profiled
@checkargtype(0,int)
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)


#same as:
#fac = profiled(checkargtype(0,int)(fac))
#remember that checkargtype(0,int) returns a function

fac(5)
fac(10)
fac.count
fac("This is so rad!!!")


# What if did it the other way around?
@checkargtype(0,int)
@profiled
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)

fac(5)
fac(10)
fac.count
fac("This is so rad!!!")
























# let's update checkargtype to have access to inner function:


@checkargtype(0,int)
def incr(x): return x+1

















# soln:
def checkargtype(id,type):
  def decorator(f):
    def decorated(*args):
      if not(isinstance(args[id],type)):    
        raise Exception("Arg %d (%s) not of type %s"
                        % (id,repr(args[id]),repr(type)))
      return f(*args)
    decorated.__name__ = f.__name__
    decorated.inner = f
    return decorated
  return decorator


###########################
# Write before and after decorator. @before(f) adds a call to f before
# the decorated function. @after(f) adds a call to f after the
# decorated function.

# for example:
@before(lambda y: print("before: " + str(y)))
@after(lambda z: print("after: " + str(2*z)))
def incr(x):
   print("inside incr: " + str(x + 1))
   return x+1


# should result in: 
# >>> incr(10)
# before: 10
# inside incr: 11
# after: 20


# Recall:
def checkargtype(id,type):
  def decorator(f):
    def decorated(*args):
      if not(isinstance(args[id],type)):    
        raise Exception("Arg %d (%s) not of type %s"
                        % (id,repr(args[id]),repr(type)))
      return f(*args)
    decorated.inner = f
    return decorated
  return decorator

# Recall:
class logged:
  def __init__(self, f):
     self.f = f
     self.__name__ = f.__name__
  def __call__(self,*args):
     print("Call " + f.__name__  + " arg: " + str(args))
     rv = self.f(*args)
     print("Returns " + str(rv))
     return rv






















































































# soln:
def before(bef):
  def decorator(f):
    def decorated(*args,**kwargs):
      bef(*args,**kwargs)
      return f(*args,**kwargs)
    return decorated
  return decorator

def after(aft):
  def decorator(f):
    def decorated(*args,**kwargs):
      rv = f(*args,**kwargs)
      aft(*args,**kwargs)
      return rv
    return decorated
  return decorator

def before(bef):
   class deco:
      def __init__(self, f):
         self.f = f
      def __call__(self, *args):
         bef(*args)
         self.f(*args)
   return deco



























########################
# Write an "average" decorator, which prints a running average of all
# the values that have been returned by the decorated function

@average
def id(x): return x

# id(10)
# 10
# id(20)
# 15
# id(30)
# 20

@average
def fac(n):
    if n <= 0: return 1
    else: return n*fac(n-1)





# to help you, recall the following example:
class profiled:
    def __init__(self,f):
        self.count=0
        self.f=f
    def __call__(self,*args):
        self.count += 1
        return self.f(*args)





class average:
    def __init__(self,f):
        self.count = 0
        self.sum = 0
        self.f = f
    def __call__(self,*args):
        res = self.f(*args)
        self.count += 1
        self.sum += res
        print('avg: ', self.sum / self.count)
        return res



@average
def id(x): return x









#soln:
class average:
    def __init__(self,f):
        self.count=0
        self.sum = 0
        self.f=f
    def __call__(self,*args,**kwargs):
        rv = self.f(*args,**kwargs)
        self.count += 1
        self.sum += rv
        print("Average: " + str(float(self.sum)/self.count))
        return rv


def average(f):
	def g(*args):
		rv = f(*args)
		g.total += rv
		g.number += 1
		print("Average " + str(g.total / g.number))
		return rv
	g.total = 0.0
	g.number = 0.0
	return g



###########
# let's write checkargtype using a class:

# def checkargtype(id,type):
#     class cat:
#         def __init__(self,f):
#             self.f = f
#             self.__name__ = f.__name__
#         def __call__(self,*args):
#             if not isinstance(args[id],type):
#                 raise Exception
#             else:
#                 return self.f(*args)
#     return cat















#soln
def checkargtype(id,type):
  class decorator:
    def __init__(self,f):
      self.f = f
      self.__name__ = f.__name__
    def __call__(self,*args):
      if not(isinstance(args[id],type)):    
        raise Exception("Arg %d (%s) not of type %s"
                        % (id,repr(args[id]),repr(type)))
      return self.f(*args)
  return decorator

