# Lineair regression analysis in R

# Prerequisites

# Objective
* Perfrom lineair regression analysis in R

# Order
1.1. lineair_regression_intro  
1.2. lineair_regression_data  
1.3. lineair_regression_equation  
  
# Variables
Alias | Definition | Decimals | Author comments
--- | --- | --- | ---
`$ss` | `rand(30, 50)` | 0 | sample size is a random integer between 30 and 50
`$mux` | `sw_distrib("random_continuous_uniform(80, 100)")` | 1 | population mean of x
`$muy` |  `sw_distrib("random_continuous_uniform(100, 120)")` | 1 | population mean of y
`$sigmax` | `sw_distrib("random_continuous_uniform(10, 50)")` | 1 | population standard deviation of x
`sigmay` | `sw_distrib("random_continuous_uniform(10, 50)")` | 1 | population standard deviation of y
`$cor` | `sw_distrib("random_continuous_uniform(-1, 1)")` | 2 | negative / positive correlation coefficient
`$beta` | `$cor * $sigmay / $sigmax` | 2 | slope of population regression line
`$alpha` | `$muy - $beta * $mux` | 2 | intercept of population regression line
`$sigmares` | `$sigmay * sqrt(1 - pow($cor,2))` | 1 | standard deviation of residual population
`$res` | `sw_distrib("random_normal($alpha, $sigmares, $ss)")` | 1 | random sample of residuals
`$rxi` | `sw_distrib("map(lambda([x], float(round(x*10)/10)), random_normal($mux, $sigmax, $ss))")` | 1 | random sample of x rounded to 1 decimal
`$ryi` | `sw_maxima_native("map(lambda([x], float(round(x*10)/10)), $slope * $rxi + $res)")` | 1 | random sample of y rounded to 1 decimal
`$rxi_fm` | `substr($rxi, 1, -1)` | 1 | data for X formatted for text
`$ryi_fm` | `substr($rxi, 1, -1)` | 1 | data for Y formatted for text
`$scatter_plot` | `sw_draw("color = black, point_type = filled_circle, points($rxi, $ryi), xlabel = \"X\", ylabel = \"Y\"")` | 0 | scatterplot of x and y
`meanx` | `sw_descriptive("mean($rxi)")` | 1 | sample mean of X
`meany` | `sw_descriptive("mean($ryi)")` | 1 | sample mean of Y
`$sp` | `sw_maxima_native("apply(\"+\", ($rxi - $meanx) * ($ryi - $meany))")` | 1 | sample sum of products
`$ssx` | `sw_descriptive("var($rxi) * $ss")` | 1 | sample sum of squares of X
`$slope` | `round($sp / $ssx, 2)` | sample slope rounded to 2 decimals
`$intercept` | `round($meany - $slope * $meanx, 2)` | sample intercept rounded to 2 decimals

# 1.1. lineair_regression_intro

## General options

### Internal name
lineair_regression_intro

### Type
radio button

### Number of input fields
1

## Texts

### Title
Choose the appropriate analysis

### Question
$plot

Assume #X# and #Y# are normally distributed.

Which analysis is appropriate to predict a value of #Y# from a value of #X#?

### Solution
A lineair regression analysis is used to predict a value of #Y# from a value of #X#.

Assuming:
<ul>
<li>#X# and #Y# are normally distributed</li>
<li>#X# and #Y# have a lineair relationship</li>
<li>the variance of #Y#-values is not significantly different at all values of #X#</li>
</ul>

### Options
1. Pearson correlation analysis  
2. Spearman correlation analysis  
3. Lineair regression analysis  
4. Non-lineair regression analysis  

## Solutions
Solution | Definition
--- | ---
Solution 1 | 3

# 1.2. lineair_regression_data

## General options

### Internal name
lineair_regression_data

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

# 1.3. lineair_regression_equation

## General options

### Internal name
lineair_regression_equation

### Type
open free

### Number of input fields
5

## Texts

### Title
Formulate the regession line

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

# 1.4. lineair_regression_ab

## General options

### Internal name
lineair_regression_ab

### Type
open free

### Number of input fields
4

## Texts

### Title
Calculate the regession line

### Question
Calculate the intercept (#a#).

Calculate the slope (#b#).

Formulate the regression line.

Give your answers with 2 decimals.

### Solution
To calculate the regression line in R use:

<code>model = lm(Y ~ X)</code>

### Input area
#a# = #input#

#b# = #input#

Regeression line: #Y =# #input# + #input##X#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval numeric | `$intercept` | 1
Solution 2 | eval numeric | `$slope` | 2
Solution 3 | eval numeric | `$intercept` | 3
Solution 4 | eval numeric | `$slope` | 4

# 1.5. lineair_regression_H

## General options

### Internal name
lineair_regression_H

### Type
open free

### Number of input fields


## Texts

### Title
Formulate hypotheses

### Question
We want to test whether the previously formulated regression line (#Y = $intercept + $slope \cdot X#)
is a significantly better predictive model compared to the null model (#Y = \bar{Y}#).

Formulate the null hypothesis (#H_0#) and the alternative hypothesis (#H_A#) for the intercept (#a#) and the slope (#b#).

### Solution
Statistical hypotheses are always formulated in terms of population parameters.

For the intercept (#a#):
#H_0: \alpha = \bar{Y}#
#H_A: \alpha \neq \bar{Y}#

For the slobe (#b#):
#H_0: \beta = 0#
#H_A: \beta \neq 0#

### Input area
For the intercept (#a#):
#H_0:# #dropdown(#a#, #\alpha#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#0#, #\bar{Y}#)#
#H_A:# #dropdown(#a#, #\alpha#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#0#, #\bar{Y}#)#

For the slobe (#b#):
#H_0:# #dropdown(#b#, #\beta#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#0#, #\bar{Y}#)#
#H_A:# #dropdown(#b#, #\beta#)# #dropdown(#=#, #\neq#, #<#, #>#)# #dropdown(#0#, #\bar{Y}#)#

## Solutions
Solution | Evaluation type | Definition | Answer field
--- | --- | --- | ---
Solution 1 | eval normal | 2 | 1
Solution 2 | eval normal | 1 | 2
Solution 3 | eval normal | 2 | 3
Solution 4 | eval normal | 2 | 4
Solution 5 | eval normal | 2 | 5
Solution 6 | eval normal | 2 | 6
Solution 7 | eval normal | 2 | 7
Solution 8 | eval normal | 1 | 8
Solution 9 | eval normal | 1 | 9
Solution 10 | eval normal | 2 | 10
Solution 11 | eval normal | 2 | 11
Solution 12 | eval normal | 1 | 12
