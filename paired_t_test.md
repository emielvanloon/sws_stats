# Paired t-test

# Prerequisites
* Know differences between t-tests
* Formulate statistical hypotheses in terms of population parameters
* Formulate statistical hypotheses for either one-sided or two-sided scenarios
* Calulate standard error of the mean of differences
* Calculate one sample t-statistic
* Calculate P-value using R for either one-sided or two-sided scenarios  
  * Use argument `lower.tail` correctly in `pt` function
* Compare P-value to significance level
* Draw (one-sided) conclusion for (significant two-sided) t-test

# Objective
* Peform paired t-test

# Order
1. paired_t_test  
  1.1. paired_t_test_intro  
  1.2. paired_t_test_H  
  1.3. paired_t_test_SE  
  1.4. paired_t_test_t  
  1.5. paired_t_test_P  
  1.6. paired_t_test_comp  
  1.7. paired_t_test_con  
  
# Variables
Alias | Definition | Decimals | Author comments
--- | --- | --- | ---
`$ss` | `rand(30, 50)` | 0 | first sample size is a random integer between 30 and 50
`$sigma` | `sw_distrib("random_continuous_uniform(10, 50)")`| 1 | population standard deviation is random float between 10 and 50
`$dif` | `sw_distrib("random_normal(0, $sigma, $ss)")` | 1 | differences of paired measurements
`$meand` | `round(sw_descriptive("mean($dif)"), 1)` | 1 | mean of differences rounded to 1 decimal
`$sd` | `round(sw_descriptive("std1($dif)"), 1)` | 1 | standard deviation of differences rounded to 1 decimal
`$alpha` | `array(0.01, 0.05)` | 2 | significance level
`$sided` | `array('one', 'two')` | 0 | one or two sided in text
`$alternative` | `($sided == 'two')? 'different from' : (($mean < $mu0)? 'less than' : 'greater than')` | 0 | text for alternative hypothesis
`$ahs` | `($sided == 'two')? 2 : (($meand < 0)? 3 : 4)` | 0 | solution to alternative hypothesis dropdown
`$ahsign` | `($sided == 'two')? '\neq' : (($meand < 0)? '<' : '>')` | 0 | LaTeX sign for alternative hypothesis
`$df` | `$ss - 1` | 0 | degrees of freedom
`$se` | `round($sd / sqrt($ss), 1)` | 1 | standard error of differences rounded to 1 decimal
`$tstat` | `round(($meand) / $se, 2)` | 2 | t-statistic  rounded to 2 decimals
`$lt` | `($tstat < 0)? 'TRUE' : 'FALSE'` | 0 | R argument lower.tail in pt function TRUE or FALSE
`$sided_num` | `($sided == 'two')? 2 : 1` | 0 | one or two sided nummeric
`$P1_lt` | `sw_distrib("cdf_student_t ($tstat, $df)")` | 3 | one sided P-value from lower tail
`$P_uf` | `($tstat < 0)? $P1_lt * $sided_num : (1 - $P1_lt) * $sided_num` | 3 | unfloored one or two-sided P-value from lower or upper tail
`$P` | `($P_uf > 1)? floor($P_uf) : $P_uf` | 3 | P-value floored in case it exceeds 1
`$comps` | `($P < $alpha)? 1 : 2` | 0 | solution to P and alpha comparison dropdown
`$compsign` | `($P < $alpha)? '<' : '>'` | 0 | LaTeX sign for P and alpha comparison
`$cons` | `($P > $alpha)? 1 : (($meand < 0)? 3 : 4)` | 0 | solution to conclusion multiple choice question

# 1. paired_t_test

## General options

### Internal name
paired_t_test

### Type
radion button

### Number of input fields
1

## Texts

### Title

