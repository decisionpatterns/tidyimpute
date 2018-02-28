library(magrittr)


data("nairis")

context( ".. impute_max")
test_that("impute_max", {
  
  ans <- c(5.4, 3.9, 1.7, 0.4)
  
  res <- nairis %>%  impute_max(1:4) 
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  res <- nairis %>% impute_max_at( .vars=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width") )
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  expect_error(res <- nairis %>% impute_max_all)
  # res %>% .[3,1:4] %>% expect_equivalent(ans)

  nairis %>% impute_max_if(is.numeric)
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  
})

