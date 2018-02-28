
data("nairis")

context( ".. impute_median")
test_that("impute_median", {
  
  ans <- c(5, 3.5, 1.4, 0.2)
  
  res <- nairis %>%  impute_median(1:4) 
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  res <- nairis %>% impute_median_at( .vars=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width") )
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  expect_error(res <- nairis %>% impute_median_all)
  # res %>% .[3,1:4] %>% expect_equivalent(ans)

  nairis %>% impute_median_if(is.numeric)
  res %>% .[3,1:4] %>% expect_equivalent(ans)
  
  
})

