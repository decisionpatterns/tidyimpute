
## tidyimport  <img src="man/figures/hexagon_blue_tidyimpute_v1.0.png"  width="120px" align="right">

**Comprehensive Library For Handling Missing Values** 

[![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)
[![CRAN](http://www.r-pkg.org/badges/version/tidyimport)](https://cran.rstudio.com/web/packages/tidyimport/index.html)
[![Downloads](http://cranlogs.r-pkg.org/badges/tidyimport?color=brightgreen)](http://www.r-pkg.org/pkg/tidyimport)


**tidyimpute** is tidtverse/dplyr compliant toolkit for imputing missing 
values (NA) values in list-like and table-like structures including data.tables.
It had two goals: 1) extend existing `na.*` functions from the stats packages 
and 2) provide **dplyr**/**tidyverse** compliant methods for tables and lists. 

There are methods for the detection, removal, replacement, recollection, 
imputation, etc. of `NAs`.  In short, it is a comprehensive tool box for common 
operations when working with missing values.

In ass

## Feature List
 
 * Over **80** functions for working with missing values (See [#Function List] below.) 
 * Standardizes and extends `na.*` functions found in the *stats* package.
 * Provides **dplyr**/**tidyverse** inteface for working with table data
 * Calculate statistics on missing values: `na.n`, `na.pct`
 * Remove missing rows: `drop_rows_any_na`, `drop_rows_all_na`
 * Remove missing cols: `drop_cols_any_na`, `drop_cols_all_na`
 * Replacement/Imputation
   * Type/class and length-safe replacement. (**tidyimport** will never change 
     produce an object with a different length/nrow or type/class of its target.)
   * Replace using scalar, vector or function(s)
   * Support for ordered or time-series data: `na.loess`, `na.locf`, `na.locb`, `na.trim`, `na.approx`, `na
   * Summary function for common replacements: `mean`, `median`, `max`, `min`, `zero`
   * Support for recursive (lists and table-like structures)
   * Support for `tibble`
   * Support for `data.table`
   * Easy mnemonics:
     - Functions beginning with `na` deal with handling values (think: `na.omit`)
       - `na.*` (dot) operate on vectors like `na.omit`
       - `na_*` (underscore) operate on tables like function in dplyr/tidyvese.
     - Non replacement functions do not start w
  * Four, extensible types of imputations

### Upcoming features

 * recall/track which values have been replaced
 * `by-group` calculations
 * Model-based imputation 
   - Model-based + by-groups
   

## Installation

### Github 

    library(devtools)
    install_github( "decisionpatterns/tidyimport")
    
    
### CRAN 

Coming Soon ...
  

## Function List 

### Calculation 

 * `na.n` - Count mising values 
 * `na.pct` - Calculate pct of missing values

### Identification and Tests

 * `which.na` - Return logical or character indicating which elements are missing 
 * `all.na` (`na.all`)  - test if all elements are missing
 * `any.na` (`na.any`)  - test if any elements are missing
   
### Removal / Ommision / Exclusion 

 * `na.rm` - remove `NA`s  (with tables is equivalent to `drop_cols_all_na` )
 * `na.trim` - remove `NA`s from beginning or end (order matters)
 
**Table Only Functions:**
 * `drop_rows_all_na`, `drop_rows_any_na`
 * `drop_cols_all_na`, `drop_cols_any_na`
 
 
### Replacement / Imputation ###

There are four types of imputation methods. They are distinguished by
how the replacement values are calculated. Each is described below as well as 
describing each of the methods used.

**Constants**

In "constant" imputation methods, missing values are replaced by an 
*a priori* selected constant value. The vector containingmissing values 
is not used to calculate the replacement value. These take the form: `na.fun(x, ...)`

 * `na.zero` - 0 
 * `na.inf` / `na.neginf` - Inf/-Inf
 * `na.constant` (deprecated: use `na_replace`)


**Univariate**

(Impute using function(s) of the target variable; When imputing in a table this 
is also called *column-based imputation* since the values used to derive the 
imputed come from the single column alone.)

In "univariate" replacement methods, values are calculated using 
only the target vector, ie the one containing the missing values. The functions 
for performing the imputation are nominally univariate summary functions. 
Generally, the ordering of the vector does not affect imputed values. In general,
one value is used to replace all missing values (`NA`) for a variable.

 * `na.n` - count of NA values
 * `na.max` - maximum  
 * `na.min` - minumum 
 * `na.mean` - mean 
 * `na.median` - median value
 * `na.quantile` - quantile value
 * `na.sample`/`na.random` - randomly sampled value


**Ordered Univariate** 

(Impute using function(s) of the target variable. Variable ordering relevant. 
This is a super class of the previous **column-based imputation**.)

In "ordered univariate" methods, replacement valuse are calculated
from the vector that is assumed to be ordered. These types are very
often used with **time-series** data. (Many of these functions are taken from 
or patterned after functions in the **zoo** package.)

 * `na.loess` - loess smoother, assumes values are ordered
 * `na.locf` - last observation carried forward, assumes ordered 
 * `na.nocb` - next observation carried backwards, assumes ordered

 * `na.structTS` - Kalman Filter replacement
 * `na.spline` - Interpolated replacement; Taken from the `zoo` package. 
 * `na.approx` - Interpolated replacement; Taken from the `zoo` package. 
 * `na.aggregate` - Replace by aggregate values Taken from the `zoo` package.

 
**Multivariate**

(Impute with multiple variables from the same observation. In tables, this is
also called **row-based imputation** because imputed values derive from other 
measurement for the same observation. )

In "Multivariate" imputation, any value from the same row (observation) can be 
used to derive the replacement value. This is generally implemented as a model 
traing from the data with `var ~ ...`

 * `na_fit`,`na_predict` - use a model 


**Generalized** (-tk)

(Impute with column and rows.)

 
**General**
 * `na.replace`/`na.explicit` - atomic vectors only. General replacement function
 * `na.implicit` - turn explicit values to NAs

 
**Misc.** 
 * `na.roughfix.POSIXct` - Impute for POSIXct vectors in the **RandomForest** package
 

**Future:**
 * `na.unreplace`/`na.restore` - restore NAs to the vector; remembering
    replacement
 * `na.toggle` - toggle between `NA` and replacement values


## Examples

    v <- 1:3
    v[2] <- NA_real_
     
    na.replace( v, 2) 
    na.replace( v, mean )
    
