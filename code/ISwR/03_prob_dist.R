#*************** Chap-03-Probability and Distributions*****************

# Random sampling
# In R, you can simulate these situations with the sample function. If you
# want to pick five numbers at random from the set 1:40, then you can write
sample(1:40,5)


sample(40,5) 

# would suffice since a single number is interpreted to represent the length 
# of a sequence of integers

# Notice that the default behaviour of sample is sampling without replacement.
# That is, the samples will not contain the same number twice, and
# size obviously cannot be bigger than the length of the vector to be sampled.
# If you want sampling with replacement, then you need to add the
# argument replace=TRUE.

# Sampling with replacement is suitable for modelling coin tosses or throws
# of a die. So, for instance, to simulate 10 coin tosses we could write
sample(c("H","T"), 10, replace=T)

# You can simulate data with non-equal probabilities for the
# outcomes (say, a 90% chance of success) by using the prob argument to
# sample, as in
sample(c("succ", "fail"), 10, replace=T, prob=c(0.9, 0.1))

# Probability calculations and combinations
# Let us return to the case of sampling without replacement, specifically
# sample(1:40, 5). The probability of obtaining a given number as the
# first one of the sample should be 1/40, the next one 1/39, and so forth. The
# probability of a given sample should then be 1/(40 ? 39 ? 38 ? 37 ? 36).
# In R, use the prod function, which calculates the product of a vector of
# numbers

1/prod(40:36)

# Density Functions
x <- seq(-3,3,0.1)
x
plot(x,dnorm(x),type="l")

# An alternative way of creating the plot is to use curve as follows:
curve(dnorm(x), from=-3, to=3)

# This is often a more convenient way of making graphs, but it does require
# that the y-values can be expressed as a simple functional expression in x.
# For discrete distributions, where variables can take on only distinct values,
# it is preferable to draw a pin diagram, here for the binomial distribution
# with n = 50 and p = 0.33 (Figure 3.2):
x <- 0:50
x
plot(x,dbinom(x,size=50,prob=.33),type="h")

# 3.5.2 Cumulative distribution functions
# The cumulative distribution function describes the probability of "hitting"
# x or less in a given distribution. The corresponding R functions begin with
# a 'p' (for probability) by convention.
# Just as you can plot densities, you can of course also plot cumulative distribution
# functions, but that is usually not very informative. More often,
# actual numbers are desired. Say that it is known that some biochemical
# measure in healthy individuals is well described by a normal distribution
# with a mean of 132 and a standard deviation of 13. Then, if a patient has a
# value of 160, there is
1-pnorm(160,mean=132,sd=13)

# or only about 1.5% of the general population, that has that value or higher.
# The function pnorm returns the probability of getting a value smaller
# than its first argument in a normal distribution with the given mean and
# standard deviation.

# Another typical application occurs in connection with statistical tests.
# Consider a simple sign test: Twenty patients are given two treatments each
# (blindly and in randomized order) and then asked whether treatment A or
# B worked better. It turned out that 16 patients liked A better. The question
# is then whether this can be taken as sufficient evidence that A actually is
# the better treatment or whether the outcome might as well have happened
# by chance even if the treatments were equally good. If there was no difference
# between the two treatments, then we would expect the number of
# people favouring treatment A to be binomially distributed with p = 0.5
# and n = 20. How (im)probable would it then be to obtain what we have
# observed? As in the normal distribution, we need a tail probability, and
# the immediate guess might be to look at

pbinom(16,size=20,prob=.5)

# and subtract it from 1 to get the upper tail - but this would be an error!
# What we need is the probability of the observed or more extreme, and pbinom
# is giving the probability of 16 or less. We need to use "15 or less" instead.

1-pbinom(15,size=20,prob=.5)

# If you want a two-tailed test because you have no prior idea about which
# treatment is better, then you will have to add the probability of obtaining
# equally extreme results in the opposite direction. In the present case, that
# means the probability that four or fewer people prefer A, giving a total
# probability of

1-pbinom(15,20,.5)+pbinom(4,20,.5)

# (which is obviously exactly twice the one-tailed probability).
# As can be seen from the last command, it is not strictly necessary to use
# the size and prob keywords as long as the arguments are given in the
# right order (positional matching; see Section 1.2.2).

# Quantiles
# The quantile function is the inverse of the cumulative distribution function.
# The p-quantile is the value with the property that there is probability
# p of getting a value less than or equal to it. The median is by definition the
# 50% quantile.

# We can compute the relevant quantities as ("sem" means standard error of the mean)

xbar <- 83
sigma <- 12
n <- 5
sem <- sigma/sqrt(n)
sem
xbar + sem * qnorm(0.025)
xbar + sem * qnorm(0.975)

# and thus find a 95% confidence interval for ?? going from 72.48 to 93.52.

# Random numbers
# To many people, it sounds like a contradiction in terms to generate
# random numbers on a computer since its results are supposed to be predictable
# and reproducible. What is in fact possible is to generate sequences
# of "pseudo-random" numbers, which for practical purposes behave as if
# they were drawn randomly.
























