#' Imputation metaprogramming
#' 
#' Create functions that use a function for imputing
#' 
#' @param fun value or function used for imputing. See Details.
#' 
#' @details 
#' 
#' These functions make mutate-style impute functions using [impute()] and the 
#' supplied `.na` argument.   
#' 
#' `make_imputes` is a wrapper around the other functions and returns each as 
#' a list.
#' 
#' @keywords internal 
#' @rdname make_impute

make_impute <- function(fun) function(.tbl, ..., .na=fun )  
  impute(.tbl, .na=.na, ... )  


#' @rdname make_impute
#' @export 
make_impute_at <- function(fun) function( .tbl, .vars, ..., .na=fun ) impute_at( .tbl, .na=.na, .vars )


#' @rdname make_impute
#' @export 
make_impute_all <- function(fun) function( .tbl, .na=fun, ... ) impute_all( .tbl, .na=.na, ...  )

#' @rdname make_impute
#' @export 
make_impute_if <- function(fun) function( .tbl, .predicate, ... ) impute_if( .tbl, .na=fun, .predicate, ...  )


#' @rdname make_impute
#' @export 
make_imputes <- function(.na) { 
  nm <- deparse(substitute(.na))
  nm <- sub("^na\\.", "", nm, perl=TRUE )
  structure(
    list( 
        make_impute(.na)
      , make_impute_at(.na)
      , make_impute_all(.na)
      , make_impute_if(.na)
    )
    , names = paste("impute_", nm, c("", "_at", "_all", "_if" ), sep="" )
  )
}



#' #' @rdname imports 
#' #' @aliases impute_inf impute_inf_at impute_inf_all impute_inf_if
#' #' @export 
#' na.inf %>% make_impute() %>% assign_these()
#' 
#'   # list( 
#'   #     impute = make_impute(.na)
#'   #   , impute_at = make_impute_at(.na)
#'   #   , impute_all = make_impute_all(.na)
#'   #   , impute_if = make_impute_if(.na)   
#'   # )
#' # }
#'   
#'   
#' # impute_inf <- make_impute(na.inf)
#' # imputes_inf <- make_imputes(na.inf)
#' 

