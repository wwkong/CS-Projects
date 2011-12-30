# Random Walk Simulation
# By William Kong
# November 27, 2011

# Based on Lectures 17 to 19 of the MIT Intro to Comp. Sci. and Prog. Series
# by Prof. Eric Grimson and Jogn Guttag

# Here, I will be creating a 2-dimensional random walk simulator, starting with a basic 
# stochastic model with a unifrom distribution and move towards various other distributions

# SIMULATOR --------------------------------------------------------------------

import math, pylab, random
from random_walk_classes import *

# Here is where I define the functions that run the simulator:

# --- performTrial ---
# PURPOSE: Run a single trial involving a single drunk on a plane
# FUNCTION: Nat + Field -> (listof Float)

def performTrial(time, f):
    start = f.getLoc()
    distances = [0.0]
    for t in range(1, time + 1):
        f.getDrunk().move(f)
        newLoc =  f.getLoc()
        distance = newLoc.getDist(start)
        distances.append(distance)
    return distances

# The following function is similar to performSim, except it will be used in 
# the analysis of the data in random_walk_plot:


# --- performSim ---
# PURPOSE: calls performTrial some number of times and a list of lists of data
#          pertaining to each drunk
# FUNCTION: Nat + Nat -> (listof (listof float))

def performSim(time, numTrials):
    distList = []
    for trial in range(numTrials):
        d = Drunk('Drunk' + str(trial))
        f = Field(d, Location(0,0))
        distances = performTrial(time, f)
        distList.append(distances)
    return distList