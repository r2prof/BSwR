# ********************The R-environment************

# You can use the function ls (list).It should look as follows if you have
# run all the examples in the preceding chapter

ls()

# If at some point things begin to look messy, you can delete some of the
# objects. This is done using rm (remove), so that

rm(height, weight)

# deletes the variables height and weight.

# The entire workspace can be cleared using 

rm(list=ls())


# Built-in data
# Many packages, both inside and outside the standard R distribution, come
# with built-in data sets. Such data sets can be rather large, so it is not a
# good idea to keep them all in computer memory at all times. A mechanism
# for on-demand loading is required. In many packages, this works
# via a mechanism called lazy loading, which allows the system to "pretend"
# that the data are in memory, but in fact they are not loaded until they are
# referenced for the first time.

# With this mechanism, data are "just there". For example, if you type "thuesen",
# the data frame of that name is displayed. Some packages still require
# explicit calls to the data function. Most often, this loads a data frame with
# the name that its argument specifies; data(thuesen) will, for instance,
# load the thuesen data frame.

# Attach and detach
# The notation for accessing variables in data frames gets rather heavy if
# you repeatedly have to write longish commands like

library(ISwR)
plot(thuesen$blood.glucose,thuesen$short.velocity)

# Fortunately, you can make R look for objects among the variables in a
# given data frame, for example thuesen. You write

attach(thuesen)

# and then thuesen's data are available without the clumsy $-notation:

blood.glucose
short.velocity

# What happens is that the data frame thuesen is placed in the system's
# search path. You can view the search path with search:

search()

# Subset, transform, and within
# You can attach a data frame to avoid the cumbersome indexing of every
# variable inside of it. However, this is less helpful for selecting subsets of
# data and for creating new data frames with transformed variables. A couple
# of functions exist to make these operations easier. They are used as
# follows:

thue2 <- subset(thuesen,blood.glucose < 7)
thue2

thue3 <- transform(thuesen,log.gluc=log(blood.glucose))
thue3

# Notice that the variables used in the expressions for new variables or for
# subsetting are evaluated with variables taken from the data frame.
# subset also works on single vectors. This is nearly the same as indexing
# with a logical vector (such as short.velocity[blood.glucose<7]),
# except that observations with missing values in the selection criterion are
# excluded.

short.velocity[blood.glucose < 7]

# The transform function has a couple of drawbacks, the most serious of
# which is probably that it does not allow chained calculations where some
# of the new variables depend on the others

# The graphics subsystem
# In the graphics model that R uses, there is (for a single plot) a figure region
# containing a central plotting region surrounded by margins. Coordinates
# inside the plotting region are specified in data units (the kind generally
# used to label the axes). Coordinates in the margins are specified in lines
# of text as you move in a direction perpendicular to a side of the plotting
# region but in data units as you move along the side. This is useful since
# you generally want to put text in the margins of a plot.

# A standard x-y plot has an x and a y title label generated from the expressions
# being plotted. You may, however, override these labels and also
# add two further titles, a main title above the plot and a subtitle 
# at the very bottom, in the plot call.

x <- runif(50,0,2)
x
y <- runif(50,0,2)
y

plot(x, y, main = "Main title", sub = "subtitle", xlab = "x-lable", ylab = "y-label")

# Inside the plotting region, you can place points and lines that are either
# specified in the plot call or added later with points and lines. You
# can also place a text with

text(0.6,0.6,"text at (0.6,0.6)")
abline(h=.6,v=.6)
 
# The margin coordinates are used by the mtext function. They can be
# demonstrated as follows:

for (side in 1:4) mtext(-1:4,side=side,at=.7,line=-1:4)
mtext(paste("side",1:4), side=1:4, line=-1,font=2)


# Building a plot from pieces
# High-level plots are composed of elements, each of which can also be
# drawn separately. The separate drawing commands often allow finer control
# of the element, so a standard strategy to achieve a given effect is first
# to draw the plot without that element and add the element subsequently.
# As an extreme case, the following command will plot absolutely nothing:

plot(x, y, type="n", xlab="", ylab="", axes=F)

# Here type="n" causes the points not to be drawn. axes=F suppresses
# the axes and the box around the plot, and the x and y title labels are set to
# empty strings.

# However, the fact that nothing is plotted does not mean that nothing happened.
# The command sets up the plotting region and coordinate systems
# just as if it had actually plotted the data. To add the plot elements, evaluate
# the following:

points(x,y)
axis(1)
axis(2,at=seq(0.2,1.8,0.2))
box()
title(main="Main title", sub="subtitle",xlab="x-label", ylab="y-label")

