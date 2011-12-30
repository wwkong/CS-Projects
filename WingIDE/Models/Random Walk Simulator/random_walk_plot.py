# By William Kong
# November 27, 2011

# Based on Lectures 17 to 19 of the MIT Intro to Comp. Sci. and Prog. Series
# by Prof. Eric Grimson and Jogn Guttag

# Here, I will be creating a 2-dimensional random walk simulator, starting with a basic 
# stochastic model with a unifrom distribution and move towards various other distributions

# PLOT -------------------------------------------------------------------------

# Here is where I excute pylab functions to aggregate and plot the results;
# initial conditions are also specified here

# First, import the necessary libraries:

import math, pylab, random
from random_walk_classes import *
from random_walk_simulator import *

# --- plotTrial ---
# PURPOSE: plots a graph representing how distance from origin changes 
#          over time on n trials which span a set time
# FUNCTION: Nat + Nat -> (Void)

def plotTrial(n, time):
    drunk = Drunk('UW Drunk')
    for i in range(n):
        f = Field(drunk, Location(0,0))
        distances = performTrial(time,f)
        pylab.plot(distances)
        
        # Label axes and title
        pylab.title('William\'s Random Walk Simulator') 
        pylab.xlabel('Time')
        pylab.ylabel('Distance from Origin')
        
    # Display the plot        
    pylab.show() 
    
# --- plotSim ---
# PURPOSE: aggregates the data and plots the average distance of n trials 
#          over a set time; specifically, it 
# FUNCTION: Nat + Nat -> (Void)

def plotSim(maxTime, numTrials):
    means = []
    distLists = performSim(maxTime, numTrials)
    
    for t in range(maxTime + 1):
        tot = 0.0
        for distL in distLists:
            tot += distL[t]
        means.append(tot/len(distLists))
        
    pylab.figure()
    pylab.plot(means)
    pylab.ylabel('Distance')
    pylab.xlabel('Time')
    pylab.title('Average distance vs. time (' + str(len(distLists)) + ' trials)')
    pylab.show()
    print means[maxTime] # Exit the .svg to show the simulated expected distance

# Run a single plot of n trials over some specified time as a test:
# plotTrial(3, 500)

# Run the simulation on specified parameters:
plotSim(500,200)