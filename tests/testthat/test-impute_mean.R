library(magrittr)


data("nairis")

context( ".. impute_mean")
test_that("impute_mean", {
  
  ans <- c(5,3.42,1.48,0.24)
  
  res <- nairis %>%  impute_mean(1:4) 
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  res <- nairis %>% impute_mean_at( .vars=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width") )
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  expect_warning(res <- nairis %>% impute_mean_all)
  res %>% .[3,1:4] %>% expect_equivalent(ans)

  nairis %>% impute_mean_if(is.numeric)
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  
})

