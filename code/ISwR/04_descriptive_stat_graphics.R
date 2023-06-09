# ********************CH 04 - Descriptive statistics and graphics**********
x <- rnorm(50)
mean(x)
sd(x)
var(x)
median(x)
quantile(x)

# It is also possible to obtain other quantiles; this is done by adding an argument
# containing the desired percentage points. This, for example, is how
# to get the deciles:

pvec <- seq(0,1,0.1)
pvec
quantile(x,pvec)

# Attempting to calculate the mean of igf1 reveals a problem.
library(ISwR)
attach(juul)
View(juul)
mean(igf1)

# R will not skip missing values unless explicitly requested to do so. The
# mean of a vector with an unknown value is unknown. However, you can
# give the na.rm argument (not available, remove) to request that missing
# values be removed:

mean(igf1,na.rm=T)

# There is one slightly annoying exception: The length function will not
# understand na.rm, so we cannot use it to count the number of nonmissing
# measurements of igf1. However, you can use
sum(!is.na(igf1))
summary(igf1)

# In fact, it is possible to summarize an entire data frame with
summary(juul)
juul

head(juul)
tail(juul)

# The data set has menarche, sex, and tanner coded as numeric variables
# even though they are clearly categorical. This can be mended as follows:

detach(juul)

juul$sex <- factor(juul$sex,labels=c("M","F"))
juul$sex
juul$menarche <- factor(juul$menarche,labels=c("No","Yes"))
juul$menarche
juul$tanner <- factor(juul$tanner, labels=c("I","II","III","IV","V"))
juul$tanner
attach(juul)
summary(juul)

head(juul)
tail(juul)

# Notice how the display changes for the factor variables. Note also that
# juul was detached and reattached after the modification. This is because
# modifying a data frame does not affect any attached version. It was not
# strictly necessary to do it here because summary works directly on the
# data frame whether attached or not.
# In the above, the variables sex, menarche, and tanner were converted
# to factors with suitable level names (in the raw data these are represented
# using numeric codes). The converted variables were put back into the
# data frame juul, replacing the original sex, tanner, and menarche
# variables.We might also have used the transform function (or within):

juul <- transform(juul,
                  sex=factor(sex,labels=c("M","F")),
                  menarche=factor(menarche,labels=c("No","Yes")),
                  tanner=factor(tanner,labels=c("I","II","III","IV","V")))
juul

# Q-Q plots
# One purpose of calculating the empirical cumulative distribution function
# (c.d.f.) is to see whether data can be assumed normally distributed. For
# a better assessment, you might plot the kth smallest observation against
# the expected value of the kth smallest observation out of n in a standard
# normal distribution. The point is that in this way you would expect to
# obtain a straight line if data come from a normal distribution with any
# mean and standard deviation.

# Creating such a plot is slightly complicated. Fortunately, there is a builtin
# function for doing it, qqnorm. The result of using it can be seen in
# Figure 4.4. You only have to write

x
qqnorm(x)

# Boxplots
# A "boxplot", or more descriptively a "box-and-whiskers plot", is a graphical
# summary of a distribution. Figure 4.5 shows boxplots for IgM and its
# logarithm; see the example on page 23 in Altman (1991).
# Here is how a boxplot is drawn in R. The box in the middle indicates
# "hinges" (nearly quartiles; see the help page for boxplot.stats) and
# median. The lines ("whiskers") show the largest or smallest observation
# that falls within a distance of 1.5 times the box size from the nearest hinge.
# If any observations fall farther away, the additional points are considered
# "extreme" values and are shown separately.
# The practicalities are these:
par(mfrow=c(1,2))
boxplot(IgM)
boxplot(log(IgM))
par(mfrow=c(1,1))

# A layout with two plots side by side is specified using the mfrow graphical
# parameter. It should be read as "multif rame, rowwise, 1 ? 2 layout".
# Individual plots are organized in one row and two columns. As you might
# guess, there is also an mfcol parameter to plot columnwise. In a 2?2 layout,
# the difference is whether plot no. 2 is drawn in the top right or bottom
# left corner.
# Notice that it is necessary to reset the layout parameter to c(1,1) at the
# end unless you also want two plots side by side subsequently.

# Summary statistics by groups
# When dealing with grouped data, you will often want to have various
# summary statistics computed within groups; for example, a table of
# means and standard deviations. To this end, you can use tapply (see Section
# 1.2.15). Here is an example concerning the folate concentration in red
# blood cells according to three types of ventilation during anesthesia (Alt
# man, 1991, p. 208). We return to this example in Section 7.1, which also
# contains the explanation of the category names.

attach(red.cell.folate)
red.cell.folate
tapply(folate,ventilation,mean)

