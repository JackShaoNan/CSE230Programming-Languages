#!/usr/bin/env python3
from misc import Failure

class profiled(object):
    def __init__(self,f):
        self.__count=0
        self.__f=f
        self.__name__=f.__name__
    def __call__(self,*args,**dargs):
        self.__count+=1
        return self.__f(*args,**dargs)
    # testsnnnnnnnnnnnn
    def count(self):
        return self.__count
    def reset(self):
        self.__count=0

class traced(object):
    __level = 0
    def __init__(self,f):
        self.__f = f
        self.__name__ = f.__name__
    def __call__(self, *args, **kargs):
        # print (self.__level)
        # print pipes
        sb = "| " * traced.__level
        # print comma
        sb += ",- "
        # print function name, *args, and **kargs
        sb += self.__name__ + "("
        sb += ", ".join([repr(arg) for arg in args])
        sb += ", ".join([str(key) + "=" + repr(val) for key,val in kargs.items()])
        print(sb + ')')
        # increase nesting level and call function itself
        traced.__level += 1
        try:
            res = self.__f(*args, **kargs)
            # at original nesting level, print pipes
            traced.__level -= 1
            sb = "| " * traced.__level
            # Print backquote then minus then space
            sb += "`- "
            # print repr() of return value
            print(sb + repr(res))
            return res
        except Exception as e:
            traced.__level -= 1
            raise e
    


class memoized(object):
    __map = {}
    def __init__(self,f):
        # replace this and fill in the rest of the class
        self.__name__ = f.__name__
        self.__func = f
    def __call__(self, *args, **kargs):
        key = str(args) + str(kargs) 
        if key in memoized.__map:
            if isinstance(memoized.__map[key], Exception):
                raise memoized.__map[key]
            else:
                return memoized.__map[key]
        try:
            res = self.__func(*args, **kargs)
            memoized.__map[key] = res
            return res
        except Exception as e:
            memoized.__map[key] = e
            raise e




# run some examples.  The output from this is in decorators.out
def run_examples():
    for f,a in [(fib_t,(7,)),
                (fib_mt,(7,)),
                (fib_tm,(7,)),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (fib_mp.reset,()),
                (fib_mp,(7,)),
                (fib_mp.count,()),
                (even_t,(6,)),
                (quicksort_t,([5,8,100,45,3,89,22,78,121,2,78],)),
                (quicksort_mt,([5,8,100,45,3,89,22,78,121,2,78],)),
                (quicksort_mt,([5,8,100,45,3,89,22,78,121,2,78],)),
                (change_t,([9,7,5],44)),
                (change_mt,([9,7,5],44)),
                (change_mt,([9,7,5],44)),
                ]:
        print("RUNNING %s(%s):" % (f.__name__,", ".join([repr(x) for x in a])))
        rv=f(*a)
        print("RETURNED %s" % repr(rv))

@traced
def fib_t(x):
    if x<=1:
        return 1
    else:
        return fib_t(x-1)+fib_t(x-2)

@traced
@memoized
def fib_mt(x):
    if x<=1:
        return 1
    else:
        return fib_mt(x-1)+fib_mt(x-2)

@memoized
@traced
def fib_tm(x):
    if x<=1:
        return 1
    else:
        return fib_tm(x-1)+fib_tm(x-2)

@profiled
@memoized
def fib_mp(x):
    if x<=1:
        return 1
    else:
        return fib_mp(x-1)+fib_mp(x-2)

@traced
def even_t(x):
    if x==0:
        return True
    else:
        return odd_t(x-1)

@traced
def odd_t(x):
    if x==0:
        return False
    else:
        return even_t(x-1)

@traced
def quicksort_t(l):
    if len(l)<=1:
        return l
    pivot=l[0]
    left=quicksort_t([x for x in l[1:] if x<pivot])
    right=quicksort_t([x for x in l[1:] if x>=pivot])
    return left+l[0:1]+right

@traced
@memoized
def quicksort_mt(l):
    if len(l)<=1:
        return l
    pivot=l[0]
    left=quicksort_mt([x for x in l[1:] if x<pivot])
    right=quicksort_mt([x for x in l[1:] if x>=pivot])
    return left+l[0:1]+right

class ChangeException(Exception):
    pass

@traced
def change_t(l,a):
    if a==0:
        return []
    elif len(l)==0:
        raise ChangeException()
    elif l[0]>a:
        return change_t(l[1:],a)
    else:
        try:
            return [l[0]]+change_t(l,a-l[0])
        except ChangeException:
            return change_t(l[1:],a)

@traced
@memoized
def change_mt(l,a):
    if a==0:
        return []
    elif len(l)==0:
        raise ChangeException()
    elif l[0]>a:
        return change_mt(l[1:],a)
    else:
        try:
            return [l[0]]+change_mt(l,a-l[0])
        except ChangeException:
            return change_mt(l[1:],a)





# @traced()
# def foo(a,b):
#     if a==0: return b
#     return foo(b=a-1,a=b-1)
# from time import sleep
# @memoized
# def foo(a): 
#     sleep(a)
#     return a
