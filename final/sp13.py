# 5

def rev(l):
    return [l[len(l)-i-1] for i in range(len(l))]



def rev(l):
    def fold_fn(acc,elm):
        return [elm]+acc
    return reduce(fold_fn,l,[])

# 6. [ 15 points ] In this question you will write a decorator print_some(l) which takes a list of integers l
# indicating how to selectively print the arguments and return value of the original function. For this problem,
# don’t worry about keyword arguments, and assume that l contains no duplicates.
# The function after decoration should call the original function, but in addition, for each element i in l, the
# function after decoration should also do the following:
# 1. If i = −1, print the return value of the original function after it’s called.
# 2. Otherwise, print the i
# th argument (if it exists) before the original function is called

def print_some(l):
    class ps:
        def __init__(self,f):
            self.f = f
            self.__name__ = f.__name__
        def __call__(self,*args):
            printRes = False
            for e in l:
                if e == -1:
                    printRes = True
                else:
                    if e >= 0 and e < len(args):
                        print("Arg " + str(e) + ": " + str(args[e]))
            res = self.f(*args)
            if printRes:
                print("Return: " + str(res))
            return res
    return ps


# @print_some([-2,100])
# def plus(x,y):
#     print('-- plus called --')
#     return x+y

# @print_some([-1,0])
# def fac(n):
#     print ("-- fac called --")
#     if n is 0: return 1
#     else: return n * fac(n-1)


def apply_to_tree(s,t):
    if not t.is_var():
        return node(t.name,[apply_to_tree(s,c) for c in t.children])
    elif  t.name in s:
        return apply_to_tree(s,s[t.name])
    else:
        return var(t.name)


def unify(a,b,s={}):
    a = apply_to_tree(s, a)
    b = apply_to_tree(s, b)
    result = s.copy()
    if a.is_var() and b.is_var(): 
        result[a.name] = b
    elif a.is_var() and not b.is_var():
        if a.name in result: 
            result = unify(result[a.name],b,result)
        else:
            result[a.name] = b
    elif not a.is_var() and b.is_var():
        return unify(b,a,s)
    elif not a.is_var() and not b.is_var():
        if a.name != b.name: return False
        if len(a.children) != len(b.children): return False
        for i in range(len(a.children)):
            result = unify(a.children[i],b.children[i],result)
return result






