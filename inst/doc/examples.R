## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----example 1-----------------------------------------------------------
library(tableHTML)
tableHTML(mtcars, 
          rownames = FALSE, 
          widths = c(120, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_header = list(c(3, 4, 5), c('col1', 'col2', 'col3')))

## ----example 2-----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          widths = c(100, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_header = list(c(3, 4, 6), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'white'), column_names = 'row_groups')

## ----example 3-----------------------------------------------------------
tableHTML(mtcars, 
          border = 1,
          rownames = TRUE, 
          widths = c(110, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_header = list(c(2, 5, 6), c('', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'white'), column_names = 'row_groups') %>%
 add_css_second_header(css = list(c('border-top', 'border-left'), c('1px solid white', '1px solid white')), 
                       second_headers = 1) %>%
 add_css_header(css = list(c('border-top', 'border-left', 'border-right'), 
                           c('1px solid white', '1px solid white', '1px solid white')), 
                           headers = 1) %>%
 add_css_header(css = list('background-color', 'lightgreen'), headers = 3:13)

## ----example 4-----------------------------------------------------------
tableHTML(mtcars, 
          border = 1,
          rownames = TRUE, 
          widths = c(110, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_header = list(c(2, 5, 6), c('col1', '', 'col3')),
          theme = 'scientific')

## ----example 5-----------------------------------------------------------
tableHTML(mtcars, 
          border = 1,
          rownames = TRUE, 
          widths = c(110, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_header = list(c(2, 5, 6), c('', 'col2', 'col3')),
          theme = 'rshiny-blue')

## ----example 6-----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          widths = c(100, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_header = list(c(3, 4, 6), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'white'), column_names = 'row_groups') %>%
 replace_html(pattern = '<td id="row_groups" style="background-color:white;" rowspan="10">Group 1',
              replacement = '<td id="row_groups" style="background-color:lightyellow;" rowspan="10">Group 1')

## ----example 7, eval = FALSE---------------------------------------------
#  tableHTML(mtcars,
#            border = 5,
#            rownames = TRUE,
#            collapse = 'separate',
#            widths = c(100, 140, rep(50, 11)),
#            row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
#            second_header = list(c(3, 4, 6), c('col1', 'col2', 'col3'))) %>%
#   add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
#   add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
#   add_css_column(css = list('background-color', 'white'), column_names = 'row_groups')

## ----example 8-----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)),
          second_header = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example 9-----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)),
          second_header = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'lightyellow'), column_names = 'mpg') %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example 10----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          widths = c(140, rep(50, 11)),
          second_header = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_thead(css = list('background-color', 'lightgray')) %>%
 add_css_tbody(css = list('background-color', 'lightblue')) 

## ----example 11----------------------------------------------------------
tableHTML(mtcars, 
          rownames = TRUE, 
          widths = c(140, rep(50, 11)),
          second_header = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_table(css = list('background-color', 'lightgray')) %>%
 add_css_tbody(css = list('background-color', 'lightblue')) %>%
 add_css_row(css = list('background-color', 'red'), row = 5) %>%
 add_css_column(css = list('background-color', 'lightgreen'), column_names = 'mpg') 

## ----example 12----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)), 
          second_header = list(c(3, 4, 5), c('col1', '', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example 13----------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)), 
          second_header = list(c(3, 4), c('col1', 'col2'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example 14----------------------------------------------------------
tableHTML(mtcars, 
          rownames = TRUE, 
          widths = c(100, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(2:33)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(2:33)) %>%
 add_css_row(css = list('background-color', 'lightgreen'), rows = 1) %>%
 add_css_column(css = list('background-color', 'lightyellow'), column_names = 'row_groups') 

## ----example 15----------------------------------------------------------
tableHTML(mtcars, collapse = 'separate_shiny', spacing = '5px 2px') %>%
    add_css_table(css = list(c('background-color'), c('lightgray'))) %>% 
    add_css_table(css = list('color', 'blue'))

