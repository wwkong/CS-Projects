# Project Euler Series
# Stochastic Seeker's Solution to Problem #382

import math

def isprime(n):
    n*=1.0
    if n%2==0 and n!=2 or n%3==0 and n!=3:
        return False
    for b in range(1,int((n**0.5+1)/6.0+1)):
        if n%(6*b-1)==0:
            return False
        if n %(6*b+1)==0:
           return False
    return True

def extEuclideanAlg(a, b) :
    if b == 0 :
        return 1,0,a
    else :
        x, y, gcd = extEuclideanAlg(b, a % b)
        return y, x - y * (a // b),gcd

def invmodp(a,m) :
    x,y,gcd = extEuclideanAlg(a,m)
    if gcd == 1 :
        return x % m
    else :
        return None

def myS(p):
    Ans = 1
    for i in range(1,5): Ans *= invmodp(p-i,p)
    return (-9*Ans % p)

def mySum(n):
    Ans,p = 0,5
    while p < n:
        if isprime(p) == True:
            Ans += myS(p)
            p += 2
        else: p +=2
    return Ans
    

print mySum(100)