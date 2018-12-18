# 3. [ 25 points ] You will use list comprehension to implement dictionaries. A dictionary here will be a list of
# pairs, where each pair contains a key and a value. Unlike in regular Python dictionaries, a given key can appear
# multiple times in the dictionary. All operations in this question will be functional, meaning that the
# original dictionary is left unmodified, and a new dictionary is returned.
# a. [ 5 points ] First, you will implement a lookup function. Given a dictionary d and key k, lookup(d,k)
# returns the list of all values associated with the given key. For example:

def lookup(d,k):
    return [value for (key,value) in d if key == k]

# b.
def cond(b,t,f):
    if b:
        return t
    else:
        return f

def update(d,k,v):
    return [cond(key==k,(k,v),(key,value)) for (key,value) in d]
# c.
# c. [ 5 points ] You will now implement deletion. Given a dictionary d and a key k, delete(d,k,v) returns
# a new dictionary in which all entries for the key k have been removed.
# Fill in the implementation delete below:
def delete(d,k):
    return [(key,value) for (key,value) in d if k != key]

# d. [ 5 points ] You will now implement addition. Given a dictionary d, key k and value v, add(d,k,v) returns
# a new dictionary with the additional key-value pair at the end of the list representing the dictionary.
# Fill in the implementation of add below:
def add(d,k,v):
    return d+[(k,v)]

# e. [ 5 points ] You will now implement the update function from part b, but: without using list comprehension
# and without using the helper function cond. You can use other built-in functions if you want,
# but you don’t need to.
def update(d,k,v):
    res = []
    for (key,value) in d:
        if key == k:
            res.append((k,v))
        else:
            res.append((key,value))
    return res

# 4. [ 20 points ] In this question you will implement a decorator in_range, which you can assume will only be
# applied to functions that take integers and return integers. Given an integer i and a pair range of integers,
# the decorator in_range(i, range) adds the following behavior to the decorated function:
# 1. If i == -1, the decorated function should throw an exception if the return value is not in the given range.
# 2. If i is a valid index into the argument list, the decorated function should throw an exception if the ith
# argument is not in the given range.
# Here are some examples. Note specifically the strings that are printed out in the exceptions – you need to
# replicated this behavior.

def in_range(i,r):
    (start,end) = r
    class check:
        def __init__(self,f):
            self.f = f
            self.__name__ = f.__name__
        def __call__(self, *args):
            if (i == -1):
                res = self.f(*args)
                if res > end:
                    msg = "big"
                    raise Exception("Return value " + str(res) + " too " + str(msg))
                elif res < start:
                    msg = "small"
                    raise Exception("Return value " + str(res) + " too " + str(msg))
                else:
                    return res
            else:
                para = args[i]
                if para > end:
                    msg = "big"
                    raise Exception(str(i) + "th arg " + str(para) + " too " + str(msg))
                elif para < start:
                    msg = "small"
                    raise Exception(str(i) + "th arg " + str(para) + " too " + str(msg))
                else:
                    res = self.f(*args)
                    return res
    return check


# @in_range(0, (0,10))
# @in_range(1, (-10,20))
# def plus(a,b): return a+b










