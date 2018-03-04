# Key value iteration
# 
# Create a list with `k` and `v` elements useful for iteration
# 
# @param x object such as vector or list to separate into key value pairs
# @param ... additional args
# 
# @details 
# 
# No magic here, just something simple to convert `x` into a list of 
# lists. Each element of `x` is broken into a list with elements `k` 
# (key) and `v` (value). See examples.
#
# For many cases, key-value iteration can be done with `*apply` or
# `paste` functions. This is made to be explicit and work on a variery of
# objects.  
# 
# @references 
# * [SO: for-loop-in-r-with-key-value](http://stackoverflow.com/questions/18572921/for-loop-in-r-with-key-value)
# * [SO: iterate-over-key-value-pair-from-a-list](http://stackoverflow.com/questions/4500106/iterate-over-key-value-pair-from-a-list)
# 
# @return  
# A named list of list; each element of `x` becomes a one element list 
# with elements `k` and `v` representing the keys and values
# 
# @author
# This function is taken from the *kv* package and is used with permission.
#   
# @examples 
# 
#   # Lists
#   li <- list(a=1,b=2,c=3) 
#   kv(li)
# 
#   for( kv in kv(li) )
#     cat( kv$k, ":", kv$v, "\n")
# 
# 
#   # vectors 
#   v <- c(a=1, b=2, c=3 )
#   kv(li)
# 
#   for( kv in kv(li) )
#     cat( kv$k, ":", kv$v, "\n")
# 
# @md

kv <- function(x, ...) UseMethod('kv')

# @export
# @rdname kv

kv.default <- function(x) { 
  kv <- list() 
  for( i in 1:length(x) ) { 
    kv[[i]] = list( k=names(x)[[i]], v=x[[i]] )  
  }
  names(kv)=names(x)  
  return(kv)
}



# @author decision patterns / christopher brown
# Taken from the base.tools package with permission 
qw <- function (...) 
  as.character(match.call())[-1]


# @author decision patterns / christopher brown
# Taken from the dimensional package with permission  

most_freq <- function (x, na.action = stats::na.pass) 
  as(names(which.max(table(na.action(x), useNA = "always"))), class(x))


# Returns TRUE if the quosures are 
is_named <-function(x) ! is.null( attr(x, "names") ) 
is_unnamed <- function(x) is.null( attr(x, "names") )
is_named.quosure <- function(x) length( setdiff( names(x), "" ) ) == length(x)
is_unnamed.quosure <- function(x) ! is_named.quosure(x)


#' Assign named list to calling frame for setting up exports
# assign list elements to parent frame by name
#' @keywords internal 
assign_these <- function(x)
  for( nm in names(x) )
    assign( nm, x[[nm]], envir=sys.frame( sys.nframe() -1 ) ) 
    # assign( nm, x[[nm]], parent.frame()  )  


#' Export functions in list 
#' 
#' @param nms character list of name to export
#' @param x list; named list of functions to export
#' 
#' @details 
#' 
#' This uses the `@evalNamespace` directive to declare exports for objects by
#' name or when provided in a function.
#'  
#' ns_export <- function(nms) { 
#'   sprintf("export(%s)", paste(nms, collapse = ","))
#' }
#' 
#' ns_export_named <-function(x) {
#'   nms <- names(x)
#'   sprintf("export(%s)", paste(nms, collapse = ","))
#' }
#' 
#' #' @evalNamespace ns_export(names(fns))
#' 
#' @seealso 
#'  * [assign_these()]   
#'   
#' @keywords internal

ns_export <- function(nms) { 
  sprintf("export(%s)", paste(nms, collapse = ","))
}

#' @rdname ns_export
ns_export_function_list <-function(x) {
  nms <- names(x)
  sprintf("export(%s)", paste(nms, collapse = ","))
}
