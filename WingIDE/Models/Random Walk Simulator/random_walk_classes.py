# Random Walk Simulation
# By William Kong
# November 26, 2011

# Based on Lectures 17 to 19 of the MIT Intro to Comp. Sci. and Prog. Series
# by Prof. Eric Grimson and Jogn Guttag

# Here, I will be creating a 2-dimensional random walk simulator, starting with a basic 
# stochastic model with a unifrom distribution and move towards various other distributions

# CLASSES ----------------------------------------------------------------------

import math, pylab, random

# Here, we define a couple classes:

# --- Location ---
# DESCRIPTION: represents a location on the co-ordinate plane
# FIELDS: Nat(x), Nat(y)

class Location(object):
    def __init__(self,x,y):
        self.x = float(x)
        self.y = float(y)
    def move(self, xc, yc):
        return Location(self.x+float(xc), self.y+float(yc))
    def getCoords(self):
        return self.x, self.y
    def getDist(self, other):
        ox, oy = other.getCoords()
        xDist = self.x - ox
        yDist = self.y -oy
        return math.sqrt(xDist**2 + yDist**2)
    

# --- CompassPt ---
# DESCRIPTION: This class will detail how an object will move across the plane 
#              using the four cardinal directions, N, W, E, W
# FIELDS: Location(pt)

class CompassPt(object):
    possibles = ('N', 'S', 'E', 'W')
    def __init__(self,pt):
        if pt in self.possibles: self.pt = pt
        else: raise ValueError('in CompassPt.__init__')
    def move(self, dist):
        if self.pt == 'N': return (0, dist)
        elif self.pt == 'S': return (0, -dist)
        elif self.pt == 'E': return (dist, 0)
        elif self.pt == 'W': return (-dist, 0)
        else: raise ValueError('in CompassPt.move')
        

# --- Field ---
# DESCRIPTION: Describes the location of a drunk on the plane
# FIELDS: Drunk(drunk), Location(loc)
        
class Field(object):
    def __init__(self, drunk, loc):
        self.drunk = drunk
        self.loc = loc
    def move(self, cp, dist):
        oldLoc = self.loc
        xc, yc = cp.move(dist)
        self.loc = oldLoc.move(xc, yc)
    def getLoc(self):
        return self.loc
    def getDrunk(self):
        return self.drunk
    
# --- Drunk ---
# DESCRIPTION: Creates attributes for the drunk (or person) moving on the plane
# FIELDS: Str(name)

class Drunk(object):
    def __init__(self, name):
        self.name = name
    def move(self, field, time = 1):
        if field.getDrunk() != self:
            raise ValueError('Drunk.move called with drunk not in field')
        for i in range(time):
            pt = CompassPt(random.choice(CompassPt.possibles))
            field.move(pt, 1)