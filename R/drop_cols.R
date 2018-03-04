#' @title Remove columns with missing values 
#' 
#' @description Remove columns of a table whose values are all `NA` or who have any `NA`
#' 
#' @param .tbl table-like object
#' 
#' @details
#' `drop_cols_all_na` removes all cols whose only values are `NA`. 
#' `drop_cols_any_na` removes columns that have any `NA`. They work on all 
#' table-like objects.
#' 
#' @return 
#'   An object of the same class as `data` with cols containing all 
#'   `NA` values removed
#' 
#' @seealso 
#'  * [dplyr::select()]
#'  
#' @md
#' @import na.tools
#' @rdname drop_cols
#' @export

drop_cols_all_na <- function(.tbl) 
  .tbl[ , ! apply( .tbl, 2, all_na ) ]


#' @rdname drop_cols
#' @export

drop_cols_any_na <- function(.tbl) 
  .tbl[ , ! apply( .tbl, 2, any_na ) ]



#' @rdname drop_cols
#' @export 

drop_na_cols <- drop_cols_all_na
