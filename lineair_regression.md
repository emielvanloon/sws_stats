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
`$slope` | `$cor * $sigmay / $sigmax` | 2 | slope of population regression line
`intercept` | `$muy - $slope * $mux` | 2 | intercept of population regression line
`sigmares` | `$sigmay * sqrt(1 - pow($cor,2))` | 1 | standard deviation of residual population
`$res` | `sw_distrib("random_normal($intercept, $sigmares, $ss)")` | 1 | random sample of residuals
`$rxi` | `sw_distrib("random_normal($mux, $sigmax, $ss)")` | 1 | random sample of x
`$ryi` | `sw_maxima_native("$slope * $rxi + $res")` | 1 | random sample of y
`$plot` | `sw_draw("point_type = filled_circle, points($rxi, $ryi), xlabel = \"X\", ylabel = \"Y\"")` | 0 | scatterplot of x and y

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

Assume #Y# and #X# are normally distributed.  
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
$rxi

A random sample of Y:
$ryi

Load the data into R.

Specify the sample size (#n#).

### Solution
<code>X = c($rxi_fmt)</code>  
<code>Y = c($ryi)</code>

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

#Y# is the response variabele and #X# is the explanatory variable.

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
