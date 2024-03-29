% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_css_conditional_column.R
\name{add_css_conditional_column}
\alias{add_css_conditional_column}
\title{Add conditional css to tableHTML's columns}
\usage{
add_css_conditional_column(
  tableHTML,
  columns,
  conditional = c("color_rank", "==", "!=", "min", "max", "top_n", "bottom_n", ">", ">=",
    "<", "<=", "between", "contains", "logical"),
  n = NULL,
  value = NULL,
  between = NULL,
  css = NULL,
  color_rank_theme = c("Custom", "RAG", "Spectral", "Rainbow", "White-Green",
    "White-Red", "White-Blue"),
  color_rank_css = NULL,
  decreasing = FALSE,
  same_scale = TRUE,
  logical_conditions = NULL,
  levels = NULL
)
}
\arguments{
\item{tableHTML}{A tableHTML object created by the tableHTML function.}

\item{columns}{A character atomic vector with the names of the columns or a numeric atomic vector
with the positions of the columns where the style definitions will be applied on. At least one
column must be provided. If the rownames are included the column name is "tableHTML_rownames"
and the position is 0. If row_groups are are included the column name is "tableHTML_row_groups"
and the position is -1.}

\item{conditional}{Choose a conditional that should be used to apply css to rows in columns. '==' and '!=' evaluate equality
and inequality resp. '<', '<=', '>', and '>=' evaluate the respective operators with the values of
columns on the left. 'between' is SQL like, i.e. inclusive. 'top_n' highlights the n highest values columns, 'bottom_n'
hightlights the lowest n values. 'max' and 'min' are equivalent of top_1 and bottom_1. 'contains' uses \code{grepl()} to see
if values of a column contain a pattern specified in \code{value}. 'color-rank' applies
one of the \code{color_rank_theme}. 'logical' allows the user to provide a list of logical vectors to identify where to apply the css.
This option is convenient when the condition is complex, for example if it relies on other columns in the table.}

\item{n}{the number of rows to highlight in 'top_n' and 'bottom_n'. If no value for n is provided, 1 is assumed
with a warning.}

\item{value}{the comparison value for "==", "!=", ">", ">=", "<", "<=", and "contains". value is the right hand side of
the equation or the pattern in case of "contains".}

\item{between}{a numeric vector of length 2 that defines a range, where \code{between[1]} is the lower bound
and \code{between[2]} is the upper bound of the range. between is inclusive.}

\item{css}{A list of two elements with the corresponding css. The first element of the list
should be an atomic vector with the style definitions (e.g. background-color). The second
element will be an atomic vector with the same length as the first element, which will
contain the style definitions' values (e.g. red). Check the examples for more information.}

\item{color_rank_theme}{You can either pick one of the provided themes (RAG, White-Red, White-Green,
White-Blue, Spectral, or Rainbow) or create your own by choosing 'Custom' and providing a custom css list
in \code{color_rank_css}.}

\item{color_rank_css}{An optional named list with css to be applied if a custom styling should be used.
The names correspond to a header of the tableHTML, 'rownames', or 'row_groups'.
The elements of this css named list are themselves lists of an atomic vector with style definitions (e.g. background-color).
and a list of atomic vecors that contains the style definitions' values with the same
length as the number of rows for each style definition. You can use \code{make_css_color_rank_theme} to obtain this list.}

\item{decreasing}{logical.  Should the sort order be increasing or
    decreasing? For the \code{"radix"} method, this can be a vector of
    length equal to the number of arguments in \code{\dots}. For the
    other methods, it must be length one.}

\item{same_scale}{Logical. This flag indicates whether the condition should be applied to columns individually or
in conjunction. If TRUE, the condition will be evaluated on all values of all \code{columns}. If FALSE,
the condition will be evaluated per column.}

\item{logical_conditions}{A list of logical vectors indicating where the condition holds in each column
provided in the \code{columns} parameter. Should be provided when \code{conditional} is 'logical'.
The length of the list should have the same length as \code{columns}, and the length of each vector
in the list should equal the number of rows in the table. If one logical vector is given it wil be
applied on all given columns.}

\item{levels}{Deprecated. Please change the factor levels in the input data of \code{tableHTML}.}
}
\value{
A tableHTML object.
}
\description{
\code{add_css_conditional_column} will add conditional css to a tableHTML's columns
}
\details{
\code{add_css_conditional_column} will add conditional css to a tableHTML's columns. \code{add_css_conditional_column} will only
  add css to the columns without the headers or second headers (i.e. it only affects the td tag
  internally and not the th tag). If you want to add css to the headers or second headers please
  use \code{add_css_header} or \code{add_css_second_header}. If you want to apply the same
  css for all rows in a column, please use \code{add_css_column}.
}
\examples{

qu_25_75 <- quantile(mtcars$disp, c(0.25, 0.75))

tableHTML(mtcars) \%>\%
  add_css_conditional_column(conditional = "<",
                             value = qu_25_75[1],
                             css = list('background-color', "green"),
                             columns = c("disp")) \%>\%
  add_css_conditional_column(conditional = "between",
                             between = qu_25_75,
                             css = list('background-color', "orange"),
                             columns = c("disp")) \%>\%
  add_css_conditional_column(conditional = ">",
                             value = qu_25_75[2],
                             css = list('background-color', "red"),
                             columns = c("disp"))

tableHTML(mtcars) \%>\%
  add_theme('rshiny-blue') \%>\%
  add_css_header(css = list(c("background-color", "color"),
                 c("darkgray", "white")),
                 headers = 1:12) \%>\%
  add_css_conditional_column(conditional = "min",
                             css = list('background-color', "#99CCA0"),
                             columns = c("wt")) \%>\%
  add_css_conditional_column(conditional = "max",
                             value = qu_25_75[1],
                             css = list('background-color', "#EA9393"),
                             columns = c("disp")) \%>\%
  add_css_conditional_column(conditional = "contains",
                             value = "Toyota",
                              css = list(c('background-color', "color"),
                                         c("lightgrey", "darkred")),
                              columns = c("rownames"))  \%>\%
  add_css_conditional_column(conditional = "contains",
                             value = "Mazda",
                             css = list(c('background-color', "color"),
                                        c("steelblue", "lightgray")),
                             columns = c("rownames")) \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme = "White-Blue",
                             columns = 11)

tableHTML(mtcars) \%>\%
  add_theme('scientific') \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme =  "RAG",
                             columns = 1) \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme = "Rainbow",
                             columns = 5,
                             decreasing = TRUE)