# The tapply call takes the folate variable, splits it according to
# ventilation, and computes the mean for each group. In the same way,
# standard deviations and the number of observations in the groups can be
# computed  

tapply(folate,ventilation,sd)

tapply(folate,ventilation,length)

xbar <- tapply(folate, ventilation, mean)
s <- tapply(folate, ventilation, sd)
n <- tapply(folate, ventilation, length)
cbind(mean=xbar, std.dev=s, n=n)

# For the juul data, we might want the mean igf1 by tanner group, but
# of course we run into the problem of missing values again:

tapply(igf1, tanner, mean)

# We need to get tapply to pass na.rm=T as a parameter to mean to make
# it exclude the missing values. This is achieved simply by passing it as an
# additional argument to tapply.

tapply(igf1, tanner, mean, na.rm=T)

# The functions aggregate and by are variations on the same topic. The
# former is very much like tapply, except that it works on an entire data
# frame and presents its results as a data frame. This is useful for presenting
# many variables at once; e.g.,

aggregate(juul[c("age","igf1")], list(sex=juul$sex), mean, na.rm=T)

# Notice that the grouping argument in this case must be a list, even when
# it is one-dimensional, and that the names of the list elements get used
# as column names in the output. Notice also that since the function is applied
# to all columns of the data frame, you may have to choose a subset of
# columns, in this case the numeric variables.
# The indexing variable is not necessarily part of the data frame that is being
# aggregated, and there is no attempt at "smart evaluation" as there is in
# subset, so you have to spell out juul$sex. You can also use the fact
# that data frames are list-like and say

aggregate(juul[c("age","igf1")], juul["sex"], mean, na.rm=T)

# The by function is again similar, but different. The difference is that the
# function now takes an entire (sub-) data frame as its argument, so that
# you can for instance summarize the Juul data by sex as follows:
by(juul, juul["sex"], summary)

# The result of the call to by is actually a list of objects that has has been
# wrapped as an object of class "by" and printed using a print method for
# that class. You can assign the result to a variable and access the result for
# each subgroup using standard list indexing.

# Histogram
attach(energy)
expend.lean <- expend[stature=="lean"]
expend.obese <- expend[stature=="obese"]

# Notice how we separate the expend vector in the energy data frame into
# two vectors according to the value of the factor stature.
# Now we do the actual plotting:
par(mfrow=c(2,1))
hist(expend.lean,breaks=10,xlim=c(5,13),ylim=c(0,4),col="white")
hist(expend.obese,breaks=10,xlim=c(5,13),ylim=c(0,4),col="grey")
par(mfrow=c(1,1))

# We set par(mfrow=c(2,1)) to get the two histograms in the same plot.
# In the hist commands themselves, we used the breaks argument as
# already mentioned and col, whose effect should be rather obvious. We
# also used xlim and ylim to get the same x and y axes in the two plots.
# However, it is a coincidence that the columns have the same width

# Parllel Boxplot
boxplot(expend)
boxplot(expend ~ stature)

# We could also have based the plot on the separate vectors expend.lean
# and expend.obese. In that case, a syntax is used that specifies the
# vectors as two separate arguments:

boxplot(expend.lean,expend.obese)

# Generating tables
caff.marital <- matrix(c(652,1537,598,242,36,46,38,21,218
                         ,327,106,67),nrow=3,byrow=T)
caff.marital

# Adding row and column names

colnames(caff.marital) <- c("0","1-150","151-300",">300")
rownames(caff.marital) <- c("Married","Prev.married","Single")
caff.marital

# Furthermore, you can name the row and column names as follows. This
# is particularly useful if you are generating many tables with similar
# classification criteria.

names(dimnames(caff.marital)) <- c("marital","consumption")
caff.marital


# Tables are not completely equivalent to matrices. There is a "table" 
# class for which special methods exist, and you can convert to that 
# class using as.table(caff.marital). The table function below returns 
# an object of class "table"

 
# For most elementary purposes, you can use matrices where two-dimensional
# tables are expected. One important casewhere you do need as.table
# is when converting a table to a data frame of counts: 

as.data.frame(as.table(caff.marital))

# The data set juul was introduced on p. 68. Here we look at some other
# variables in that data set, namely sex and menarche; the latter indicates
# whether or not a girl has had her first period.We can generate some simple
# tables as follows:
table(sex)
table(sex,menarche)
table(menarche,tanner)


# Like any matrix, a table can be transposed with the t function:
t(caff.marital)
 
# Marginal tables and relative frequency
# It is often desired to compute marginal tables; that is, the sums of the
# counts along one or the other dimension of a table. Due to missing values,
# this might not coincide with just tabulating a single factor. This is
# done fairly easily using the apply function (Section 1.2.15), but there is
# also a simplified version called margin.table

tanner.sex <- table(tanner,sex)
tanner.sex
