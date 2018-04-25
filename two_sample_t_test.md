# Two sample t-test

# Prerequisites
* Know differences between t-tests
* Formulate statistical hypotheses in terms of population parameters
* Formulate statistical hypotheses for either one-sided or two-sided scenarios
* Calulate standard error of the difference between two sample means
* Calculate two sample t-statistic
* Calculate P-value using R for either one-sided or two-sided scenarios  
  * Use argument `lower.tail` correctly in `pt` function
* Compare P-value to significance level
* Draw (one-sided) conclusion for (significant two-sided) t-test

# Objective
* Peform two sample t-test

# Order
1. two_sample_t_test  
  1.1. two_sample_t_test_intro  
  1.2. two_sample_t_test_H
  1.3. two_sample_t_test_sp2
  1.4. two_sample_t_test_SE  
  1.5. two_sample_t_test_t  
  1.6. two_sample_t_test_P  
  1.7. two_sample_t_test_comp  
  1.8. two_sample_t_test_con  
  
# Variables
Alias | Definition | Decimals | Author comments
--- | --- | --- | ---
`$ss1` | `rand(30, 50)` | 0 | first sample size is a random integer between 30 and 50
`$ss2` | `rand(30, 50)` | 0 | second sample size is a random integer between 30 and 50
`$mu1` | `sw_distrib("random_continuous_uniform(80, 100)")` | 1 | first population mean is random float between 80 and 100
`$mu2` | `sw_distrib("random_continuous_uniform(100, 120)")` | 1 | second population mean is random float between 100 and 120
`$sigma` | `sw_distrib("random_continuous_uniform(10, 50)")`| 1 | population standard deviation is random float between 10 and 50 for both populations
`$ryi1` | `sw_distrib("random_normal($mu1, $sigma, $ss1)")` | 1 | first random sample from normally distributed population
`$ryi2` | `sw_distrib("random_normal($mu2, $sigma, $ss2)")` | 1 | second random sample from normally distributed population
`$mean1` | `round(sw_descriptive("mean($ryi1)"), 1)` | 1 | first sample mean rounded to 1 decimal
`$mean2` | `round(sw_descriptive("mean($ryi2)"), 1)` | 1 | second sample mean rounded to 1 decimal
`$sd1` | `round(sw_descriptive("std1($ryi1)"), 1)` | 1 | first sample standard deviation rounded to 1 decimal
`$sd2` | `round(sw_descriptive("std1($ryi2)"), 1)` | 1 | second sample standard deviation rounded to 1 decimal
`$alpha` | `array(0.01, 0.05)` | 2 | significance level
`$sided` | `array('one', 'two')` | 0 | one or two sided in text
`$alternative` | `($sided == 'two')? 'different from' : (($mean < $mu0)? 'less than' : 'greater than')` | 0 | text for alternative hypothesis
`$ahs` | `($sided == 'two')? 2 : (($mean1 < $mean2)? 3 : 4)` | 0 | solution to alternative hypothesis dropdown
`$ahsign` | `($sided == 'two')? '\neq' : (($mean1 < $mean2)? '<' : '>')` | 0 | LaTeX sign for alternative hypothesis
`$df1` | `$ss1 - 1` | 0 | degrees of freedom of first sample
`$df2` | `$ss2 - 1` | 0 | degrees of freedom of second sample
`$df` | `$df1 + $df2` | 0 | total degrees of freedom
`$s2p` | `round(($df1 * pow($sd1,2) + $df2 * pow($sd2,2))/$df, 1)` | 1 | pooled variance rounded to 1 decimal
`$se` | `round(sqrt($s2p * (1/$ss1 + 1/$ss2)), 1)` | 1 | standard error of the difference between two sample means rounded to 1 decimal
`$tstat` | `round(($mean1 - $mean2) / $se, 2)` | 2 | t-statistic  rounded to 2 decimals
`$lt` | `($tstat < 0)? 'TRUE' : 'FALSE'` | 0 | R argument lower.tail in pt function TRUE or FALSE
`$sided_num` | `($sided == 'two')? 2 : 1` | 0 | one or two sided nummeric
`$P1_lt` | `sw_distrib("cdf_student_t ($tstat, $df)")` | 3 | one sided P-value from lower tail
`$P_uf` | `($tstat < 0)? $P1_lt * $sided_num : (1 - $P1_lt) * $sided_num` | 3 | unfloored one or two-sided P-value from lower or upper tail
`$P` | `round(($P_uf > 1)? floor($P_uf) : $P_uf, 3)` | 3 | P-value floored in case it exceeds 1 rounded to 3 decimals
`$comps` | `($P < $alpha)? 1 : 2` | 0 | solution to P and alpha comparison dropdown
`$compsign` | `($P < $alpha)? '<' : '>'` | 0 | LaTeX sign for P and alpha comparison
`$cons` | `($P > $alpha)? 1 : (($mean1 < $mean2)? 3 : 4)` | 0 | solution to conclusion multiple choice question

