# One sample t-test

# Prerequisites
* Know differences between t-tests
* Formulate statistical hypotheses in terms of population parameters
* Formulate statistical hypotheses for either one-sided or two-sided scenarios
* Calulate standard error of the mean
* Calculate one sample t-statistic
* Calculate P-value using R for either one-sided or two-sided scenarios  
  * Use argument `lower.tail` correctly in `pt` function
* Compare P-value to significance level
* Draw (one-sided) conclusion for (significant two-sided) t-test

# Objective
* Peform one sample t-test

# Order
1. one_sample_t_test  
  1.1. one_sample_t_test_intro  
  1.2. one_sample_t_test_H  
  1.3. one_sample_t_test_SE  
  1.4. one_sample_t_test_t  
  1.5. one_sample_t_test_P  
  1.6. one_sample_t_test_comp  
  1.7. one_sample_t_test_con
  
# Variables
Alias | Definition | Decimals | Author comments
--- | --- | --- | ---
`$ss` | `rand(30, 50)` | 0 | sample size is a random integer between 30 and 50
`$mu` | `sw_distrib("random_continuous_uniform(80, 120)")` | 1 | population mean is random float between 80 and 120
`$sigma` | `sw_distrib("random_continuous_uniform(10, 50)")`| 1 | population standard deviation is random float between 10 and 50
`$ryi` | `sw_distrib("random_normal($mu, $sigma, $ss)")` | 1 | random sample from normally distributed population
`$mean` | `round(sw_descriptive("mean($ryi)"), 1)` | 1 | sample mean rounded to 1 decimal
`$sd` | `round(sw_descriptive("std1($ryi)"), 1)` | 1 | sample standard deviation rounded to 1 decimal
`$mu0` | `100` | 1 | mean expected under null hypothesis
`$alpha` | `array(0.01, 0.05)` | 2 | significance level
`$alternative` | `($sided == 'two')? 'different from' : (($mean < $mu0)? 'less than' : 'greater than')` | 0 | text for alternative hypothesis
`$ahs` | `($sided == 'two')? 2 : (($mean < $mu0)? 3 : 4)` | 0 | solution to alternative hypothesis
`$ahsign` | `($sided == 'two')? '\neq' : (($mean < $mu0)? '<' : '>')` | 0 | latex sign for alternative hypothesis
`$se` | `round($sd / sqrt($ss), 1)` | 1 | standard error of the mean rounded to 1 decimal
`$df` | `$ss - 1` | 0 | degrees of freedom
`$tstat` | `round(($mean - $mu0) / $se, 2)` | 2 | t-statistic  rounded to 2 decimals
`$sided` | `array('one', 'two')` | 0 | one or two sided
`$lt` | ($tstat < 0)? 'TRUE' : 'FALSE' | 0 | R argument lower.tail in pt function TRUE or FALSE
`$sided_num` | `($sided == 'two')? 2 : 1` | 0 | one or two sided nummeric
`$P1_lt` | `sw_distrib("cdf_student_t ($tstat, $ss)")` | 3 | one sided P-value from lower tail
`$P_uf` | `($tstat < 0)? $P1_lt * $sided_num : (1 - $P1_lt) * $sided_num` | 3 | unfloored one or two-sided P-value from lower or upper tail
`$P` | `($P_uf > 1)? floor($P_uf) : $P_uf` | 3 | P-value floored in case it exceeds 1
`$comps` | `($P < $alpha)? 1 : 2` | 0 | solution to P and alpha comparison
`$compsign` | `($P < $alpha)? '<' : '>'` | 0 | latex sign for P and alpha comparison
`$cons` | `($P > $alpha)? 1 : (($mean < $mu0)? 3 : 4)` | 0 | solution to conclusion multiple choice question

# 1. one_sample_t_test

## General options

### Internal name
one_sample_t_test

### Type
radion button

### Number of input fields
1

## Texts

### Title

