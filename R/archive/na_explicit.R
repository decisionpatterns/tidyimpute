#' na_explicit
#' 
#' Set missing values to an explicit value,
#' 
#' @param x object; either atomic or recursive.
#' @param .na either a single element vector list or named vectors; See #Details.  
#' @param ... (used for recursive structures only) a list of name=value pairs
#' 
#' @details 
#' 
#' `na_explicit` replaces missing (`NA`) values in `x` with 
#' an explicit value set by the `.na` argument. It is largely an extension of
#' [impute()] and supports table-like objects in a *tidyverse* compliant way.
#' 
#' 
#' atomic x | .na==NULL  | ... missing     : error
#' atomic x | .na==NULL  | ... there       : error 
#' atomic x | .na!=NULL  | ... missing     : all columns impute by .na
#' atomic x | ,na!==NULL | ... there       : all columns impute by .na, ... is extra args to f
#' 
#' rec x | .na==NULL  | ... missing     : error 
#' rec x | .na==NULL  | ... there       : columns transformed by ... 
#' rec x | .na!=NULL  | ... missing     : all columns impute by .na (Should this be supported( ?) impute_all
#' rec x | ,na!==NULL | ... there       : all columns impute by .na, ... is extra args to f       impute_
#' 
#' 
#' impute( .tbl, ... )
#' 
#' x .na!=NULL  | ... missing : all columns set to `.na``
#' .na==NULL  | col=x | col=na
#' 
#' na_explicit( .tbl, col1=mean( . , na.rm=TRUE )... )
#' na_explicit
#' 
#' **input: `x`**
#' 
#' `x` can be either an *atomic* or *recursive* object. If *atomic* then 
#' `na_explicit` behaves as [impute()] an replaces missing values with `.na` 
#' and `...` is used to specify additional arguments if `.na` is a function.  
#' 
#' If `x` is *recursive* then missing values are replaced by `.na`/`...` in a 
#' dplyr manner.
#' 
#' The default is to use 
#' [NA_explicit]
#' [impute()] but explicitly but works on recursive 
#'  
#'  It is also intended to be single argument function.
#' 
#' @seealso 
#' 
#'  - [impute()] 
#'  - [na_implicit()]
#'  - forcats::fct_explicit_na()
#' 
#' @examples 
#' 
#'   na_explicit( c(1, NA, 3, 4), 0 )
#'   na_explicit( c("A",NA,"c","D" ) ) 
#' 
#'   na_explicit( c("A",NA,"c","D") )
#'    
#'   na_explicit( )
#'    
#' @md
#' @export

na_explicit <- function(x, .na, ... ) 
  UseMethod("na_explicit")


#' @export
na_explicit.default <- function(x, .na, ... ) 
  if( is.recursive(x) ) 
    .na_explicit.recursive(x, .na, ... ) else
    .na_explicit.atomic( x, .na, ... )


# Do not export - 
# these are internal functions that are dispatched by `na_explicit.default`

.na_explicit.recursive <- function(x, .na=NULL, ... ) {

  if( ! is.null(.na) ) 
    
    
  # First handle the name=values pairs
  #  - use kv function
  #  - if value is function apply it to x[[ key ]]
  for( kv in kv( list(...) ) ) { 
    if( is.function(kv$v) )
      val <- kv$v( x[[kv$k]] ) else 
      val <- kv$v
  
    x[[kv$k]] <- na_explicit( x[[kv$k]], .na=val )
    
  }   
  
  x

}


.na_explicit.atomic <- function(x, .na, ... ) 
  impute( x, .na )


#' @export
na_explicit.character <- function(x, .na = NA_explicit_ ) { 
  impute(x, .na)  
}


#' @export
na_explicit.factor <- function(x, .na = NA_explicit_ ) { 
  impute(x, .na)  
}
