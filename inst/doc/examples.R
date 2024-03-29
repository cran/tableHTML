## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo=TRUE)

## ----example1-----------------------------------------------------------------
library(tableHTML)
tableHTML(mtcars, 
          rownames = FALSE, 
          widths = c(120, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3')))

## ----example2-----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          widths = c(100, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(3, 4, 6), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'white'), columns = 'row_groups')

## ----example3-----------------------------------------------------------------
tableHTML(mtcars, 
          border = 1,
          rownames = TRUE, 
          widths = c(110, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(2, 5, 6), c('', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'white'), columns = 'row_groups') %>%
 add_css_second_header(css = list(c('border-top', 'border-left'), c('1px solid white', '1px solid white')), 
                       second_headers = 1) %>%
 add_css_header(css = list(c('border-top', 'border-left', 'border-right'), 
                           c('1px solid white', '1px solid white', '1px solid white')), 
                           headers = 1) %>%
 add_css_header(css = list('background-color', 'lightgreen'), headers = 3:13)

## ----example4-----------------------------------------------------------------
tableHTML(mtcars, 
          rownames = TRUE, 
          widths = c(110, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(2, 5, 6), c('col1', '', 'col3'))) %>%
 add_theme('scientific')

## ----example5-----------------------------------------------------------------
tableHTML(mtcars, 
          rownames = TRUE, 
          widths = c(110, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(2, 5, 6), c('', 'col2', 'col3'))) %>%
 add_theme('rshiny-blue')

## ----example6-----------------------------------------------------------------
mtcars %>% 
 tableHTML(rownames = TRUE,
           widths = c(140, rep(50, 11))) %>%
 add_theme('colorize', color = 'navyblue')

## ----example7.1---------------------------------------------------------------
mtcars %>%
 tableHTML(rownames = TRUE,
          widths = c(140, rep(50, 11))) %>%
 add_theme_colorize(color=c('steelblue', 'green'))

## ----example7.2---------------------------------------------------------------
ts_to_df <- data.frame(year = trunc(time(AirPassengers)), 
                 Month = month.abb[cycle(AirPassengers)],
                 AirPassengers, 
                 stringsAsFactors = F) 
ts_to_df <- ts_to_df[ts_to_df$year < 1951, ]
  
rbind(ts_to_df[1:12, 2:3],
      c('AVG', round(mean(ts_to_df[1:12, ]$AirPassengers), 2)),
      ts_to_df[13:24, 2:3],
      c('AVG', round(mean(ts_to_df[13:24, ]$AirPassengers), 2))) %>% 
 tableHTML(rownames = FALSE, 
            widths = rep(75, 3),
            row_groups = list(c(13, 13), 
                              unique(ts_to_df$year))) %>% 
  add_theme_colorize(id_column = TRUE, 
                   total_rows = c(13, 26), 
                   color = c('#009999', 'yellow2'))

## ----example8-----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          widths = c(100, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(3, 4, 6), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'white'), columns = 'row_groups') %>%
 replace_html(pattern = '<td id="tableHTML_row_groups" style="background-color:white;" rowspan="10">Group 1',
              replacement = '<td id="tableHTML_row_groups" style="background-color:lightyellow;" rowspan="10">Group 1')

## ----example9, eval = FALSE---------------------------------------------------
#  tableHTML(mtcars,
#            border = 5,
#            rownames = TRUE,
#            collapse = 'separate',
#            widths = c(100, 140, rep(50, 11)),
#            row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
#            second_headers = list(c(3, 4, 6), c('col1', 'col2', 'col3'))) %>%
#   add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
#   add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
#   add_css_column(css = list('background-color', 'white'), columns = 'row_groups')

## ----example10----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)),
          second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example11----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)),
          second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_column(css = list('background-color', 'lightyellow'), columns = 'mpg') %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example12----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          widths = c(140, rep(50, 11)),
          second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_thead(css = list('background-color', 'lightgray')) %>%
 add_css_tbody(css = list('background-color', 'lightblue')) 

## ----example13----------------------------------------------------------------
tableHTML(mtcars, 
          rownames = TRUE, 
          widths = c(140, rep(50, 11)),
          second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3'))) %>%
 add_css_table(css = list('background-color', 'lightgray')) %>%
 add_css_tbody(css = list('background-color', 'lightblue')) %>%
 add_css_row(css = list('background-color', 'red'), row = 5) %>%
 add_css_column(css = list('background-color', 'lightgreen'), columns = 'mpg') 

## ----example14----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)), 
          second_headers = list(c(3, 4, 5), c('col1', '', 'col3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example15----------------------------------------------------------------
tableHTML(mtcars, 
          border = 5,
          rownames = TRUE, 
          collapse = 'collapse',
          widths = c(140, rep(50, 11)), 
          second_headers = list(c(3, 4), c('col1', 'col2'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(3:34)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(3:34)) %>%
 add_css_thead(css = list('background-color', 'lightblue'))

## ----example16----------------------------------------------------------------
tableHTML(mtcars, 
          rownames = TRUE, 
          widths = c(100, 140, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3'))) %>%
 add_css_row(css = list('background-color', 'lightgray'), rows = odd(2:33)) %>%
 add_css_row(css = list('background-color', 'lightblue'), rows = even(2:33)) %>%
 add_css_row(css = list('background-color', 'lightgreen'), rows = 1) %>%
 add_css_column(css = list('background-color', 'lightyellow'), columns = 'row_groups') 

## ----example17----------------------------------------------------------------
tableHTML(mtcars, collapse = 'separate_shiny', spacing = '5px 2px') %>%
    add_css_table(css = list(c('background-color'), c('lightgray'))) %>% 
    add_css_table(css = list('color', 'blue'))

## ----example18----------------------------------------------------------------
tableHTML(mtcars,
          widths = c(140, rep(50, 11))) %>%
  add_theme('scientific') %>%
  add_css_row(css = list('background-color', '#E0E0E0'), rows = odd(3:34)) %>%
  add_css_conditional_column(conditional = 'between',
                             between = c(3.5, 4.22), 
                             css = list(c('background-color'), c('gray')),
                             columns = c('drat', 'wt')) %>%
  add_css_header(css = list(c('transform', 'height'), 
                            c('rotate(-45deg)', '40px')),
                 headers = 1:12)


## ----example19----------------------------------------------------------------
tableHTML(iris[c(1:5, 51:55, 101:105), 1:4], 
          rownames = FALSE,
          headers = rep(c('Length', 'Width'), 2),
          second_headers = list(c(1, 2, 2), c('Species', 'Sepal', 'Petal')),
          row_groups = list(rep(5, 3), paste0('<div style="width:100%; height:100%; ',
                                               'transform:rotate(-90deg); font-size:16px; ',
                                               'font-weight:bold; color:white; align:center">', 
                                               c('setosa', 'versicolor', 'virginica'),
                                               '</div>'))) %>%
  add_css_column(css = list(c('background-color', 'border'),
                            c('gray', 'white')), 
                 columns = 'row_groups') %>%
  add_css_second_header(css = list(c('color', 'background-color'),
                                   c('white', 'gray')),
                        second_headers = 1:3) %>%
  add_css_header(css = list(c('color', 'background-color'),
                            c('white', 'gray')),
                 headers = 1:5) %>%
  add_css_conditional_column('color_rank',
                             color_rank_theme = 'White-Green',
                             columns = 1:2,
                             same_scale = FALSE) %>%
  add_css_conditional_column('color_rank',
                             color_rank_theme = 'White-Blue',
                             columns = 3:4,
                             same_scale = FALSE)

## ----example20, eval=FALSE----------------------------------------------------
#  mtcars %>%
#   tableHTML(widths = c(140, rep(50, 11))) %>%
#   add_theme('rshiny-blue') %>%
#   tableHTML_to_image(type = 'png')

## ----example21, fig.height=7, fig.width=7, eval=FALSE-------------------------
#  mtcars %>%
#   tableHTML(widths = c(140, rep(50, 11))) %>%
#   add_theme('rshiny-blue') %>%
#   tableHTML_to_image(type = 'png')

