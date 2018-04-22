# Confidence interval of the mean

# Prerequisites
* Calculate a critical t-value using R
  * Correctly use `p` argument in `qt` function
* Calculate the standard error of the mean
* Calculate the lower bound and upper bound of a confidence interval

# Objective
* Give a confidence interval for a mean

# Order
1. CI_of_mu
  1.1. CI_of_mu_tcrit  
  1.2. CI_of_mu_SE  
  1.3. CI_of_mu2  
  
# Variables
Alias | Definition | Decimals | Author comments
--- | --- | --- | ---
`$ss` | `rand(50, 250)` | 0 | sample size is a random integer between 50 and 250
`$mu` | `sw_distrib("random_continuous_uniform(100, 200)")` | 1 | population mean is random float between 100 and 200
`$sigma` | `sw_distrib("random_continuous_uniform(10, 50)")`| 1 | population standard deviation is random float between 10 and 50
`$ryi` | `sw_distrib("random_normal($mu, $sigma, $ss)")` | 1 | random sample from normally distributed population
`$mean` | `round(sw_descriptive("mean($ryi)"), 1)` | 1 | sample mean rounded to 1 decimal
`$sd` | `round(sw_descriptive("std1($ryi)"), 1)` | 1 | sample standard deviation rounded to 1 decimal
`$se` | `round($sd / sqrt($ss), 1)` | 1 | standard error of the mean rounded to 1 decimal
`$alpha` | `array(0.01, 0.05)` | 2 | significance level
`$percentage` | `(1 - $alpha) * 100` | 0 | percentage of confidence interval
`$quantile` | `1 - $alpha + $alpha/2` | 3 | quantile for critical t-value
`$tcrit` | `round(sw_distrib("quantile_student_t ($quantile,$ss - 1)"), 2)` | critical t-value rounded to 2 decimals
`LB` | `round($mean - $tcrit * $se, 1)` | 1 | lower bound of confidence interval rounded to 1 decimal
`UB` | `round($mean + $tcrit * $se, 1)` | 1 | upper bound of confidence interval rounded to 1 decimal

# 1. CI_of_mu

## General options

### Internal name
CI_of_mu

### Type
open free

### Number of input fields
2

## Texts

### Title
$percentage% confidence interval of the mean

### Question
Sample size (#n#) is $ss. 
The sample mean (#\bar{Y}#) is $mean. 
The sample standard deviation (#s#) is $sd.

Determine a $percentage% confidence interval (#CI#) for the mean (#\mu#).

Give your answers with 1 decimal.

### Solution
The $percentage% confidence interval (#CI#) for the mean (#\mu#) is given by:

\begin{aligned}
\bar{Y} - t_{\alpha(2), n-1} \cdot SE &< \mu < \bar{Y} + t_{\alpha(2), n-1} \cdot SE\\
= $mean - $tcrit \cdot $se &< \mu < $mean + $tcrit \cdot $se\\
= $LB &< \mu < $UB
\end{aligned}

### Input area
#input# #< \mu <# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$LB` | 1
Solution 2 | eval numeric | `$UB` | 2

# 1.1. CI_of_mu_tcrit

## General options

### Internal name
CI_of_mu_tcrit

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the critical t-value

### Question
Sample size (#n#) is $ss.
The degrees of freedom are caluclated bij #n - 1#.

Determine the critical t-value (#t_{\alpha(2), df}#) for a $percentage% confidence interval (#CI#).

Give your answer with 2 decimals.

### Solution
The critical t-value (#t_{\alpha(2), df}#) for a $percentage% confidence interval (#CI#) can be calculated in R with:

qt(p = $quantile, df = ~$ss - 1~, lower.tail = TRUE)

#t_{$alpha(2), ~$ss - 1~} = $tcrit#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$tcrit` | 1

# 1.2. CI_of_mu_SE

## General options

### Internal name
CI_of_mu_SE

### Type
open free

### Number of input fields
1

## Texts

### Title
Calculate the standard error for of the mean

### Question
Sample size (#n#) is $ss.
The sample standard deviation (#s#) is $sd.

Determine the standard error of the mean (#SE_{\bar{Y}}#).

Give your answer with 1 decimal.

### Solution
The standard error of the mean (#SE_{\bar{Y}}#) is given by:

\begin{aligned}
SE_\bar{Y}= \frac{s}{ \sqrt{n}} = \frac{$sd}{ \sqrt{$ss}} = $se
\end{aligned}

### Input area
#SE_\bar{Y} =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$se` | 1

# 1.3. CI_of_mu2

## General options

### Internal name
CI_of_mu2

### Type
open free

### Number of input fields
2

## Texts

### Title
Calculate the lower bound and upper bound of the $percentage% confidence interval of the mean

### Question
The sample mean (#\bar{Y}#) is $mean. 

The critical t-value (#t_{$alpha(2),~$ss - 1~}#) and standard eror of the mean (#SE_{\bar{Y}}#) were calculated in previous exercises.

Determine a $percentage% confidence interval (#CI#) for the mean (#\mu#).

Give your answers with 1 decimal.

### Solution
The $percentage% confidence interval (#CI#) for the mean (#\mu#) is given by:

\begin{aligned}
\bar{Y} - t_{\alpha(2), n-1} \cdot SE &< \mu < \bar{Y} + t_{\alpha(2), n-1} \cdot SE\\
= $mean - $tcrit \cdot $se &< \mu < $mean + $tcrit \cdot $se\\
= $LB &< \mu < $UB
\end{aligned}

### Input area
#input# #< \mu <# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$LB` | 1
Solution 2 | eval numeric | `$UB` | 2
