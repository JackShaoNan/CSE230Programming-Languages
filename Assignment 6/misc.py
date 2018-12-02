import re

"Miscellaneous functions to practice Python"

class Failure(Exception):
    """Failure exception"""
    def __init__(self,value):
        self.value=value
    def __str__(self):
        return repr(self.value)

# Problem 1

# data type functions

def closest_to(l,v):
    """Return the element of the list l closest in value to v.  In the case of
       a tie, the first such element is returned.  If l is empty, None is returned."""
    
    # check the corner case first
    if l == []:
        return None
    # go through the list and find the closet one 
    else:
        res = l[0]
        for e in l:
            if abs(e-v) < abs(res-v):
                res = e
        return res 
    

def make_dict(keys,values):
    """Return a dictionary pairing corresponding keys to values."""

    # check the corner case, if input is wrong, just return None
    if len(keys) != len(values):
        return None
    # just zip two list and insert them into dict
    else:
        res = {}
        for (k,v) in zip(keys,values):
            res[k] = v
        return res
   
# file IO functions
def word_count(fn):
    """Open the file fn and return a dictionary mapping words to the number
       of times they occur in the file.  A word is defined as a sequence of
       alphanumeric characters and _.  All spaces and punctuation are ignored.
       Words are returned in lower case"""
    res = {}
    with open(fn,'r') as f:
        for l in f.readlines():
            for word in re.split('\W+', l):
                if word == '':
                    continue
                word = word.lower()
                if word in res:
                    res[word] += 1
                else:
                    res[word] = 1
        return res







