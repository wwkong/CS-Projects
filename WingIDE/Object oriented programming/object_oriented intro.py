# Intro to object oriented programming
# By William Kong
# November 25, 2011

# Based on Lecture 14 of the MIT Intro to Comp. Sci. and Prog. Series
# by Prof. Eric Grimson and Jogn Guttag

import math 

# Initialize some test classes
# For an easy example, we'll take a look at points on the Euclidean plane

class cartesian_form:
    def __init__(self,x,y):
        self.x = x
        self.y = y

class polar_form:
    pass
        
class cpoint:
    def __init__(self,x,y):
        self.x = x
        self.y = y
        self.radius = math.sqrt(self.x*self.x + self.y*self.y)
        self.angle = math.atan2(self.y,self.x)
    def cartesian(self):
        return (self.x,self.y)
    def polar(self):
        return (self.radius,self.angle)
    def __str__(self):
        return '('+str(self.x)+','+str(self.y)+')'
    def __cmp__(self,other):
        return (self.x > other.x) and (self.y > other.y)
    
class ppoint:
    def __init__(self,r,a):
        self.radius = r
        self.angle = a
        self.x = r * math.cos(a)
        self.y = r * math.sin(a)
    def cartesian(self):
        return (self.x,self.y)
    def polar(self):
        return (self.radius,self.angle)
    def __str__(self):
        return '('+str(self.x)+','+str(self.y)+')'
    def __cmp__(self,other):
        return (self.x > other.x) and (self.y > other.y)

class segment:
    def __init__(self,start,end):
        self.start = start
        self.end = end
        self. length = math.sqrt( ((self.start.x - self.end.x) * (self.start.x - self.end.x))
                                + ((self.start.y - self.end.y) * (self.start.y - self.end.y)))
