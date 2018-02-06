library(magrittr)

context("na_explicit")


context( ".. data.frame")
test_that( "na_explicit.data.frame", { 
  
  data(iris)
  iris <- head(iris)
  iris[3,] <- NA 

  iris %>% na_explicit(3)
  
  
})





## NOTE:
## since na_explicit extends na_explicit ... the following test are just copied 
## from test-na_explicit.R with the na_explicit => na_explicit

context(".. continous-integer")
test_that("na_explicit-continuous-integer", {

# REPLACE with scalar 
  v <- 1:3
  v[2] <- NA_integer_
  
  v %>% na_explicit(0) %T>% 
    expect_is("integer") %>%
    expect_equal( c(1,0,3) )
  
  v %>% na_explicit(2) %T>% 
    expect_is("integer") %>%
    expect_equal( c(1,2,3) )  
  
  v <- 1:4
  v[ c(2,4) ] <- NA_integer_
  v %>% na_explicit(2) %T>% 
    expect_is("integer") %>% 
    expect_equal( c(1,2,3,2) )    # 1 2 3 2

# REPLACE with VECTOR
  v %>% na_explicit(1:4) %T>% 
    expect_is("integer") %>% 
    expect_equal(1:4)             # 1 2 3 4

# REPLACE by non-consistent class/type
  expect_error( v %>% na_explicit("a") )
  
})


context(".. continous-numeric")
test_that("na_explicit-continuous-integer", {

# REPLACE with scalar 
  v <- 1:3 %>% as.numeric()
  v[2] <- NA_real_
  
  v %>% na_explicit(0) %T>% 
    expect_is("numeric") %>%
    expect_equal( c(1,0,3) )
  
  v %>% na_explicit(2) %T>% 
    expect_is("numeric") %>%
    expect_equal( c(1,2,3) )  
  
  v <- 1:4
  v[ c(2,4) ] <- NA_real_
  v %>% na_explicit(2) %T>% 
    expect_is("numeric") %>% 
    expect_equal( c(1,2,3,2) )    # 1 2 3 2

# REPLACE with VECTOR
  v %>% na_explicit(1:4) %T>% 
    expect_is("numeric") %>% 
    expect_equal(1:4)             # 1 2 3 4

# REPLACE with non-consistent class/type
  expect_error( v %>% na_explicit("a") )
  
})



context(".. character")
test_that("na_explicit-character", {

# REPLACE with SCALAR
  v <- letters[1:4]
  v[c(2,4)] <- NA_character_
  
  v %>% na_explicit("x") %T>%
    expect_is("character") %>% 
    expect_equivalent( c("a","x","c","x"))
  
# REPLACE with VECTOR
  v %>% na_explicit(letters[1:4]) %T>%
    expect_is("character") %>% 
    expect_equivalent( letters[1:4] ) 

# REPLACE by DEFAULT
  v %>% na_explicit() %T>%
    expect_is("character") %>% 
    expect_equivalent( c("a","(NA)","c","(NA)")) 


# REPLACE with non-consistent class
  v %>% na_explicit(1L) %T>%
    expect_is("character") %>% 
    expect_equivalent( c("a","1","c","1") )
    
  
  })  
  

context( ".. factor")
test_that( "na_explicit factor", { 
  
  fct <- letters[1:5] 
  fct[c(2,5)] <- NA 
  fct <- as.factor(fct)

# REPLACE with scalar
  ans <- factor( qw(a, z, c, d, z) )
  fct %>% na_explicit("z")  %T>%
    expect_is("factor") %T>% 
    { . %>% levels %>% expect_equal(levels(ans)) } %>%
    expect_equivalent( as.factor(ans) )
  
# REPLACE with vectoe
  ans <- factor( letters[1:5], levels=qw(a,c,d,b,e) ) 
  fct %>% na_explicit(letters[1:5]) %T>% 
    expect_is("factor") %T>% 
    { . %>% levels %>% expect_equal(levels(ans)) } %T>%
    expect_equivalent(ans)
  
# REPALCE with  default
  ans <- factor( qw(a,(NA),c,d,(NA)), levels=qw(a,c,d,(NA)) ) 
  fct %>% na_explicit() %T>% 
    expect_is("factor") %T>%
    { . %>% levels %>% expect_equal( levels(ans) ) } %>% 
    expect_equivalent(ans)
  
})
