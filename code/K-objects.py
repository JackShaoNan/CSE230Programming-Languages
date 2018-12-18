
#----------------------------------------------------------

class Point:
  x = 0
  y = 0


p = Point()

p.x

p.y

p.x = 7


q = Point()

q.x

q.x = 10

p.x 

# go back to slides




























# Flavor of prototype-based model

class Point:
  x = 0
  y = 0

Point

Point.__dict__.keys()
# notice how classes are just a namespace!

Point.x

Point.y

p = Point()

p.x

p.__dict__

p.x = 10

p.__dict__

q = Point()

q.x

Point.x = 30

q.x





























#-----------------------------------------------------------
# let's add methods!

class Point:
  x = 0
  y = 0
  def move(this,dx,dy):
    this.x = this.x + dx
    this.y = this.y + dy



Point.x
Point.y
Point.move



p = Point()
p.move
# notice the "bound" part
# what does this mean?

p.move(10,100)

move(p,10,100)


# doesn't work. But...
















Point.move(p,10,100)

# also:
f = p.move
(p.x,p.y)
for i in range(10): f(100,100)
(p.x,p.y)


# go back to slide





























#-----------------------------------------------------------
# Constructors

class Point:
  x = 0
  y = 0
  def move(self,dx,dy):
    self.x = self.x + dx
    self.y = self.y + dy
  def jump(self,x,y):
    self.x = x
    self.y = y
  def __init__(self,x,y):
    self.jump(x,y)
  def __repr__(self): 
    return "Point(" + str(self.x) + "," + str(self.y) + ") with id " + hex(id(self))
  def __str__(self):
    return "x = " + str(self.x) + " y = " + str(self.y)
    
p = Point(100,100)

p

print(p)

str(p)

# __repr__ goal is to be unambiguous
# __str__ goal is to be readable -- note that str(5) == str("5") but repr(5) != repr("5")


#-----------------------------------------------------------
# Subclassing

class Point:
  x = 0
  y = 0
  def __init__(self,x,y):
    self.x = x
    self.y = y
  def move(self,dx,dy):
    s = "Moving from " + str(self.x) + " " + str(self.y) + " to "
    self.x = self.x + dx
    self.y = self.y + dy
    print(s + str(self.x) + " " + str(self.y))
  def draw(self):
    print("Plot a point at " + str(self.x) + " " + str(self.y))

class ColoredPoint(Point):
  color = "blue"
  def __init__(self,x,y,color):
     Point.__init__(self,x,y)
     self.color = color
  def draw(self):
    print("Set color to: " + str(self.color))
    Point.draw(self)


#-----------------------------------------------------------
# Duck typing

def do_some_moving(p):
  for x in [-2,-1,0,1,2]:
     for y in [-2,-1,0,1,2]:
        p.move(x,y)

class Point2:
  x = 0
  y = 0
  def move(self,dx,dy):
    self.x = self.x + dx
    self.y = self.y + dy

class Point1:
  x = 0
  y = 0
  def move(self,dx,dy):
    self.x = self.x + dx
    self.y = self.y + dy

class Circle:
  x = 0
  y = 0
  radius = 10
  def move(self,dx,dy):
    self.x = self.x + dx
    self.y = self.y + dy

class Clown:
  def move(self,dx,dy):
    print("Ha! Ha! Fooled you!") 
  def say_joke():
    print("knock knock!");


# Note the "Duck-Typing" Polymorphism
# do_some_moving works for any object with a "move" method
# Structural (by-elements-of-object) Subtyping:
#   Point, Point2, Clown etc.
#   are all "structural subtypes"
#   of an object with a "move" method 
# vs.
# Nominal (by-name) Subtyping
#   Programmer names classes and
#   explicitly tells system that
#   one class C1 is a subtype of C2
#   e.g. C1 inherits from C2
#        C1 implements C2 etc.



#-----------------------------------------------------------
# A few more things about scoping model

# what's happening here? 
def g(y): return y + n

g(5)
































# Var not bound, but it's done at runtime...
# what about this? Will this work?
n = 10
g(5)
























# And how about this?
n = 100
g(5)
# What's the moral?


































# Here is another issue in Python:
n=4
def f():
  n = "smash"
  print(n)

f()

n
















































n=4
def f():
  global n
  n = "smash"
  print(n)

f()

n



# Here is another workaround:

n = [100]

def f():
  n[0] = "smash"
  print(n)

f()

n


# note: although Python doesn't allow you to assign into globals, it
# allows you to mutate objects pointed to by globals (again, note
# difference between changing "links" and changing the "contents" of a
# box)





































# ok, let's try this...

x = 10

def f():
  x = x + 1
  print(x)

f()

# or this:

x = 10

def f():
  print("A")
  y = x
  print("B")
  x = x + 1
  print(x)

f()






# but of course, if we do the following it's the global:
x = 10

def f():
  global x
  x = x + 1
  print(x)

f()


