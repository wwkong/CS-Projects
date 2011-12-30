# Greedy Algorithm 
# By William Kong
# November 24, 2011

# Based on Lecture 12 of the MIT Intro to Comp. Sci. and Prog. Series
# by Prof. Eric Grimson and Jogn Guttag

#------------------------------------------------------------------------------

# Suppose you break into a house and there are 4 lbs of gold dust, 
# 3 lbs of silver dust, and 10 lbs of raisins and a knapsack that holds 8 lbs.
# Items can be put in the knapsack continously

# We want to optimize the following:
# cost_gold*pound_gold + cost_silver*pound_silver + cost_raisins*pound_raisins

# Constraints:
# pound_gold + pound_silver + pound_raisins <= 9

# The greedy algorithm works perfectly here

#------------------------------------------------------------------------------

# Now we investigate a variant called the 0/1 Knapsack problem.

# Suppose we have n items in the house that you have broken into.
# You can only take a whole item or no item at all.

# Here I will code an optimization algorithm of the problem

#------------------------------------------------------------------------------

# First, define my custom parameters here; will be used to 
# test second call of MaxVal

myweights = [1,5,3,4]
myvalues = [15,10,9,5]
mymweight = 8
myindex = len(myweights)-1

# Use I/O to get user's vals

print 'Submit a list of the weights of the items to steal'
in_weights = raw_input()
weights = map(int, in_weights.split(','))
print 'Submit the corresponding values of the items'
in_values = raw_input()
values = map(int, in_values.split(','))
print 'Submit the maximum weight that your stealing knapsack can hold'
max_weight = int(raw_input())
index = len(weights)-1

# Definitions begin here

def MaxVal(w,v,i,aW):
    if i == 0:
        if w[i] <= aW: return v[i]
        else: return 0
    without_i = MaxVal(w,v,i-1,aW)
    if w[i] > aW: 
        return without_i
    else: 
        with_i = v[i] + MaxVal(w,v,i-1,aW-w[i])
    return max(with_i,without_i)

def fastMaxVal(w,v,i,aW,m):
    try: return m[(i,aW)]
    except KeyError:
        if i == 0:
            if w[i] <= aW: 
                m[(i,aW)] = v[i]
                return v[i]
            else: 
                m[(i,aW)] = 0
                return 0
        without_i = fastMaxVal(w,v,i-1,aW,m)
        if w[i] > aW: 
            m[(i,aW)] = without_i
            return without_i
        else: 
            with_i = v[i] + fastMaxVal(w,v,i-1,aW-w[i],m)
        rest = max(with_i,without_i)
        m[(i,aW)] = rest
        return rest

def newMaxVal(w,v,i,aW):
    m = {}
    return fastMaxVal(w,v,i,aW,m)


print 'The maximum total value of stuff that you can steal is $',newMaxVal(weights,values,index,max_weight)
print '\nIn my heist, I can steal $',newMaxVal(myweights,myvalues,myindex,mymweight)