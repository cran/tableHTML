% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_column_editable.R
\name{add_editable_column}
\alias{add_editable_column}
\title{Make columns Editable}
\usage{
add_editable_column(tableHTML, columns)
}
\arguments{
\item{tableHTML}{A tableHTML object created by the tableHTML function.}

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
\code{add_editable_column} will make the specified columns editable
}
\examples{
tableHTML(mtcars) \%>\%
  add_editable_column(columns = 'mpg')

tableHTML(mtcars,
          rownames = TRUE,
          widths = c(150, 100, rep(50, 11)),
          row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3'))) \%>\%
   add_css_column(css = list('background-color', 'lightgray'), columns = 'row_groups') \%>\%
   add_css_column(css = list('text-align', 'right'), columns = 'row_groups') \%>\%
   add_css_header(css = list('background-color', 'lightgray'), headers = 1) \%>\%
   add_editable_column(columns = -1:3)

}
