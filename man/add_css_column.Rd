% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_column_css.R
\name{add_css_column}
\alias{add_css_column}
\title{Add css to tableHTML's columns}
\usage{
add_css_column(tableHTML, css, columns)
}
\arguments{
\item{tableHTML}{A tableHTML object created by the tableHTML function.}

\item{css}{A list of two elements with the corresponding css. The first element of the list
should be an atomic vector with the style definitions (e.g. background-color). The second
element will be an atomic vector with the same length as the first element, which will
contain the style definitions' values (e.g. red). Check the examples for more information.}

\item{columns}{A character atomic vector with the names of the columns or a numeric atomic vector
with the positions of the columns where the style definitions will be applied on. At least one
column must be provided. If the rownames are included the column name is "tableHTML_rownames"
and the position is 0. If row_groups are are included the column name is "tableHTML_row_groups"
and the position is -1.}
}
\value{
A tableHTML object.
}
\description{
\code{add_css_column} will add css to a tableHTML's columns
}
\details{
\code{add_css_column} will add css to a tableHTML's columns. \code{add_css_column} will only
  add css to the columns without the headers or second headers (i.e. it only affects the td tag
  internally and not the th tag). If you want to add css to the headers or second headers please
  use \code{add_css_header} or \code{add_css_second_header}.
}
\examples{
tableHTML(mtcars) \%>\%
  add_css_column(css = list(c('background-color', 'border'), c('lightgray', '3px solid green')),
                 columns = 'mpg')

tableHTML(mtcars) \%>\%
  add_css_column(css = list(c('background-color', 'border'), c('lightgray', '3px solid green')),
                 columns = c('mpg', 'disp', 'rownames'))

tableHTML(mtcars,
          rownames = FALSE,
          widths = c(120, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3'))) \%>\%
  add_css_column(css = list('background-color', 'lightgray'), columns = 'row_groups') \%>\%
  add_css_header(css = list('background-color', 'lightgray'), headers = 1)

tableHTML(mtcars,
          rownames = TRUE,
          widths = c(140, rep(50, 12)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
          second_headers = list(c(3, 4), c('col1', 'col2'))) \%>\%
  add_css_column(list('background-color', 'green'), -1) \%>\%
  add_css_column(list('background-color', 'red'), c(0, 1))

}