### Question
The sample size (#n#) is $ss.

The mean of the differences (#\bar{d}#) is $meand.
Assume #\bar{d}# is normally distributed.

The standard deviation of the differences (#s_{\bar{d}}#) is $sd.

The significance level (#\alpha#) is $alpha.

Test whether the mean of the differences (#\bar{d}#) is significantly $alternative 0.

### Solution

### Options
1. The mean of the differences (#\bar{d}#) is <strong>not</strong> significantly different 0.
2. The mean of the differences (#\bar{d}#) is significantly different from 0.
3. The mean of the differences (#\bar{d}#) is significantly less than 0.
4. The mean of the differences (#\bar{d}#) is significantly greater than 0.

## Solutions
Solution | Definition
--- | ---
Solution 1 | `$cons`

# 1.1. paired_t_test_intro

## General options

### Internal name
paired_t_test_intro

### Type
radion button

### Number of input fields
1

## Texts

### Title
Choose the appropriate statistical test

### Question
Assume #\bar{d}# is normally distributed.

Which statistical test is appropriate to test whether the mean of the differences (#\bar{d}#) is significantly $alternative 0?

### Solution
A paired t-test tests whether the mean difference of paired measurements equals 0. Assuming the mean difference of paired measurements is normally distributed.

### Options
1. One sample t-test
2. Two sample t-test
3. Paired t-test

## Solutions
Solution | Definition
--- | ---
Solution 1 | 3

# 1.2. paired_t_test_H

## General options

### Internal name
paired_t_test_H

### Type
open free

### Number of input fields
4

## Texts

### Title
Formulate hypotheses

### Question
We want to test whether the mean difference of paired measurements equals 0.

Formulate the null hypothesis (#H_0#) and the alternative hypothesis (#H_A#).

### Solution
Statistical hypotheses are always formulated in terms of population parameters.

#H_0: \mu_d = 0#
#H_A: \mu_d $ahsign 0#

### Input area
#H_0:# #dropdown(#\bar{d}#, #\mu_d#)# #dropdown(#=#, #\neq#, #<#, #>#)# #0#
#H_A:# #dropdown(#\bar{d}#, #\mu_d#)# #dropdown(#=#, #\neq#, #<#, #>#)# #0#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval normal | 2 | 1
Solution 2 | eval normal | 1 | 2
Solution 3 | eval normal | 2 | 3
Solution 4 | eval normal | `$ahs` | 4

# 1.3. paired_t_test_SE 

## General options

### Internal name
paired_t_test_SE

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the standard error

### Question
Sample size (#n#) is $ss.  
The standard deviation of the differences (#s_\bar{d}#) is $sd.

Determine the value of the standard error (#SE_\bar{d}#).

Give your answer with 1 decimal.

### Solution
The standard error of the mean (#SE_\bar{d}#) is calculated by:

\begin{aligned}  
SE_\bar{d} = \frac{s_\bar{d}}{\sqrt{n}} = \frac{$sd}{\sqrt{$ss}} = $se
\end{aligned}

### Input area
#SE_{\bar{d}}# = #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$se` | 1

# 1.4. paired_t_test_t  

## General options

### Internal name
paired_t_test_t

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the t-statistic

### Question
The mean of the differences (#\bar{d}#) is $meand.  
The degrees of freedom are calculated by #n - 1#.  

The standard error of the differences (#SE_{\bar{d}#) was calculated in the previous exercise.

Determine the value of the t-statistic (#t_{df}#).

Give your answer with 2 decimals.

### Solution
The t-statistic (#t_{df}#) is calculated by:

\begin{aligned}  
t_{$df} = \frac{\bar{d} - 0}{SE_\bar{d}} = \frac{$meand - 0}{$se} = $tstat  
\end{aligned}

### Input area
#t_{df} =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$tstat` | 1

# 1.5. paired_t_test_P  

## General options

### Internal name
paired_t_test_P

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

# 1.6. paired_t_test_comp  

## General options

### Internal name
paired_t_test_comp

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
Solution 1 | eval normal | `$comps` | 1

# 1.7. paired_t_test_con

## General options

### Internal name
paired_t_test_con

### Type
radio button

### Number of input fields
1

## Texts

### Title
\~ucfirst($sided)\~-sided paired t-test conclusion

### Question
The mean of the differences (#\bar{d}#) is $meand.

Give the conclusion of the $sided-sided two sample t-test.

### Solution
An one-sided conclusion can be drawn from a significant two-sided test.

### Options
1. The mean of the differences (#\bar{d}#) is <strong>not</strong> significantly different 0.
2. The mean of the differences (#\bar{d}#) is significantly different from 0.
3. The mean of the differences (#\bar{d}#) is significantly less than 0.
4. The mean of the differences (#\bar{d}#) is significantly greater than 0.

## Solutions
Solution | Definition | Answer field
--- | --- | --- | ---
Solution 1 | `$cons` | 1
