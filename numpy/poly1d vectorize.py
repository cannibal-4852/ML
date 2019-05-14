>>> from numpy import poly1d
>>> p = poly1d([3,4,5])
>>> print(p)
   2
3 x + 4 x + 5
>>> print(p*p)
   4      3      2
9 x + 24 x + 46 x + 40 x + 25
>>> print(p.integ(k=6))
   3     2
1 x + 2 x + 5 x + 6
>>> print(p.deriv())
6 x + 4
>>> p([4, 5])
array([ 69, 100])


'''
Vectorizing functions
'''
>>> def addsubtract(a,b):
...    if a > b:
...        return a - b
...    else:
...        return a + b

>>> vec_addsubtract = np.vectorize(addsubtract)

>>> vec_addsubtract([0,3,6,9],[1,3,5,7])
array([1, 6, 1, 2])
