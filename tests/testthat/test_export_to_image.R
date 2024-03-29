context("testing of export to image")

test_that("Function fails for wrong inputs", {
 skip_on_cran()
 skip_on_os('windows')

 #check argument type is picked correctly
 expect_error(
  mtcars %>%
   tableHTML() %>%
   add_theme('scientific') %>%
   tableHTML_to_image(type = 'abc'),
  'should be one of'
 )

 #check argument add is logical
 expect_error(
  mtcars %>%
   tableHTML() %>%
   tableHTML_to_image(add = 2),
  "add must be TRUE or FALSE"
 )

 #check jpeg prints a file
 expect_true({
  myfile <- tempfile(fileext = '.jpeg')
  mtcars %>%
   tableHTML() %>%
   tableHTML_to_image(type = 'jpeg', file = myfile)
  out <- file.size(myfile) > 1
  file.remove(myfile)
  out
 })

 #check png prints a file
 expect_true({
  myfile <- tempfile(fileext = '.png')
  mtcars %>%
   tableHTML() %>%
   tableHTML_to_image(type = 'png', file = myfile)
  out <- file.size(myfile) > 1
  file.remove(myfile)
  out
 })

 #check png prints a file even with a theme
 expect_true({
  myfile <- tempfile(fileext = '.png')
  mtcars %>%
   tableHTML() %>%
   add_theme('rshiny-blue') %>%
   tableHTML_to_image(type = 'png', file = myfile)
  out <- file.size(myfile) > 1
  file.remove(myfile)
  out
 })

 #check if plot is added to device
 expect_true({
  par_1 <- par()

  mtcars %>%
   tableHTML() %>%
   tableHTML_to_image(add = TRUE)
  par_2 <- par()
  identical(par_1, par_2)
 })

 #check if device is shut down
 #before adding the image
 #this tends to crash the system withing expect_false
 #but works manually
 
  expect_false({
  plot(1:5)
  par_1 <- par()

   mtcars %>%
    tableHTML() %>%
    tableHTML_to_image(add = FALSE)
   par_2 <- par()
   identical(par_1, par_2)
  })

})


