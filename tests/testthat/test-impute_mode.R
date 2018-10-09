library(testthat)
library(magrittr)
library(tidyimpute)

data("nairis")

context( ".. impute_mode")
test_that("impute_mode", {
  
  ans <- c(4.6,3,1.4,0.2)
  
  res <- nairis %>%  impute_mode(1:4) 
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  res <- nairis %>% impute_mode_at( .vars=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width") )
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  expect_error(res <- nairis %>% impute_mode_all)
  res %>% .[3,1:4] %>% expect_equivalent(ans)

  nairis %>% impute_mode_if(is.numeric)
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  
})

