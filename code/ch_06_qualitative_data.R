#-----------------
# CH 06 Qualitative Data
#-----------------
library(MASS)   # load the MASS package 
head(painters)

# The last School column contains the information of school classification of the painters. The schools are 
# named as A, B, ..., etc, and the School variable is qualitative.
painters$School

# Frequency Distribution
#--------------------------

# The frequency distribution of a data variable is a summary of the data occurrence in a collection of 
# non-overlapping categories.

# Example
# In the data set painters, the frequency distribution of the School variable is a summary of the number 
# of painters in each school.

# Example: Find the frequency distribution of the painter schools in the data set painters.
# Solution: We apply the table function to compute the frequency distribution of the School variable.
school <- painters$School
school
(school.freq  <-  table(school))

# We apply the cbind function to print the result in column format.
cbind(school.freq)

# Relative Frequency Distribution of Qualitative Data
#------------------------------------------------------
# The relative frequency distribution of a data variable is a summary of the frequency proportion in a 
# collection of non-overlapping categories.

# In the data set painters, the relative frequency distribution of the School variable is a summary of the proportion 
# of painters in each school.

# Problem: Find the relative frequency distribution of the painter schools in the data set painters.
# Solution: # We first apply the table function to compute the frequency distribution of the School variable.

school = painters$School      # the painter schools 
school.freq = table(school)   # apply the table function

# Then we find the sample size of painters with the nrow function, and divide the frequency distribution with it. 
# Therefore the relative frequency distribution is:

(school.relfreq = school.freq / nrow(painters))

# options(digits=1), is used in R programming language to set the number of decimal places displayed when printing 
# numeric values. By setting digits to 1, you are instructing R to display only one decimal place for numeric values.
options(digits=1) 
cbind(school.relfreq) 

options(digits=7)    # restore the old option
# Please note that changing the digits option using options(digits=1) affects the display of numeric values globally 
# in the R session. If you want to reset it to the default behavior, you can use options(digits=7) or any other 
# desired number of decimal places.

# Bar Graph
#--------------
# A bar graph of a qualitative data sample consists of vertical parallel bars that shows the frequency distribution 
# graphically.

# Example: In the data set painters, the bar graph of the School variable is a collection of vertical bars 
# showing the number of painters in each school.

# Problem: Find the bar graph of the painter schools in the data set painters.
# Solution: 
barplot(school.freq)         # apply the barplot function

# To colorize the bar graph, we select a color palette and set it in the col argument of barplot.
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(school.freq, col=colors)


# Ex 1
comp = painters$Composition
comp.freq = table(comp)

comp.freq

cbind(comp.freq)

# Ex 2
school = painters$School
school.freq = table(school)
school.freq.max = max(school.freq)
school.freq.max

L = school.freq == school.freq.max
x = school.freq[L]

x = which(school.freq == school.freq.max)
names(x)

y = which.max(school.freq)
names(y)


################################
# c06-s02
school = painters$School
school.freq = table(school)
school.relfreq = school.freq / nrow(painters)

old = options(digits=1)
school.relfreq
options(old)

old = options(digits=3)
cbind(school.relfreq*100)
options(old)

# Ex
comp = painters$Composition
comp.freq = table(comp)
comp.relfreq = comp.freq / nrow(painters)

old = options(digits=1)
comp.relfreq
options(old)

old = options(digits=3)
cbind(comp.relfreq*100)
options(old)


################################
# c06-s03
school = painters$School
school.freq = table(school)
barplot(school.freq) 

colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(school.freq, col=colors)

# Ex
comp = painters$Composition
comp.freq = table(comp)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(comp.freq, col=colors)


################################
# c06-s04
school = painters$School
school.freq = table(school)
pie(school.freq) 

colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(school.freq, col=colors)

# Ex
comp = painters$Composition
comp.freq = table(comp)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(comp.freq, col=colors)


################################
# c06-s05
school = painters$School
c_school = school == "C"
c_painters = painters[c_school, ]
mean(c_painters$Composition)

tapply(painters$Composition, painters$School, mean)

# Ex 1
comp = painters$Composition
school = painters$School

comp.school.max = tapply(comp, school, max)
comp.school.max

comp.max.all = max(comp)
comp.max.all

x = which(comp.school.max == comp.max.all)
names(x)

# Ex 2
colour = painters$Colour
x = which(colour >= 14)
length(x)/nrow(painters)



################################
# figures

# categorical-data1x
png(file="categorical-data1x.png", width=450, height=450)
barplot(table(painters$School))
dev.off()

# categorical-data1xz
png(file="categorical-data1xz.png", width=450, height=450)
barplot(table(painters$Composition))
dev.off()

# categorical-data2x
png(file="categorical-data2x.png", width=450, height=450)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(table(painters$School), col=colors)
dev.off()

# categorical-data3x
png(file="categorical-data3x.png", width=450, height=450)
pie(table(painters$School))
dev.off()

# categorical-data3xz
png(file="categorical-data3xz.png", width=450, height=450)
pie(table(painters$Composition))
dev.off()

# categorical-data4x
png(file="categorical-data4x.png", width=450, height=450)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(table(painters$School), col=colors)
dev.off()