# Plotting with type="n" is sometimes a useful technique because it has
# the side effect of dimensioning the plot area. For instance, to create a plot
# with different colours for different groups, you could first plot all data
# with type="n", ensuring that the plot region is large enough, and then
# add the points for each group using points. (Passing a vector argument
# for col is more expedient in this particular case.)


# Using par
# The par function allows incredibly fine control over the details of a plot,
# although it can be quite confusing to the beginner (and even to experienced
# users at times). The best strategy for learning it may well be simply
# to try and pick up a few useful tricks at a time and once in a while try to
# solve a particular problem by poring over the help page.


# Combining plots
# Some special considerations arise when you wish to put several elements
# together in the same plot. Consider overlaying a histogram with a normal
# density (see Sections 4.2 and 4.4.1 for information on histograms and Section
# 3.5.1 for density). The following is close, but only nearly good enough
# (figure not shown).

x <- rnorm(100)

# Density on y-axis
hist(x,freq=F)

# Frequency on x-axis
hist(x,freq=T)

hist(x)

# Density on y-axis
hist(x,freq=F)

# Curve on histogram works with density on y-axis
curve(dnorm(x),add=T)


# The freq=F argument to hist ensures that the histogram is in terms of
# densities rather than absolute counts. The curve function graphs an expression
# (in terms of x) and its add=T allows it to overplot an existing
# plot. So things are generally set up correctly, but sometimes the top of the
# density function gets chopped off. The reason is of course that the height
# of the normal density played no role in the setting of the y-axis for the histogram.
# It will not help to reverse the order and draw the curve first and
# add the histogram because then the highest bars might get clipped.
# The solution is first to get hold of the magnitude of the y values for both
# plot elements and make the plot big enough to hold both (Figure 2.2):

hist(x, plot=F)
h <- hist(x, plot=F)
h
ylim <- range(0, h$density, dnorm(0))
hist(x, freq=F, ylim=ylim)
curve(dnorm(x), add=T)


# When called with plot=F, hist will not plot anything, but it will return
# a structure containing the bar heights on the density scale. This and
# the fact that the maximum of dnorm(x) is dnorm(0) allows us to calculate
# a range covering both the bars and the normal density. The zero in
# the range call ensures that the bottom of the bars will be in range, too.
# The range of y values is then passed to the hist function via the ylim
# argument.

# Data entry

# Reading from a text file
# The most convenient way of reading data into R is via the function called
# read.table. It requires that data be in "ASCII format"; that is, a "flat
# file" as created withWindows' NotePad or any plain-text editor. The result
# of read.table is a data frame, and it expects to find data in a corresponding
# layout where each line in the file contains all data from one
# subject (or rat or . . . ) in a specific order, separated by blanks or, optionally,
# some other separator. The first line of the file can contain a header
# giving the names of the variables, a practice that is highly recommended.

# Note: this will not work. Just for the sake of information

thuesen2 <- read.table("D:/ISwR/thuesen.txt",header=T)

# Read.table Function

# The read.table function autodetects whether a vector is text or
# numeric and converts it to a factorin the former case (but makes
# no attempt to recognize numerically coded factors).
# This file can be read directly by read.table with no arguments other
# than the filename

system.file("rawdata", "thuesen.txt", package="ISwR")

# The data editor
# R lets you edit data frames using a spreadsheet-like interface. The
# interface is a bit rough but quite useful for small data sets.
# To edit a data frame, you can use the edit function:

aq <- edit(airquality)


# When you close the data editor, the edited data frame is assigned to aq.
# The original airquality is left intact. Alternatively, if you do not mind
# overwriting the original data frame, you can use

fix(aq)

dd <- data.frame()
fix(dd)


# Interfacing to other programs

# Sometimes you will want to move data between R and other statistical
# packages or spreadsheets. A simple fallback approach is to request that
# the package in question export data as a text file of some sort and use
# read.table, read.csv, read.csv2, read.delim, or read.delim2,
# as previously described.
# The foreign package is one of the packages labelled "recommended"
# and should therefore be available with binary distributions of R. It
# contains routines to read files in several formats, including those from
# SPSS (.sav format), SAS (export libraries), Epi-Info (.rec), Stata, Systat,
# Minitab, and some S-PLUS version 3 dump files.

# An expedient technique is to read from the system clipboard. Say, highlight
# a rectangular region in a spreadsheet, press Ctrl-C (if on Windows),
# and inside R use

read.table("clipboard", header=T)







