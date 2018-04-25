# Linear regression analysis in R

# Prerequisites

# Objective
* Perfrom linear regression analysis in R

# Order
1.1. linear_regression_intro  
1.2. linear_regression_data  
1.3. linear_regression_equation  
1.4. linear_regression_ab  
1.5. linear_regression_H  
1.5. linear_regression_t-test  
  
# Variables
Alias | Definition | Decimals | Author comments
--- | --- | --- | ---
`$ss` | `rand(30, 50)` | 0 | sample size is a random integer between 30 and 50
`$mux` | `sw_distrib("random_continuous_uniform(80, 100)")` | 1 | population mean of X
`$muy` |  `sw_distrib("random_continuous_uniform(100, 120)")` | 1 | population mean of Y
`$sigmax` | `sw_distrib("random_continuous_uniform(10, 50)")` | 1 | population standard deviation of X
`$sigmay` | `sw_distrib("random_continuous_uniform(10, 50)")` | 1 | population standard deviation of Y
`$cor` | `sw_distrib("random_continuous_uniform(-0.9, 0.9)")` | 2 | negative or positive correlation coefficient
`$beta` | `$cor * $sigmay / $sigmax` | 2 | slope of population regression line
`$alpha` | `$muy - $beta * $mux` | 2 | intercept of population regression line
`$sigmares` | `$sigmay * sqrt(1 - pow($cor,2))` | 1 | standard deviation of residual population
`$res` | `sw_distrib("random_normal($alpha, $sigmares, $ss)")` | 1 | random sample of residuals
`$rxi` | `sw_distrib("map(lambda([x], float(round(x*10)/10)), random_normal($mux, $sigmax, $ss))")` | 1 | random sample of X rounded to 1 decimal
`$ryi` | `sw_maxima_native("map(lambda([y], float(round(y*10)/10)), $beta * $rxi + $res)")` | 1 | random sample of Y rounded to 1 decimal
`$rxi_fm` | `substr($rxi, 1, -1)` | 1 | data for X formatted for text
`$ryi_fm` | `substr($ryi, 1, -1)` | 1 | data for Y formatted for text
`$scatter_plot` | `sw_draw("color = black, point_type = filled_circle, points($rxi, $ryi), xlabel = \"X\", ylabel = \"Y\"")` | 0 | scatterplot of X and Y
`$meanx` | `sw_descriptive("mean($rxi)")` | 1 | sample mean of X
`$meany` | `sw_descriptive("mean($ryi)")` | 1 | sample mean of Y
`$SP` | `sw_maxima_native("apply(\"+\", ($rxi - $meanx) * ($ryi - $meany))")` | 1 | sum of products
`$SSx` | `sw_descriptive("var($rxi) * $ss")` | 1 | sum of squares of X
`$SSy` | `sw_descriptive("var($ryi) * $ss")` | 1 | sum of squares of Y
`$slope` | `$SP / $SSx` | 2 | sample slope unrounded
`$slope_rnd` | `round($slope, 2)` | 2 | sample slope rounded to 2 decimals
`$intercept` | `round($meany - $slope * $meanx, 2)` | 2 | sample intercept rounded to 2 decimals
`$plot` | `sw_draw("color = blue, explicit($meany, x, lmin($rxi), lmax($rxi)), color = red, explicit($wa + $v * x, x, lmin($rxi), lmax($rxi)), color = black, point_type = filled_circle, points($rxi, $ryi), xlabel = \"X\", ylabel = \"Y\"")` | 0 | scatterplot with null model and linear model
`$df` | `$ss - 2` | 0 | degrees of freedom
`$MSres` | `($SSy - $slope * $SP) / $df` | 1 | mean square residual
`$se` | `sqrt($MSres / $SSx)` | 1 | standard error of the slope
`$tstat` | `round($slope / $se, 2)` | 2 | t-statistic
`$P1_lt` | `sw_distrib("cdf_student_t ($tstat, $df)")` | 3 | one sided P-value from lower tail
`$P_uf` | `($tstat < 0)? $P1_lt * 2 : (1 - $P1_lt) * 2` | 3 | unfloored two-sided P-value from lower or upper tail
`$P` | `($P_uf > 1)? floor($P_uf) : $P_uf` | 3 | P-value floored in case it exceeds 1
`$sign` | `($P < 0.05)? "significant" : "insignificant"` | 0 | significance of t-test
`$R2` | `pow($SP / sqrt($SSx * $SSy), 2)` | 2 | R-squared value
`$creased` | `($slope > 0)? "increased" : "decreased"` | 0 | increased or decreased

# 1.1. linear_regression_intro

## General options

### Internal name
linear_regression_intro

### Type
radio button

### Number of input fields
1

## Texts

### Title
Choose the appropriate analysis

### Question
$scatter_plot

Assume #X# and #Y# are normally distributed.

Which analysis is appropriate to predict a value of #Y# from a value of #X#?

### Solution
A linear regression analysis is used to predict a value of #Y# from a value of #X#.

Assuming:
<ul>
<li>#X# and #Y# are normally distributed</li>
<li>#X# and #Y# have a linear relationship</li>
<li>the variance of #Y#-values is not significantly different at all values of #X#</li>
</ul>

