% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_tableHTML.R
\name{write_tableHTML}
\alias{write_tableHTML}
\title{Writes the HTML code to a file}
\usage{
write_tableHTML(tableHTML, file, complete_html = FALSE)
}
\arguments{
\item{tableHTML}{A tableHTML object created by the tableHTML function.}

\item{file}{A character string. This is the file name. You need to include the extention.}

\item{complete_html}{Either TRUE or FALSE. Defaults to FALSE. If TRUE then the <html> and <body>
tags are also added in the file.}
}
\value{
The function itself returns nothing but a file is created.
}
\description{
\code{write_tableHTML} will write the HTML code to a file
}
\details{
\code{write_tableHTML} will write the HTML code to a file.
}
\examples{
\dontrun{
write_tableHTML(tableHTML(mtcars), file = 'myhtmlcode.html')

write_tableHTML(tableHTML(mtcars), file = 'myhtmlcode.html', complete_html = TRUE)
}

}
