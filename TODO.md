## TODO ##

 - [ ] Should impute_max / impute_min should not return -Inf and +Inf for all 
       NA rows or be consistent with na.mean and na.median  
       
 - [x] Create Logo **Circle Ban** of `NA`
 
 - [x] `na[._]impute` as alias for `na[._]replace` respectively.
 
 - [x] `na.explicit` and `na_explicit` apply to factors only
 
 - [ ] Row-based imputation does not need to calculate every-value values for 
   all observations, only the missing ones. This is different than column-based
   imputations which need values from all observations. There might be some 
   efficiency gains from doing this.
   
 - [ ] There is a generalized imputation that uses both rows and columns and
   might automatically consider by-groups (how does the values of )
 
 
### `coerce_safe`

 - [ ] Move `coerce_safe` to the **coercion** package. [ ] Import **coercion**.

 - _all, _if, _at
     - na_replace_all( .tbl, .funs, ... ) 
     - na_replace_if( .tbl, .predicate, .funs, ... )
     - na_replace_at( .tbl, .predicate, .funs, ... )
     
 
 
 So .tbl %>% na_replace_all( iris, 3, ...)
             na_replace( iris, mean, na.rm=TRUE )
             na_replace_if( iris, is.cont, mean, na.rm=TRUE )
             na_replace_at( iris, ! Species, mean, na.rm=TRUE )

 
 - [ ] Support atomics with `impute` 
   - na_replace and na_explicit
   - [x] replace by scalar?  (Low-level)
   - [x] replace by vector?  (Other)
   - [x] replace by unary function? ()
   - [x] replace by function of multiple args: `impute_*`
   - [ ] replace by model/formula? ()
   - [ ] store .na value (if scalar)
   - [ ] store replaced idxs --- like na.omit  

 - Implement slow functions with Rcpp 
 
 - Might there be a clever way to allow something like:
      NA_explicit_ <- . %>% mean(., na.rm=TRUE)
    This will not work
 
 - [ ] Consider having an option for values for the na_level, e.g.
      options( na_explicit = "(Missing)" ) or, 
      options( na_explicit = mean )  
 - [x] Categorical and continuous variables must be different.
 - [ ] Explicit value might depend on the class, type (cat vs. cont), or on a 
   specific attribute, `na_explicit` or `na` of the specific vari`able. 
   
 - [ ] Consider how explicit NA will be treated in sorting 
   - [ ] Do we want exceptional values first or last?
   
 - [ ] Use **catcont** package?
 
 - [x] `na_replace` and `na_explicit` are getting very similar and should probably be
   made aliases
   
 - [ ] Devise syntax of related to list-like/recursive objects 
   - applying a function to an **entire**  vs.
   - applying to each **element** object
   See na_explicit and na_implicit


### Completed 

 - [x] na_drop_rows, na_drop_cols for table-like objects
    - Remove rows/cols with all NAs
 - [x] Make na_replace vectorized, e.g. na_replace( value=... )
 - [x] na_ifelse for na_replace
 