# DESIGN.md - Design notes for na.actions pacakge

This document tracks opinionated desicion about the **na.actions** package that 
largely have to do with the design choices made

## Goals 

The packages shoould handle be the single repository for functions/methods for 
working with missing values (NA) for all data science workflows.

It should be extensible and be able to handle 

 - recursive and atomistic values
 - types: categorical and continous variables
 - classes: specific classes


## Naming and Labels

 - The explicit value for `forcats::fct_explicit_na` is `(Missing)`; this is not
   adopted here because it is needlessly long, '(NA)' is used instead.
 - beginning variables with 
 
 
 
## na.replace and 

## Organization 

 - na_replace works only on atomic vectors; 
 - na_explicit additionally supports recursive objects and calls na_replace. 

## Style Elements


## Behaviors

 - replacement is type/class-safe; the type will not be affected by the 
   replacement.
 - Function names should follow the lower_snake_case naming conventions. This prevents
   collisions with functions from the *stats* package. It may make sense for
   `na.*` functions operate at a low-level on vectors and similar to the *stats*
   package while `na_*` vectors operate
   on a higher level.
   
   
 - Follow tidyverse styles
   - Arguments should be lower_snake_case
   - Arguments names should often be preceded by a '.' when following tidyverse 
   styles 
 - `NA_explicit_` 
   - cannot be "NA" since it becomes impossible to distinguish it from true 
     `NAs` when printing to the console.
  
  
## Simple Imputation 

     na_replace( x, .na=mean )
     na_replace( tbl, col1 = mean )          Or, 
     na_replace( tbl, col1 = mean(col1) )
     

## Complex Imputation 

Imputation should be preformed when the replacement value is a rhs-formula:

    na_replce(tbl, col1 = ~col2, .method=lm )
  
This has the effect of creating a model for col1 ~ col2  