# 1. two_sample_t_test

## General options

### Internal name
two_sample_t_test

### Type
radion button

### Number of input fields
1

## Texts

### Title

### Question
The first sample size (#n_1#) is $ss1.
The second sample size (#n_2#) is $ss2.

The first sample mean (#\bar{Y}\_1#) is $mean1.
The second sample mean (#\bar{Y}\_2#) is $mean2.
Assume the sample means are normally distributed.

The first sample standard deviation (#s\_1#) is $sd1.
The second sample standard deviation (#s\_2#) is $sd2.
Assume the sample standard deviations do not significantly differ.

The significance level (#\alpha#) is $alpha.

Test whether the first sample mean (#\bar{Y}\_1#) is significantly $alternative the second sample mean (#\bar{Y}\_2#).

### Solution

### Options
1. The first sample mean (#\bar{Y}\_1#) is <strong>not</strong> significantly different from the second sample mean (#\bar{Y}\_2#).
2. The first sample mean (#\bar{Y}\_1#) is significantly different from the second sample mean (#\bar{Y}\_2#).
3. The first sample mean (#\bar{Y}\_1#) is significantly less than the second sample mean (#\bar{Y}\_2#).
4. The first sample mean (#\bar{Y}\_1#) is significantly greater than the second sample mean (#\bar{Y}\_2#).

## Solutions
Solution | Definition
--- | ---
Solution 1 | `$cons`

# 1.1. two_sample_t_test_intro

## General options

### Internal name
two_sample_t_test_intro

### Type
radion button

### Number of input fields
1

## Texts

### Title
Choose the appropriate statistical test

### Question
Assume #\bar{Y}\_1# and #\bar{Y}\_2# are normally distributed.

Which statistical test is appropriate to test whether the first sample mean (#\bar{Y}\_1#) is significantly $alternative the second sample mean (#\bar{Y}\_2#)?

### Solution
A two sample t-test tests whether a sample mean is different from another sample mean.

Assuming:
<ul>
<li>the sample means are normally distributed</li>
<li>the sample standard deviations do not significantly differ</li>
</ul>

### Options
1. One sample t-test
2. Two sample t-test
3. Paired t-test

## Solutions
Solution | Definition
--- | ---
Solution 1 | 2

# 1.2. two_sample_t_test_H

## General options

### Internal name
two_sample_t_test_H

### Type
open free

### Number of input fields
6

## Texts

### Title
Formulate hypotheses

### Question
We want to test whether the first sample mean (#\bar{Y}\_1#) is significantly $alternative the second sample mean (#\bar{Y}\_2#).

Formulate the null hypothesis (#H_0#) and the alternative hypothesis (#H_A#).

### Solution
Statistical hypotheses are always formulated in terms of population parameters.

#H_0: \mu_1 = \mu_2#  
#H_A: \mu_1 $ahsign \mu_2#

### Input area
#H_0:# #dropdown(#\bar{Y}\_1#, #\bar{Y}\_2#, #\mu_1#, #\mu_2#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#\bar{Y}\_1#, #\bar{Y}\_2#, #\mu_1#, #\mu_2#)#  
#H_A:# #dropdown(#\bar{Y}\_1#, #\bar{Y}\_2#, #\mu_1#, #\mu_2#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#\bar{Y}\_1#, #\bar{Y}\_2#, #\mu_1#, #\mu_2#)#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval normal | 3 | 1
Solution 2 | eval normal | 1 | 2
Solution 3 | eval normal | 4 | 3
Solution 4 | eval normal | 3 | 4
Solution 5 | eval normal | `$ahs` | 5
Solution 6 | eval normal | 4 | 6

# 1.3. two_sample_t_test_s2p 

## General options

### Internal name
two_sample_t_test_s2p

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the pooled variance

### Question
The first sample size (#n_1#) is $ss1.  
The second sample size (#n_2#) is $ss2.  

The first degrees of freedom (#df_1#) are calculated by #n_1 - 1#.  
The second degrees of freedom (#df_2#) are calculated by #n_2 - 1#.  
The total degrees of freedom (#df#) are calulcated by #df_1 + df_2#.  

The first sample standard deviation (#s_1#) is $sd1.  
The second sample standard deviation (#s_2#) is $sd2.

Determine the value of the pooled variance (#s^2_p#).

Give your answer with 1 decimal.

### Solution
The pooled variance (#s^2_p#) is calculated by:

\begin{aligned}  
s^2_p = \frac{df_1 \cdot s^2_1 + df_2 \cdot s^2_2}{df}  
= \frac{$df1 \cdot ~pow($sd1,2)~ + $df2 \cdot~pow($sd2,2)~}{$df}  
= $s2p
\end{aligned}

### Input area
#s^2_p# = #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$sp2` | 1

# 1.4. two_sample_t_test_SE 

## General options

### Internal name
two_sample_t_test_SE

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the standard error

### Question
The first sample size (#n_1#) is $ss1.  
The second sample size (#n_2#) is $ss2.

The pooled variance (#s^2_p#) was calculated in the previous excercise.

Determine the value of the standard error of the difference between two sample means (#SE_{\bar{Y}_1-\bar{Y}_2}#).

Give your answer with 1 decimal.

### Solution
The standard error of the difference between two sample means (#SE\_{\bar{Y}\_1-\bar{Y}\_2}#) is calculated by:

\begin{aligned}  
SE_{\bar{Y}\_1-\bar{Y}\_2} = \sqrt{s^2_p \cdot (\frac{1}{n_1} + \frac{1}{n_2})}  
= \sqrt{$s2p \cdot (\frac{1}{$ss1} + \frac{1}{$ss2})}  
= $se  
\end{aligned}

### Input area
#SE_{\bar{Y}\_1-\bar{Y}\_2}# = #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$se` | 1

# 1.5. two_sample_t_test_t  

## General options

### Internal name
two_sample_t_test_t

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the t-statistic

### Question
The first sample mean (#\bar{Y}\_1#) is $mean1.  
The second sample mean (#\bar{Y}\_2#) is $mean2.

The standard error (#SE_{\bar{Y}\_1-\bar{Y}\_2}#) and the degrees of freedom (#df#) were calculated in previous exercises.

Determine the value of the t-statistic (#t_{df}#).

Give your answer with 2 decimals.

### Solution
The t-statistic (#t_{df}#) is calculated by:

\begin{aligned}  
t_{$df} = \frac{\bar{Y}\_1 - \bar{Y}\_2}{SE_{\bar{Y}\_1-\bar{Y}\_2}}  
=\frac{$mean1 - $mean2}{$se}  
= $tstat  
\end{aligned}

### Input area
#t_{df} =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$tstat` | 1

# 1.6. two_sample_t_test_P  

## General options

### Internal name
two_sample_t_test_P

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the P-value

### Question
The t-statistic (#t_{df}#) and the degrees freedom (#df#) were calculated in previous exercises.

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

# 1.7. two_sample_t_test_comp  

## General options

### Internal name
two_sample_t_test_comp

### Type
open free

### Number of input fields
1

## Texts

### Title
Compare the P-value to the significance level

### Question
The significance level (#\alpha#) is $alpha.

The P-value (#P#) was calculated in the previous exercise.

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

# 1.8. two_sample_t_test_con

## General options

### Internal name
two_sample_t_test_con

### Type
radio button

### Number of input fields
1

## Texts

### Title
\~ucfirst($sided)\~-sided two sample t-test conclusion

### Question
The first sample mean (#\bar{Y}\_1#) is $mean1.  
The second sample mean (#\bar{Y}\_2#) is $mean2.

Give the conclusion of the $sided-sided two sample t-test.

### Solution
An one-sided conclusion can be drawn from a significant two-sided test.

### Options
1. The first sample mean (#\bar{Y}\_1#) is <strong>not</strong> significantly different from the second sample mean (#\bar{Y}\_2#).
2. The first sample mean (#\bar{Y}\_1#) is significantly different from the second sample mean (#\bar{Y}\_2#).
3. The first sample mean (#\bar{Y}\_1#) is significantly less than the second sample mean (#\bar{Y}\_2#).
4. The first sample mean (#\bar{Y}\_1#) is significantly greater than the second sample mean (#\bar{Y}\_2#).

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$cons` | 1

