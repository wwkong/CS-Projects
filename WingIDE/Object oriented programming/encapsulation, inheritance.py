# Encaptulation, shadowing and inheritance
# By William Kong
# November 25, 2011

# Based on Lecture 16 of the MIT Intro to Comp. Sci. and Prog. Series
# by Prof. Eric Grimson and Jogn Guttag

# Create a person class

class Person(object):
    def __init__(self,family_Name,first_Name):
        self.family_Name = family_Name
        self.first_Name = first_Name
    def familyName(self):
        return self.family_Name
    def firstName(self):
        return self.first_Name
    def __cmp__(self,other):
        return cmp( (self.family_Name,self.first_Name),
                    (other.family_Name,other.first_Name))
    def __str__(self):
        return '<Person: %s %s>' % (self.first_Name,self.family_Name)
    def say(self,toWhom,something):
        return self.first_Name + ' ' + self.family_Name + ' says to ' + toWhom.first_Name + ' ' + toWhom.family_Name + ': ' + something
    def sing(self,toWhom,something):
        return self.say(toWhom,something) + ' trolololol'

# This is an inherited sub-class of Person
    
class UWPerson(Person):
    nextIDNum = 0
    def __init__(self,family_Name,first_Name):
        Person.__init__(self,family_Name,first_Name)
        self.IDNum = UWPerson.nextIDNum
        UWPerson.nextIDNum += 1
    def getIDNum(self):
        return self.IDNum
    def __str__(self):
        return '<UW Person: %s %s>' % (self.first_Name,self.family_Name)
    def __cmp__(self,other):
        return cmp(self.IDNum,other.IDNum)
    
# The following are inherited subclasses of UWPerson
    
class UG(UWPerson):
    def __init__(self,family_Name,first_Name):
        UWPerson.__init__(self,family_Name,first_Name)
        self.year = None
    def setYear(self,year):
        if year > 5 : raise OverflowError('Too many')
        self.year = year
    def getYear(self):
        return self.year
    def say(self,toWhom,something):
        return UWPerson.say(self,toWhom,'Excuse me, but ' + something)

class Prof(UWPerson):
    def __init__(self,family_Name,first_Name,rank):
        UWPerson.__init__(self,family_Name,first_Name)
        self.rank = rank
        self.teaching = {}
    def addTeaching(self,term,subj):
        try: 
            self.teaching[term].append(subj)
        except KeyError:
            self.teaching[term] = [subj]
    def getTeaching(self,term):
        try:
            return self.teaching[term]
        except KeyError:
            return None
    def lecture(self,toWhom,something):
        return UWPerson.say(self,toWhom,something + ' is obvious of course!')
    def say(self,toWhom,something):
        if type(toWhom) == UG:
            return UWPerson.say(self,toWhom,'I do not understand why you say ' + something)
        elif type(toWhom) == Prof:
            return UWPerson.say(self,toWhom,'I really like your paper on ' + something)
        else:
            lecture(self,toWhom,something)

# Next, we create a class that encompasses a collection of professors.
# Note that it inherits from 'object' rather than our previously defined classes
# because it is a collection of objects

class Faculty(object):
    def __init__(self):
        self.names = []
        self.IDs = []
        self.members = []
        self.place = None
    def add(self,who):
        if type(who) != Prof: raise TypeError('Not a professor...yet!')
        if who.getIDNum() in self.IDs: raise ValueError('Duplicate ID!')
        self.names.append(who.familyName())
        self.IDs.append(who.getIDNum())
        self.members.append(who)
    def __iter__(self):
        self.place = 0
    def next(self):
        if self.place >= len(self.names):
            raise StopIteration 
        self.place += 1
        return self.members[self.place - 1]
    

# Here is a list of dummy test instances

JN = Person('Ng','John')
IP = Person('Patel','Ishan')
SS = Person('Shetty','Shashanth')

AR = UG('Rimando','Artemio')
WK = UG('Kong','William')
LF = UG('Fulton','Lawson')

SN = Prof('New','Stephen','P')
ME = Prof('Eden','Michael','P')
MB = Prof('Baker','Michael','AP')

# P = Professor, AP = Associate Professor

math_faculty = Faculty()
math_faculty.add(SN)
math_faculty.add(ME)
math_faculty.add(MB)

print math_faculty.names 
print math_faculty.IDs 

for i in range(0,len(math_faculty.members)):
    print 'Prof #'+ str(i+1) + ' is ' + math_faculty.members[i].__str__()