#Exercise #5

#Practice the following skills:
  # reshape data frame (melt/dcast from reshape2 function)
  # if_else statements

#Part 1: version control --------------------------------------------
# Please track changes to your script using version control. Include in your homework the URL to your completed homework assignment available on your
#GitHub repository

##https://github.com/annacalvertjackson/e5_HW.git

##I was only to make 2 commits...for some reason I couldn't "push" changes

#Part 2: reshaping data frames ---------------------------------------------

#Using the 'batting.2008.Rdata' dataset, please do the following

setwd("C:/Users/annac/Desktop/Grad School/Classes/Fall2021_Classes/Intro to R/Homework")

getwd()

list.files(recursive=T)

load("batting.2008.Rdata")

library(tidyverse)

#1) Using the spread() function, please create a data frame that shows 
  #the total number of home runs (HR) for each birthYear for
  #each team (use the teamID column) 

#Step 1: group_by and summarise()

t<- d %>% group_by(birthYear, teamID) %>% summarise(total.HR=sum(HR))

t

#Step 2: spread() to go from long to wide

##key is the column you split to multiple columns


tw<-spread(data= t, key=teamID, value=total.HR)

tw

##younger players hitting more home runs

#2) Subset the data for the Houston Astros (HOU). Using the gather() function, create a new data frame that has 3 columns:
  # (1) playerID, (2) variable containing (AB, R, H, 2B, 3B) and (3) column with the corresponding values for the stats.

##wide to long?

astros<-subset(d, teamID=="HOU")

astros2<-select(.data=astros, "AB", "R", "2B", "3B")
  
astros_gather<-gather(astros2, key=stats, value=values) 

astros_new<-cbind(astros$playerID, astros_gather)


#3) Repeat the process for Question 2. However, this time, please use the melt() function from the 'reshape2' package.

library(reshape2)

##melt goes wide to long

astros3<-select(.data=astros, "playerID", "AB", "R", "2B", "3B")

astros_melt<-melt(data=astros3, id.vars= "playerID", measure.vars= c("AB", "R", "2B", "3B"))


#4) Using the dcast() function from the 'reshape2 package', find the mean number of AB, R, H, 2B, 3B for each player (use 'playerID' to aggregate).

players_mean<-dcast(astros_melt, formula=playerID~variable, fun.aggregate=mean) ##doesn't seem to have calculated means...

#Part 3: if_else statements -------------------------------

# one condition
#5) generate an if_else statement to test if the value of a numeric object is positive number

kitten<-3

typeof(kitten)

if(kitten >0) {
  print("is positive")
} else {
    print("is negative")
  }
  

##or

if_else(condition=kitten>0, true="is positive", false="is negative")




#6) using the two objects below, please generate an if_else statement that uses logical operator (i.e, !=, ==, >, etc.)
  # in the test

    x <- 5
    y <- 8
    
    if(x != y) {
      print("not equal")
    } else {
      print("equal")
    }
    
##OR
    
if_else(condition= x != y, true="not equal", false="equal")
    
    
#7) Hamlet's quandry: In Shakespeare's play Hamlet, the lead character has a famous speech "to be or not to be".
browseURL("https://www.poetryfoundation.org/poems/56965/speech-to-be-or-not-to-be-that-is-the-question")
# Write an if_else statement using the "to be' or 'not to be' for outcomes of the 'yes' and 'no' arguments respectively.


hamlet<-"yes"
quandry<-"no"

if(hamlet=="yes" | quandry=="no") {
  print("To be")
} else {
  print("Not to be")
}



#two or more conditions
#8) create an 'if else' statement that returns (in order of preference) your four ideal pizza toppings

turtle<-4

hare<-3

if(turtle>hare) {
  print("Mushrooms, Pepperonis, Anchovies, Spinach")
} else {
  print("Too Bad")
}


#two or more conditions joined (new content)
#To join two or more conditions into a single if statement, use logical operators viz. && (and), || (or) and ! (not).

  #example:
  x <- 7
  y <- 5
  z <- 2
  if(x > y && x > z) {
    print("x is greater")
  }

#9) generate your own 'if' statement using multiple conditions in one line

  if(z < y && y < x) {
    print("You did it!")
  }


#New content: understanding a common warning/error message when using if_else.
# The follow set of code will generate a warning message. Explain in a comment what the warning is telling you.
  v <- 1:6

  if(v %% 2) {
    print("odd")
  } else {
    print("even")
  }

  ##simple "if" functions only work on one element at a time and v is a vector?
  ##you would need to use ifelse()?

  
  ##change