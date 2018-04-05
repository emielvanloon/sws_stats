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
* Perfrom one sample t-test

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
`$alternative`
`$se` | `round($sd / sqrt($ss), 1)` | 1 | standard error of the mean rounded to 1 decimal
`$df` | 
`$tstat` | `round(($mean - $mu0) / $se, 2)` | 2 | t-statistic  rounded to 2 decimals
`$sided` |
`$lt` |
`$sided_num` | 
`$P1_lt` |
`$P_uf` |
`$P` |

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

### Options
1. The mean (#\bar{Y}#) is not significantly different from $mu0 (#\mu_0#).
2. The mean (#\bar{Y}#) is significantly different from $mu0 (#\mu_0#).
3. The mean (#\bar{Y}#) is significantly less than $mu0 (#\mu_0#).
4. The mean (#\bar{Y}#) is significantly greater than $mu0 (#\mu_0#).

## Solutions
