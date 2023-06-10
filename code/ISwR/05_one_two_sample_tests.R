#---------------------------------
# CH 05- One and two-sample tests  
#---------------------------------

#---------------------------------
# 5.1 One sample t tests  
#---------------------------------
daily.intake <- c(5260,5470,5640,6180,6390,6515,6805,7515,7515,8230,8770)
mean(daily.intake)
sd(daily.intake)
quantile(daily.intake)

# You might wish to investigate whether the women’s energy intake deviates systematically from a 
# recommended value of 7725 kJ. Assuming that data come from a normal distribution, the object is 
# to test whether this distribution might have mean μ = 7725. 

# This is done with t.test as follows:
t.test(daily.intake,mu=7725)

# Our null hypothesis here is ture mean is equal to 7725.
# We get the t statistic, the associated degrees of freedom, and the exact p-value. We do not need 
# to use a table of the t distribution to look up which quantiles the t-value can be found between. 
# You can immediately see that p < 0.05 and thus that (using the customary 5% level of significance) 
# data deviate significantly from the hypothesis that the mean is 7725. A statistically significant test 
# result (p ≤ 0.05) means that the test hypothesis is false or should be rejected. 

# alternative hypothesis: true mean is not equal to 7725
# This contains two important pieces of information: (a) the value we wanted to test whether the mean 
# could be equal to (7725 kJ) and (b) that the test is two-sided (“not equal to”).

# 95 percent confidence interval:
# 5986.348 7520.925

# This is a 95% confidence interval for the true mean; that is, the set of (hypothetical)
# mean values from which the data do not deviate significantly.

# It is based on inverting the t test by solving for the values of μ_0 that cause t to lie within 
# its acceptance region. For a 95% confidence interval, the solution is

# sample estimates: mean of x 6753.636
# This final item is the observed mean; that is, the (point) estimate of the true mean.

# The function t.test has a number of optional arguments, three of which are relevant in one-sample 
# problems. We have already seen the use of mu to specify the mean value μ under the null hypothesis 
# (default is mu=0). In addition, you can specify that a one-sided test is desired against alternatives
# greater than μ by using alternative="greater" or alternatives less than μ using alternative="less". 

# The third item that can be specified is the confidence level used for the confidence intervals; you 
# would write conf.level=0.99 to get a 99% interval.

# Actually, it is often allowable to abbreviate a longish argument specification; for instance, it is 
# sufficient to write alt="g" to get the test against greater alternatives.

#------------------------------------
# 5.2 Wilcoxon signed-rank test
#------------------------------------