### Question
The sample size (#n#) is $ss. 
The sample mean (#\bar{Y}#) is $mean. Assume #\bar{Y}# is normally distributed.
The sample standard deviation (#s#) is $sd.

The mean expected under the null hypothesis (#\mu_0#) is $mu0.

The significance level (#\alpha#) is $alpha.

Test whether the mean (#\bar{Y}#) is significantly $alternative $mu0 (#\mu_0#).

### Solution

### Options
1. The mean (#\bar{Y}#) is <strong>not</strong> significantly different from $mu0 (#\mu_0#).
2. The mean (#\bar{Y}#) is significantly different from $mu0 (#\mu_0#).
3. The mean (#\bar{Y}#) is significantly less than $mu0 (#\mu_0#).
4. The mean (#\bar{Y}#) is significantly greater than $mu0 (#\mu_0#).

## Solutions
Solution | Definition
--- | ---
Solution 1 | `$cons`

# 1.1. one_sample_t_test_intro

## General options

### Internal name
one_sample_t_test_intro

### Type
radion button

### Number of input fields
1

## Texts

### Title
Choose the appropriate statistical test

### Question
Assume #\bar{Y}# is normally distributed.

Which statistical test is appropriate to test whether the mean (#\bar{Y}#) is significantly $alternative the mean expected under the null hypothesis (#\mu_0#)?

### Solution
An one sample t-test tests whether a sample mean (#\bar{Y}#) is different from an expected value for the mean under the null hypothesis (#\mu_0#). Assuming the sample mean is normally distributed.

### Options
1. One sample t-test
2. Two sample t-test
3. Paired t-test

## Solutions
Solution | Definition
--- | ---
Solution 1 | 1

# 1.2. one_sample_t_test_H

## General options

### Internal name
one_sample_t_test_H

### Type
open free

### Number of input fields
6

## Texts

### Title
Formulate hypotheses

### Question
We want to test whether the mean (#\bar{Y}#) is significantly $alternative the mean expected under the null hypothesis (#\mu_0#).

Formulate the null hypothesis (#H_0#) and the alternative hypothesis (#H_A#).

### Solution
Statistical hypotheses are always formulated in terms of population parameters.

#H_0: \mu = \mu_0#  
#H_A: \mu $ahsign \mu_0#

### Input area
#H_0:# #dropdown(#\bar{Y}#, #\bar{Y}_0#, #\mu#, #\mu_0#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#\bar{Y}#, #\bar{Y}_0#, #\mu#, #\mu_0#)#  
#H_A:# #dropdown(#\bar{Y}#, #\bar{Y}_0#, #\mu#, #\mu_0#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#\bar{Y}#, #\bar{Y}_0#, #\mu#, #\mu_0#)#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval normal | 3 | 1
Solution 2 | eval normal | 1 | 2
Solution 3 | eval normal | 4 | 3
Solution 4 | eval normal | 3 | 4
Solution 5 | eval normal | `$ahs` | 5
Solution 6 | eval normal | 4 | 6

# 1.3. one_sample_t_test_SE 

## General options

### Internal name
one_sample_t_test_SE

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the standard error of the mean

### Question
Sample size (#n#) is $ss. 
The sample standard deviation (#s#) is $sd.

Determine the value of the standard error of the mean (#SE_\bar{Y}#).

Give your answer with 1 decimal.

### Solution
The standard error of the mean (#SE_\bar{Y}#) is calculated by:

\begin{aligned}
SE_\bar{Y} = \frac{s}{\sqrt{n}}
= \frac{$sd}{\sqrt{$ss}}
= $se
\end{aligned}

### Input area
#SE_\bar{Y} =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$se` | 1

# 1.4. one_sample_t_test_t  

## General options

### Internal name
one_sample_t_test_t

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the t-statistic

### Question
Sample size (#n#) is $ss.
The sample mean (#\bar{Y}#) is $mean.
The stadard error of the mean was calculated in the previous excercise.
The degrees of freedom are calculated by #n - 1#.

The mean expected under the null hypothesis (#\mu_0#) is $mu0.

Determine the value of the t-statistic (#t_{df}#).

Give your answer with 2 decimals.

### Solution
The t-statistic (#t_{df}#) is calculated by:

\begin{aligned}
t_{$df} = \frac{\bar{Y} - \mu_0}{SE_\bar{Y}}
= \frac{$mean - $mu0}{$se}
= $tstat
\end{aligned}

### Input area
#t_{df} =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$tstat` | 1

# 1.5. one_sample_t_test_P  

## General options

### Internal name
one_sample_t_test_P

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the P-value

### Question
The t-statistic (#t_{df}#) and the degrees freedom (#df#) were calculated in the previous excercise.

Calculate the P-value (#P#).

Give your answer with 3 decimals.

### Solution
The $sided-sided P-value (#P#) can be calculated in R with:

<code>pt(q = $tstat, df = $df, lower.tail = $lt) * $sided_num</code>

#P =# $P

### Input area
#P =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$P` | 1

# 1.6. one_sample_t_test_comp  

## General options

### Internal name
one_sample_t_test_comp

### Type
open free

### Number of input fields
1

## Texts

### Title
Compare P-value to significance level

### Question
The significance level (#\alpha#) is $alpha.

The P-value (#P#) was calculated in the previous excercise.

Compare the P-value (#P#) to the significance level (#\alpha#).

### Solution
#P $compsign \alpha#
#$P $compsign $alpha#

### Input area
#P# #dropdown(<, >)# #\alpha#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$comps` | 1

# 1.7. one_sample_t_test_con

## General options

### Internal name
one_sample_t_test_con

### Type
radio button

### Number of input fields
1

## Texts

### Title
\~ucfirst($sided)\~-sided one sample t-test conclusion

### Question
The sample mean (#\bar{Y}#) is $mean.
The mean expected under the null hypothesis (#\mu_0#) is $mu0.

Give the conclusion of the $sided-sided one sample t-test.

### Solution
An one-sided conclusion can be drawn from a significant two-sided test.

### Options
1. The mean (#\bar{Y}#) is <strong>not</strong> significantly different from $mu0 (#\mu_0#).
2. The mean (#\bar{Y}#) is significantly different from $mu0 (#\mu_0#).
3. The mean (#\bar{Y}#) is significantly less than $mu0 (#\mu_0#).
4. The mean (#\bar{Y}#) is significantly greater than $mu0 (#\mu_0#).

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$cons` | 1
