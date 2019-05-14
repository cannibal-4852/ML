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
