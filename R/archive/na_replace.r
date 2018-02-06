#' na_replace - replace missing values in tables and recursive structures
#' 
#' Replaces missing values (`NA`) in tables and lists
#' 
#' @param tbl table or lsit
#' @param ... specification of var=expr where expression can be a 
#'   constant, vector of length( tbl[[var]] ) or function. See Details
#'
#' @examples 
#' 
#' data(mtcars)
#' mtcars <- head(mtcars)
#' mtcars[3,] <- NA_real_
#' 
#' na_replace( mtcars, mpg=-99, cyl=length  )
#' 
#' data.table::setDT(mtcars)
#' na_replace( mtcars, mpg=-99, cyl=length  )
#' 
#' 
#' @details 


na_replace <- function( .tbl, ... ) UseMethod('na_replace')


#' @export 
na_replace.default <- function( .tbl, ... ) {
  
  if( ! is.recursive( .tbl ) ) { 
    # warning( "Use na.replace instead of na_replace for atomic objects.")
    return( na.replace( x=.tbl, ...) )
  }
  
  # First handle the name=values pairs
  #  - use kv function
  #  - if value is function apply it to x[[ key ]]
  for( kv in kv( list(...) ) ) 
    .tbl[[kv$k]] <- na.replace( .tbl[[kv$k]], .na=kv$v )
  
  .tbl

}
