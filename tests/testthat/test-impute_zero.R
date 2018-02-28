library(magrittr)


data("nairis")

context( ".. impute_zero")
test_that("impute_zero", {
  
  ans <- rep(0.0,4)
  
  res <- nairis %>%  impute_zero(1:4) 
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  res <- nairis %>% impute_zero_at( .vars=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width") )
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  # expect_warning(
    res <- nairis %>% impute_zero_all
  #)
  res %>% .[3,1:4] %>% expect_equivalent(ans)

  nairis %>% impute_zero_if(is.numeric)
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  
})

