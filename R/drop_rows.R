#' drop_rows_all_na, drop_rows_any_na
#' 
#' Drop rows of a table whose values are all NA
#' 
#' @param .tbl data-like object
#' 
#' @details 
#' 
#' `na_drop_rows` removes all rows whose only values are NA. It works for all 
#' table-like objects.
#' 
#' @return 
#'   An object of the same class as `.tbl` with rows containing all 
#'   `NA` values removed
#' 
#' @seealso 
#'  * [dplyr::filter()]
#'  
#' @examples 
#' 
#'   data(iris)
#'   
#'   .tbl <- iris[1:5,]
#'   .tbl[1:2,] <- NA
#'   .tbl[3,1] <- NA
#'   .tbl
#'   
#'   filter_all_na(.tbl) 
#'   filter_any_na(.tbl)
#'   
#'   drop_rows_all_na(.tbl)
#'   drop_rows_any_na(.tbl)
#'   
#' @md
#' @rdname drop_rows
#' @export

drop_rows_all_na <- function(.tbl) 
  .tbl[ ! apply( .tbl, 1, all_na ), ]

#' @rdname drop_rows
#' @export
filter_all_na <- drop_rows_all_na


#' @rdname drop_rows
#' @export
drop_rows_any_na <- function(.tbl) 
  .tbl[ ! apply( .tbl, 1, any_na ), ]

#' @rdname drop_rows
#' @export 

filter_any_na <- drop_rows_any_na
