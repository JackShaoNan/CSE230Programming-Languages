from misc import Failure
import collections

class Vector(object):
    """The constructor should take a single argument. If this argument is an int or 
       an instance of a class derived from int, then consider this argument to be the 
       length of the Vector. In this case, construct a Vector of the specified length 
       with each element is initialized to 0.0. If the length is negative, raise a 
       ValueError with an appropriate message. If the argument is not considered to be 
       the length, then if the argument is a sequence (such as a list), then initialize 
       with vector with the length and values of the given sequence. If the argument is 
       not used as the length of the vector and if it is not a sequence, then raise a 
       TypeError with an appropriate message."""
    def __init__(self, args):
        # check if it is int
        if isinstance(args, int):
            length = args
            if length >= 0:
                self.value = [0.0]*length
            else:
                raise ValueError("Vector length cannot be negative")
        # check if it can be iterated
        elif isinstance(args, collections.Sequence):
            self.value = []
            for e in args:
                self.value.append(e)
        else:
            raise ValueError("Vector length error")
        #return __repr__()    


    """return a string of python code which could be used to initialize the Vector. 
       This string of code should consist of the name of the class followed by an 
       open parenthesis followed by the contents of the vector represented as a list 
       followed by a close parenthisis."""
    def __repr__(self):
        res = 'Vector('
        res += repr(self.value)
        res += ')'
        return res 

    """The function __len__ should return the length of the Vector."""
    def __len__(self):
        return len(self.value)

    """The function __iter__ should return an object that can iterate over the 
       elements of the Vector."""
    def __iter__(self):
        for v in self.value:
            yield(v)
    """Implement the + and += operators for Vector. The other argument to + and 
       the second argument to += can be any sequence of the same length as the vector. 
       All of these should implement component-wise addition"""
    def __add__(self,v):
        if len(self.value) != len(v):
            raise ValueError("Vector length error")
        else:
            return Vector(list((e1+e2) for (e1,e2) in zip(self.value,v)))

    def __radd__(self,v):
        if len(self.value) != len(v):
            raise ValueError("Vector length error")
        else:
            return Vector(list((e1+e2) for (e1,e2) in zip(self.value,v)))

    def __iadd__(self,v):
        if len(self.value) != len(v):
            raise ValueError("Vector length error")
        else:
            self.value = list((e1+e2) for (e1,e2) in zip(self.value,v))
            return self

    """the method dot which takes either a Vector or a sequence and returns the dot 
        product of the argument with current Vector instance. The dot product is 
        defined as the sum of the component-wise products. The behavior of this 
        function if any elements are not numeric is undefined."""
    def dot(self,v):
        res = 0
        for (e1,e2) in zip(self.value,v):
            res += e1*e2
        return res

    """the __getitem__ and __setitem__ methods to allow element level access to the 
       Vector. Indexing should be 0 based (as in C). If the index is negative, it 
       should translate to the length of the Vector plus the index. Thus, index -1 
       is the last element. If the index is out of range, your implementation should 
       raise an IndexError with an appropriate message."""
    def __getitem__(self,i):
        if type(i) == slice:
            return self.value[i]
        if i >= len(self.value) or i < -len(self.value):
            raise ValueError("IndexError: out of range")
        return self.value[i]

    def __setitem__(self,i,v):
        if type(i) == slice:
            if len(self.value[i]) != len(v):
                raise ValueError("Cannot change length of Vector")
            else:
                self.value[i] = v   
        elif i >= len(self.value) or i < -len(self.value):
            raise ValueError("IndexError: out of range")
        else:
            self.value[i] = v

    """comparison functions for Vectors. Two vectors should be considered equal if 
       each element in the first Vector is equal to the respective element in the 
       second Vector. A Vector, a, should be considered greater than a Vector, b, if 
       the largest element of a is greater than the largest element of b. If the 
       largest elements of both are equal, then compare the second-largest elements, 
       and so forth. If every pair compared in this fashion is equal, then a should not 
       be considered greater than b, but a should be considered greater than or equal to b.
       Note that if a is greater than b, then a is also greater than or equal to b. If a 
       is greater than b, then b is less than a. This is a nonstandard method for comparing
       vectors, and for a pair of vectors v and w, v>=w does not imply that v>w or v==w. When 
       a Vector is compared to something that isn't a Vector, they should never be equal. 
       You can assume that a Vector will never be compared with something that is not a 
       Vector for any comparison operators other than "==", "!=". (i.e. you don't need to 
       handle non-vectors when you implement <, >, <=, >=). You can also assume that vectors 
       will not be compared with a Vector of a different length."""
    def __eq__(self,v):
        if type(v) != Vector:
            return False
        if len(self.value) != len(v):
            return False
        for (e1,e2) in zip(self.value,v):
            if e1 != e2:
                return False
        return True

    def __ne__(self,v):
        return not self.__eq__(v)

    def __gt__(self,v):
        t1 = sorted(self, reverse=True)
        t2 = sorted(v, reverse=True)
        for e1,e2 in zip(t1,t2):
            if e1 > e2:
                return True
        return False

    def __ge__(self,v):
        t1 = sorted(self, reverse=True)
        t2 = sorted(v, reverse=True)
        for e1,e2 in zip(t1,t2):
            if e1 < e2:
                return False
        return True

    def __lt__(self,v):
        if self.__ge__(v):
            return False
        return True

    def __le__(self,v):
        return not self.__gt__(v)




