css <- make_css_color_rank_theme(list(qsec = mtcars$qsec),
                                  colors = c('#E41A1C', '#377EB8', '#4DAF4A',
                                             '#984EA3', '#FF7F00', '#FFFF33',
                                             '#A65628', '#F781BF', '#999999'))

tableHTML(mtcars) \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme =  "Custom",
                             color_rank_css = css,
                             columns = 7,
                             decreasing = FALSE,
                             same_scale = FALSE)

tableHTML(mtcars) \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme = "RAG",
                             columns = c(1, 5)) \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme = "White-Blue",
                             columns = c(8, 11),
                             same_scale = TRUE) \%>\%
  add_css_conditional_column(conditional = "color_rank",
                             color_rank_theme = "White-Red",
                             columns = c(9, 10),
                             same_scale = FALSE)

# test the condition on a column and apply the css on another
iris \%>\%
  tableHTML(rownames = FALSE,
            widths = rep(100, ncol(iris))) \%>\%
  add_css_conditional_column(
   conditional = 'logical',
   columns = c('Sepal.Length', 'Petal.Length'),
   css = list(c('background-color'), c('lightblue')),
   logical_conditions = list(iris$Sepal.Width==3,
                             iris$Petal.Width==0.3))
# apply the css on a full row
iris \%>\%
  tableHTML(rownames = FALSE,
            widths = rep(100, ncol(iris))) \%>\%
  add_css_conditional_column(conditional = 'logical',
                             columns = 1:ncol(iris),
                             css = list(c('background-color'), c('lightblue')),
                             logical_conditions = list(iris$Sepal.Width==3))

}
