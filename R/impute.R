#' Replace missing values in tables and lists
#' 
#' Replace missing values (`NA`) in a table and lists
#' 
#' @param .tbl list-like or table-like structure.
#' @param .na scalar, vector or function as described in [na.tools::na.replace()]
#' @param .vars character; names of columns to be imputed
#' @param .predicate dply-type predicate functions
#' @param ... additional args; either a unnamed list of columns (quoted or not)
#'        or name=function pairs.  See Details.
#'
#' @details
#' 
#' `impute` is similar to other *dplyr* verbs especially [dplyr::mutate()]. Like
#' [dplyr::mutate()] it operates on columns. It changes only missing values 
#' (`NA`) to the value specified by `.na`. 
#'
#' **Behavior**:
#' 
#' Behavior depends on the values of `.na` and `...`.  
#' 
#' `impute` can be used for three replacement operatations: 
#'  
#'  1. `impute( .tbl, .na )` : ( missing `...` ) Replace missing values 
#'      in **ALL COLS** by `.na`.  This is analogous to `impute_all`.
#'      
#'  2. `impute( .tbl, .na, ... )` : ( `...` is an unnamed list) Replace 
#'      column(s) specified in `...` by `.na`.  Columns are specified as an 
#'      unnamed list of quoted or unquoted column names. This is analogous to 
#'      `impute_at` where `...` specifies `.vars`
#'      
#'  3. `impute( .tbl. col1=na.*, col2=na.* )` : ( missing `.na` ) : 
#'     Replace by column-specific `.na` 
#'  
#' Additional arguments are to `.na` are not used; Use `impute_at` for 
#' this or create your own lambda functions.
#' 
#' @return 
#' 
#' Returns a object as the same type as `.tbl`. Columns are mutated to replace
#' missing values (`NA`) with value specied by `.na` and `...`
#' 
#' @seealso
#'  * The **na.tools** package.
#'  * `impute_functions`
#'  
#' @examples
#' 
#'   data(nacars)
#'   
#' \dontrun{
#'   nacars %>% impute(0, mpg, cyl)
#'   nacars %>% impute(1:6, mpg, cyl)
#'
#'   nacars %>% impute( na.mean )
#'   nacars %>% impute( mean )       # unsafe
#'   nacars %>% impute( length, mpg, disp )
#'   nacars %>% impute( mean, mpg, disp )
#'   nacars %>% impute( mpg=na.mean, cyl=na.max )
#'   nacars %>% impute( na.mean, c('mpg','disp') )
#' }
#' @md
#' @import na.tools
#' @importFrom rlang eval_tidy quos
#' @importFrom dplyr select_vars vars
#' @export


impute <- function (.tbl, .na, ...)
{
  
  if( ! is.list(.tbl) & ! is.data.frame(.tbl) ) 
    stop( "`impute` only works on lists and table")
    
    
  # if( missing(.na) && missing(...) )
  #  stop( "At least one of .na or ... must be provided.")
  
  # USAGE 1: missing(...) all columns mutated by .na
  if ( missing(...) ) { 
    for( j in 1:length(.tbl) )
      .tbl[[j]] <- na.replace( .tbl[[j]], .na )
    return( .tbl )
  }
    
  
  # vars: key-value list ...
  
  # TEST whether unknown columns were specified   
  unknown <- setdiff( names(vars), names(.tbl) )
  if( length(unknown) > 0 )
    stop( paste( "Unknown columns:", paste(unknown, collapse=", ")))
  
  
  # USAGE 2: ... is column names
  # IF names were provided as part of columns list, we take
  if( ! missing(.na) && is_unnamed.quosure( quos(...) ) ) { 
    vars <- select_vars( names(.tbl), ... )  
    for( j in vars )
      .tbl[[j]] <- na.replace( .tbl[[j]], .na ) 
    return(.tbl)
  }   
  
  # USAGE 3: ... is col=na.fun pairs
  if( missing(.na) && is_named( quos(...)) ) {
    for ( . in kv( quos(...) ) )  {   
      .na = rlang::eval_tidy( .$v )
      .tbl[[.$k ]] <- na.replace( .tbl[[.$k]], .na=.na )
    }
    return(.tbl)
  } 
  
  if( ! missing(.na) && is_named( quos )) 
    stop( "Specifying .na and col=.na is not allowed")
  
}



#' @note 
#' `...` is used to specify columns in `impute` but is used as additional 
#' arguments to `.na` in the other `impute_*` functions. 
#' 
#' @examples 
#' 
#' \dontrun{
#'   nacars %>% impute_at( -99, .vars=1:3 )
#'   nacars %>% impute_at( .na=na.mean, .vars=1:6 )
#'   
#'   # Same, uses `...` for additional args
#'   nacars %>%   
#'     impute_at( .na=mean   , .vars=1:6, na.rm = TRUE  )  
#'   
#'   nacars %>% impute_at( .na=na.mean, .vars = c('mpg','cyl', 'disp') )
#' }  
#' 
#' @importFrom dplyr select_vars
#' @rdname impute
#' @export

impute_at <- function(.tbl, .na, .vars, ... ) { 

  .vars <- dplyr::select_vars( names(.tbl), .vars )
  for( i in .vars ) {
    .tbl[[i]] <- na.replace( x=.tbl[[i]], .na=.na, ... )
  }
  .tbl
  
}  


#' @details 
#' `impute_all` is like `impute` without specifying `...`. `...` is used
#' for additional arguments to `.na`
#'  
#' @examples 
#' 
#' \dontrun{
#'   nacars %>% impute_all( -99 )
#'   nacars %>% impute_all( na.min )
#' }
#'    
#' @rdname impute
#' @export

impute_all <- function(.tbl, .na, ... ) { 

  for( i in 1:length(.tbl) )
    .tbl[[i]] <- na.replace( .tbl[[i]], .na, ... )
  .tbl
    
}


#' @rdname impute
#' @export
impute_if <- function( .tbl, .na, .predicate, ... ) { 

  for( i in 1:length(.tbl) ) 
    if( .predicate(.tbl[[i]] ) ) 
      .tbl[[i]] <- na.replace( .tbl[[i]], .na=.na,  ...  )
    
  .tbl
}
  