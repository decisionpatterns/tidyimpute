#' drop_cols_all_na, drop_cols_any_na
#' 
#' Drop cols of a table whose values are all `NA` or who have any `NA`
#' 
#' @param .tbl table-like object
#' 
#' @details
#' `drop_cols_all_na` removes all cols whose only values are `NA`. It works on all 
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
#' @rdname drop_cols
#' @export

drop_cols_all_na <- function(.tbl) 
  .tbl[ , ! apply( .tbl, 2, na.all ) ]


#' @rdname drop_cols
#' @export

drop_cols_any_na <- function(.tbl) 
  .tbl[ , ! apply( .tbl, 2, na.any ) ]



#' @rdname drop_cols_all_na 
#' @export 

drop_na_cols <- drop_cols_all_na