### Options
1. Pearson correlation analysis  
2. Spearman correlation analysis  
3. Linear regression analysis  
4. Non-linear regression analysis  

## Solutions
Solution | Definition
--- | ---
Solution 1 | 3

# 1.2. linear_regression_data

## General options

### Internal name
linear_regression_data

### Type
open free

### Number of input fields
1

## Texts

### Title
Load data into R

### Question
A random sample of X:
$rxi_fm

A random sample of Y:
$ryi_fm

Load the data into R.

Specify the sample size (#n#).

### Solution
<code>X = c($rxi_fm)</code>  

<code>Y = c($ryi_fm)</code>

### Input area
#n =# #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$ss` | 1

# 1.3. linear_regression_equation

## General options

### Internal name
linear_regression_equation

### Type
open free

### Number of input fields
5

## Texts

### Title
Formulate the regression line

### Question
Name all variabels and parameters.

Formulate the equation for the regression line.

### Solution
#a# is the intercept and #b# is the slope.

#X# is the explanatory variable and #Y# is the response variabele.

The regression line is described by #Y = a + bX#.

### Input area
#a#: #dropdown(Intercept, Slope, Explanatory variabele, Response variabele)#  
#b#: #dropdown(Intercept, Slope, Explanatory variabele, Response variabele)#  

#X#: #dropdown(Intercept, Slope, Explanatory variabele, Response variabele)#  
#Y#: #dropdown(Intercept, Slope, Explanatory variabele, Response variabele)#

Regeression line: #input#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval normal | 1 | 1
Solution 2 | eval normal | 2 | 2
Solution 3 | eval normal | 3 | 3
Solution 4 | eval normal | 4 | 4
Solution 5 | eval_exact | `Y = a + bX` | 5

# 1.4. linear_regression_ab

## General options

### Internal name
linear_regression_ab

### Type
open free

### Number of input fields
4

## Texts

### Title
Calculate the regression line

### Question
Calculate the intercept (#a#).

Calculate the slope (#b#).

Formulate the regression line.

Give your answers with 2 decimals.

### Solution
#a = $intercept#
#b = $slope#
#Y = $intercept + $slope \cdot X#

To calculate the regression line in R use:

<code>model = lm(Y ~ X)</code>

### Input area
#a# = #input#

#b# = #input#

Regression line: #Y =# #input# + #input# #\cdot X#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$intercept` | 1
Solution 2 | eval numeric | `$slope_rnd` | 2
Solution 3 | eval numeric | `$intercept` | 3
Solution 4 | eval numeric | `$slope` | 4

# 1.5. linear_regression_H

## General options

### Internal name
linear_regression_H

### Type
open free

### Number of input fields
6

## Texts

### Title
Formulate hypotheses

### Question
$plot

We want to test whether the previously formulated regression line (<span style="color: red;">#Y = $intercept + $slope \cdot X#</span>)
is a significantly better predictive model compared to the null model (<span style="color: blue;">#Y = \bar{Y}#</span>).

Formulate the null hypothesis (#H_0#) and the alternative hypothesis (#H_A#).

### Solution
Statistical hypotheses are always formulated in terms of population parameters.

#H_0: \beta = 0#
#H_A: \beta \neq 0#

### Input area
#H_0:# #dropdown(#a#, #\alpha#, #b#, #\beta#, #\bar{X}#, #\bar{Y}#, #\mu_X#, #\mu_Y#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#0#, #\bar{X}#, #\bar{Y}#, #\mu_X#, #\mu_Y#)#
#H_A:# #dropdown(#a#, #\alpha#, #b#, #\beta#, #\bar{X}#, #\bar{Y}#, #\mu_X#, #\mu_Y#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#0#, #\bar{X}#, #\bar{Y}#, #\mu_X#, #\mu_Y#)#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval normal | 4 | 1
Solution 2 | eval normal | 1 | 2
Solution 3 | eval normal | 1 | 3
Solution 4 | eval normal | 4 | 4
Solution 5 | eval normal | 2 | 5
Solution 6 | eval normal | 1 | 6

# 1.6. linear_regression_t-test

## General options

### Internal name
linear_regression_t-test

### Type
open free

### Number of input fields
5

## Texts

### Title
Report the results

### Question
Using R, report the results of the regression analysis.

The amount of decimals for the results are indicated in the text areas.

### Solution
A linear regression was calculated to predict #Y# based on #X#. 
A $sign regression equation was found (#t($df)=$tstat, p=$P#), with an #R^2# of #$R2#. 
#X# $creased by #$slope# for each unit of #Y#.

### Input area
#df =# #input# (0 decimals)

#t_{df} =# #input# (2 decimals)

#P# = #input# (3 decimals)

#R^2# = #input# (2 decimals)

Conclusion: the regression equation was #dropdown(significant, insignificant)#.

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$df` | 1
Solution 2 | eval numeric | `$tstat` | 2
Solution 3 | eval numeric | `$P` | 3
Solution 4 | eval numeric | `$R2` | 4
Solution 5 | eval normal | `$signs` | 5
