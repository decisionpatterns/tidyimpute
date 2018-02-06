#' Make nacars 

data(mtcars)
nacars <- head(mtcars)
nacars[ c(3,5),] <- NA_real_
nacars[ , c(3,5) ] <- NA_real_
nacars

devtools::use_data(nacars, overwrite=TRUE)

library(data.table)
nacars_dt <- nacars
setDT(nacars_dt)
nacars_dt <- data.table( nacars )

devtools::use_data(nacars_dt, overwrite = TRUE )


