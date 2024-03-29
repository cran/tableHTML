#' Create an easily css-ible HTML table
#'
#' The purpose of \code{tableHTML} is to create easily css-ible HTML tables
#' that are compatible with R shiny. The exported HTML table will contain separate ids
#' or classes for headers, columns, second headers (if any) and the table itself
#' (in case you have multiple tables) in order to create a
#' complex css file very easily. ids and classes are explained in detail in
#' the details section.
#'
#' \code{tableHTML} will create an HTML table with defined ids and classes for rows and columns.
#' In particular:
#' \itemize{
#'   \item \strong{Table:} Will get the class from the class argument in the function.
#'   \item \strong{Columns:} Will get an id which will be of the form tableHTML_column_x (where x
#'       is the column position). If rownames exist these will get the tableHTML_rownames id. If
#'       row groups exist these will get the tableHTML_row_groups id. Check the \code{add_css_column}
#'       function for examples.
#'   \item \strong{Headers:} Will get an id of the form tableHTML_header_x (where x is the header position).
#'       For example the first header will have the id tableHTML_header_1, the second header
#'       will have tableHTLM_header_2 and so on. If rownames exist these will get the tableHTML_header_0 id.
#'   \item \strong{Second_Header:} Will get an id of the form tableHTML_second_header_x (where x is the
#'       second header position). For example the first second_header will have the id tableHTML_second_header_1,
#'       the second header will have tableHTML_second_header_2 and so on.
#' }
#'
#' Notice that rows do not get a specific id or class.
#'
#' If you would like to use a non-collapsed table i.e. leave spacing between cells, then
#' you would need to use the \code{collapse} argument. Setting it to separate would create a
#' non-collapsed table. However, this choice will not work in shiny. The reason is that shiny
#' uses \code{table {border-collapse: collapse; border-spacing:0;}} in its css by default through
#' bootstrap 3. In order to overcome this problem in shiny, \code{collapse} needs to be set to
#' separate_shiny instead of separate. By setting collapse to separate_shiny tableHTML uses
#' \code{!important} in order to overwrite the standard behaviour of bootstrap 3. \code{!important}
#' needs to be used with caution since it overwrites css styles, so unless you are using shiny
#' (or any other place where the above css is automatically loaded) you should be using
#' \code{collapse = 'separate'}.
#'
#' Printing the table will result in rendering it in R studio's viewer
#' with the print.tableHTML method if using Rstudio otherwise it will use the default
#' browser. Use \code{print(tableHTML(obj), viewer = FALSE)} or \code{str(tableHTML(obj))}
#' to view the actual html code.
#'
#' @param obj Needs to be a data.frame or a matrix or an arbitrary object that has the
#'   data.frame class and can be coersible to a data.frame (e.g data.table, tbl, etc.)
#'
#' @param rownames Can be TRUE or FALSE. Defaults to TRUE. Whether the obj's rownames
#'   will be inlcuded.
#'
#' @param class Character string. Specifies the table's class. Convinient if you have multiple
#'   tables. Default is table_xxxx (random 4-digit number).
#'
#' @param headers character vector. The headers for the HTML table. If not provided the original
#'   data.frame headers will be used.
#'
#' @param widths Needs to be a numeric atomic vector with the column widths. Widths are in pixels.
#'
#' @param second_headers A list of two elements of the same length. The first element will contain
#'   the column spans (i.e. a numeric atomic vector) whereas the second element will contain the
#'   names (i.e. a character atomic vector). See the examples for more info. Defauls to NULL.
#'
#' @param row_groups A list of two elements of the same length. The first element will contain
#'   the row spans (i.e. a numeric atomic vector) whereas the second element will contain the
#'   names (i.e. a character atomic vector). See the examples for more info. Defauls to NULL.
#'
#' @param caption Character string. The table's caption.
#'
#' @param footer Character string. The table's footer. This gets added below the table and it
#'   should not be confused with tfooter.
#'
#' @param border An integer. Specifies the border of the table. Defaults to 1. 0 removes borders
#'   from the table. The higher the number the thicker the table's outside border.
#'
#' @param collapse Whether to collapse the table or not. By default the tables are collapsed. The
#'   choices for this argument are 'collapse', 'separate' and 'separate_shiny'. Check the details
#'   about which one to use.
#'
#' @param spacing Character string. This is only used if collapse is either separate or
#'   separate_shiny and sets the spacing between the table's cells. It defaults to 2px. Can be one
#'   or two length values (provided as a string). If two length values are provided the first one
#'   sets the horizontal spacing whereas the second sets the vertical spacing. See the examples.
#'
#' @param escape  Can be TRUE or FALSE. Defaults to TRUE. Escapes characters < and > because they
#'   can close (or open) the table's HTML tags if they exist within the data.frame's text. This
#'   means that all < and > characters within the tableHTML will be converted to &#60 and &#62
#'   respectively.
#'
#' @param round An integer specifying the number of decimals of numbers of
#' numeric columns only. Defaults to NULL which means no rounding.
#'
#' @param replace_NA A sting that specifies with what to replace NAs in character
#' or factor columns only. Defaults to NULL which means NAs will be printed.
#'
#' @param x A tableHTML object created from the \code{tableHTML} function.
#'
#' @param ... Optional arguments to print.
#'
#' @param viewer TRUE or FALSE. Defaults to TRUE. Whether or not to render the HTML table. If
#'   you are working on Rstudio (interactively) the table will be printed or Rstudio's viewer.
#'   If you are working on Rgui (interactively) the table will be printed on your default browser.
#'   If you set this to FALSE the HTML code will be printed on screen.
#'
#' @param add_data TRUE or FALSE. Defaults to TRUE. If set to true, the data.frame or matrix passed in
#'  \code{obj} will be added to the attributes. If set to FALSE, the object will be smaller, but
#'  \code{add_css_conditional_column} would not be applicable.
#'
#' @param theme Argument is Deprecated. Please use the add_theme function instead.
#'
#' @return A tableHTML object.
#'
#' @examples
#' tableHTML(mtcars)
#' tableHTML(mtcars, rownames = FALSE)
#' tableHTML(mtcars, class = 'table1')
#' tableHTML(mtcars, second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3')))
#' tableHTML(mtcars,
#'           widths = c(rep(50, 6), rep(100, 6)),
#'           second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3')))
#' tableHTML(mtcars, caption = 'This is a caption', footer = 'This is a footer')
#' tableHTML(mtcars,
#'           row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
#'           widths = c(200, rep(50, 5), rep(100, 6)),
#'           rownames = FALSE)
#' tableHTML(mtcars,
#'           rownames = FALSE,
#'           widths = c(140, rep(50, 11)),
#'           row_groups = list(c(10, 10, 12), c('Group 1', 'Group 2', 'Group 3')),
#'           second_headers = list(c(3, 4, 5), c('col1', 'col2', 'col3')))
#' tableHTML(mtcars, collapse = 'separate_shiny', spacing = '5px')
#' tableHTML(mtcars, collapse = 'separate', spacing = '5px 2px')
#'
#' @export
tableHTML <- function(obj,
                      rownames = TRUE,
                      class = paste0('table_', sample(1000:9999, 1)),
                      widths = NULL,
                      headers = NULL,
                      second_headers = NULL,
                      row_groups = NULL,
                      caption = NULL,
                      footer = NULL,
                      border = 1,
                      collapse = c('collapse', 'separate', 'separate_shiny'),
                      spacing = '2px',
                      escape = TRUE,
                      round = NULL,
                      replace_NA = NULL,
                      add_data = TRUE,
                      theme = NULL) {

  #CHECKS----------------------------------------------------------------------------------------
  #adding checks for obj
  if (is.matrix(obj)) {
   obj <- as.data.frame(obj)
  } else if (inherits(obj, 'data.frame')) {
   obj <- as.data.frame(obj)
  } else {
   stop('obj needs to be either a data.frame or a matrix')
  }

  if (!is.null(theme)) {
   stop('Argument is Deprecated. Please use the add_theme function instead.')
  }

  #need to capture the column classes at the very beginning ----Pausing checks for a line
  col_classes <- unname(sapply(obj, function(x) class(x)))

  #checks for rownames
  if (!rownames %in% c(TRUE, FALSE)) {
   stop('rownames argument needs to be either TRUE or FALSE')
  }

  #checks for second header
  if (!is.null(second_headers)) {
   if (!is.list(second_headers)) {
    stop('second_headers needs to be a list')
   }
   if (length(second_headers) != 2L) {
    stop('second_headers needs to be a list of length two')
   }
   if (!is.numeric(second_headers[[1]])) {
    stop("second_headers\'s first element needs to be numeric")
   }
   if (!is.character(second_headers[[2]])) {
    stop("second_headers\'s second element needs to be character")
   }
   if (length(second_headers[[1]]) != length(second_headers[[2]])) {
    stop("second_headers\'s  elements need to have the same length")
   }
  }

  #checks for widths
  if (rownames == TRUE & !is.null(widths) & is.null(row_groups)) {
   if (length(widths) != ncol(obj) + 1) stop('widths must have the same length as the columns + 1')
  } else if (rownames == FALSE & !is.null(widths) & is.null(row_groups)) {
   if (length(widths) != ncol(obj)) stop('widths must have the same length as the columns')
  } else if (rownames == TRUE & !is.null(widths) & !is.null(row_groups)) {
   if (length(widths) != ncol(obj) + 2) stop('widths must have the same length as the columns + 2')
  } else if (rownames == FALSE & !is.null(widths) & !is.null(row_groups)) {
   if (length(widths) != ncol(obj) + 1) stop('widths must have the same length as the columns + 1')
  }

  #check for the border argument
  if (!is.numeric(border)) stop('border needs to be an integer')
  border <- as.integer(border)

  #make sure collapse has the right argument
  collapse <- match.arg(collapse)

  #check the add_data argument
  ##TEST
  if (!is.logical(add_data) | !length(add_data) == 1) {
   stop("add_data must be either TRUE or FALSE")
  }

  #make sure the first character of spacing is a number
  if (collapse %in% c('separate', 'separate_shiny')) {
   distances <- gsub('\\s+', ' ', spacing)
   distances <- strsplit(distances, ' ')[[1]]
   for (i in distances) {
    if (is.na(as.numeric(sub('[[:alpha:]]+', '', i)))) {
     stop('distances in spacing need to start with a number e.g. "1px 2px"')
    }
   }
  }

  if (!is.null(headers)) {
   if (length(headers) != length(names(obj))) {
    stop('The length of the headers needs to be the same as number of columns of the data.frame')
   }
  }

  #------
  #taking care of headers
  if (is.null(headers)) {
   headers <- names(obj)
  }
  #------

  #escape character > and < in the data and headers because it will close or open tags
  if (escape) {
   obj[sapply(obj, is.fachar)] <- lapply(obj[sapply(obj, is.fachar)], function(x) {
    if (is.factor(x)) {
     temp_levels <- levels(x)
     x <- gsub('>', '&#62;', x)
     x <- gsub('<', '&#60;', x)
     temp_levels <- gsub('>', '&#62;', temp_levels)
     temp_levels <- gsub('<', '&#60;', temp_levels)
     factor(x, levels = temp_levels)
    } else {
     x <- gsub('>', '&#62;', x)
     x <- gsub('<', '&#60;', x)
     x
    }
   })
   headers <- gsub('>', '&#62;', force(headers))
   headers <- gsub('<', '&#60;', force(headers))
  }

  #make sure headers do not contain empty string
  headers[headers == ''] <- ' '

  #make sure headers do not contain duplicates
  #we fix that by adding white spaces which are ignored
  #in html
  headers <- fix_header_dupes(headers)

  #headers to be exported
  headers_exported <- headers

  #rounding numeric columns
  if (!is.null(round)) {
   if (!is.numeric(round)) stop('round needs to be an integer.')
   obj[sapply(obj, is.numeric)] <- lapply(obj[sapply(obj, is.numeric)], function(x) {
    x <- round(x, round)
    x
   })
  }

  #replacing NA values for character and factor columns
  if (!is.null(replace_NA)) {
   obj[sapply(obj, is.fachar)] <- lapply(obj[sapply(obj, is.fachar)], function(x) {
    if(is.factor(x)) {
     levels(x) <- c(levels(x), replace_NA)
     temp_levels <- levels(x)
     x[is.na(x)] <- replace_NA
     temp_levels[is.na(temp_levels)] <- replace_NA
     factor(x, levels = temp_levels)
    }
    x[is.na(x)] <- replace_NA
    x
   })
  }

  #HEADERS---------------------------------------------------------------------------------------

  #taking into account rownames
  if (rownames == TRUE) {
    headers <- paste('<tr>',
                     '  <th id="tableHTML_header_1"> </th>',
                     paste(vapply(seq_along(headers) + 1, function(x) {
                              paste0('  <th id="tableHTML_header_', x, '">',
                                    headers[x - 1],
                                    '</th>')
                              },
                              FUN.VALUE = character(1)),
                              collapse = '\n'),
                     '</tr>\n',
                     sep = '\n')
  } else {
    headers <- paste('<tr>',
                     paste(vapply(seq_along(headers), function(x) {
                              paste0('  <th id="tableHTML_header_', x, '">',
                                     headers[x],
                                     '</th>')
                              },
                              FUN.VALUE = character(1)),
                              collapse = '\n'),
                     '</tr>\n',
                     sep = '\n')
  }

  #SECOND HEADERS--------------------------------------------------------------------------------

  #adding second headers if available
  if (!is.null(second_headers)) {
    over_header <-
      paste('<tr>',
            paste(vapply(seq_along(second_headers[[1]]), function(x) {
                    paste0('  <th colspan=',
                           second_headers[[1]][x],
                           ' id="tableHTML_second_header_',
                           x,
                           '">',
                    second_headers[[2]][x],
                    '</th>')
                    },
                   FUN.VALUE = character(1)),
                  collapse = '\n'),
           '</tr>\n',
           sep = '\n')
  } else {
    over_header <- NULL
  }

  #TABLE'S BODY----------------------------------------------------------------------------------
  #adding body - using headers_exported here because headers is of length 1
  content <- lapply(seq_along(headers_exported), function(x) {
    paste0('  <td id="tableHTML_column_', x, '">', obj[[x]], '</td>\n')
  })

  #adding rownames in the body
  if (rownames == TRUE) {
    content <- c(list(paste0('  <td id="tableHTML_rownames">',
                             row.names(obj),
                             '</td>\n')),
                 content)
  }

  content <- cbind('<tr>\n', do.call(cbind, content), '</tr>')
  content <- paste(apply(content, 1, paste, collapse = ''), collapse = '\n')

  #WIDTHS----------------------------------------------------------------------------------------
  #setting column widths if any
  if (!is.null(widths)) {
   colwidths <- paste(
    vapply(widths, function(x) {
     paste0('<col width="', x, '">')
    }, FUN.VALUE = character(1)),
    collapse = '\n')
   colwidths <- paste0(colwidths, '\n')
  } else {
   colwidths <- NULL
  }

  #CAPTION---------------------------------------------------------------------------------------
  #adding a caption
  if (!is.null(caption)) {
   caption <- paste0('<caption>', caption, '</caption>\n')
  }

  #FOOTER----------------------------------------------------------------------------------------
  #adding a footer
  if (!is.null(footer)) {
   footer <- paste0('<caption id="footer" align="bottom">', footer, '</caption>\n')
  }

  #PUTTING IT ALL TOGETHER-----------------------------------------------------------------------
  #adding all the components in one html table

  htmltable <-
    htmltools::HTML(paste0('\n<table style="border-collapse:collapse;" class=',
                           class,
                           ' border=',
                           border,
                           '>\n',
                           caption,
                           footer,
                           colwidths,
                           '<thead>\n',
                           over_header,
                           headers,
                           '</thead>\n',
                           '<tbody>\n',
                           content,
                           '\n',
                           '</tbody>\n',
                           '</table>',
                           collapse = ''))

  #ADDING ROW GROUPS-----------------------------------------------------------------------------
  #adding row groups in table

  if (!is.null(row_groups)) {

   htmltable <-
    sub('<tr>\n  <th id="tableHTML_header_1">',
        '<tr>\n  <th id="tableHTML_header_0"></th>\n  <th id="tableHTML_header_1">',
        htmltable)

   rows <- Reduce('+', row_groups[[1]], accumulate = TRUE)
   rows <- c(1, rows[-length(rows)] + 1)

   if (!is.null(second_headers)) {
    rows <- rows + 3
   } else {
    rows <- rows + 2
   }

   splits <- strsplit(htmltable, '<tr')

   splits[[1]][2:length(splits[[1]])] <-
    vapply(splits[[1]][2:length(splits[[1]])], function(x) paste0('<tr', x),
           FUN.VALUE = character(1))

   splits[[1]][rows] <-
    mapply(function(x, y, z) {
     x <- sub('<tr>\n',
              paste0('<tr>\n  <td id="tableHTML_row_groups" rowspan="',
                     z,
                     '">',
                     y,
                     '</td>\n'
                     ),
              x)},
     splits[[1]][rows],
     row_groups[[2]],
     row_groups[[1]]
    )

   htmltable <- paste(splits[[1]], collapse = '')

   htmltable <- htmltools::HTML(htmltable)
  }

  #ADDING CLASS AND RETURNING--------------------------------------------------------------------
  #add class and attribute and then return htmltable
  class(htmltable) <- c('tableHTML', class(htmltable))
  attr(htmltable, 'headers') <- headers_exported
  attr(htmltable, 'nrows') <- nrow(obj)
  attr(htmltable, 'ncols') <- ncol(obj)
  attr(htmltable, 'col_classes') <- col_classes
  attr(htmltable, 'rownames') <- rownames
  attr(htmltable, 'row_groups') <- !is.null(row_groups)
  attr(htmltable, 'row_groups_data') <- row_groups
  attr(htmltable, 'second_headers') <- !is.null(second_headers)
  attr(htmltable, 'second_headers_data') <- second_headers
  attr(htmltable, 'table_class') <- class
  attr(htmltable, 'file_loc') <- tempfile(fileext = ".html")
  if (add_data) attr(htmltable, 'data') <- obj

  #Adding Collapse arg------------------------------------------------------------------------

  #Collapse table according to collapse argument
  if (collapse == 'separate') {
   htmltable <- replace_html(htmltable,
                             'style="border-collapse:collapse;"',
                             paste0('style="border-collapse:separate;border-spacing:',
                                    spacing,
                                    ';"'))
  }

  if (collapse == 'separate_shiny') {
   htmltable <- replace_html(
    htmltable,
    'style="border-collapse:collapse;"',
    paste0('style="border-collapse:separate !important;border-spacing:',
           spacing,
           '; !important"'))
  }

  #return
  htmltable
}

#DECLARING S3 METHOD FOR PRINT-----------------------------------------------------------------

#' @rdname tableHTML
#' @export
print.tableHTML <- function(x, viewer = TRUE, ...) {

 if (interactive() & viewer == TRUE) {

  rstudioviewer <- getOption("viewer")
  if (!is.null(attr(x, 'file_loc'))) {
    file <- attr(x, 'file_loc')
  } else {
    file <- tempfile(fileext = ".html")
  }
  htmlfile <- htmltools::HTML(paste('<html>\n<body>',
                                    x,
                                    '</body>\n</html>',
                                    sep = '\n'))
  cat(htmlfile, file = file)

  if (is.function(rstudioviewer)) {
   rstudioviewer(file)
  } else {
   utils::browseURL(file)
  }

 } else if (viewer == FALSE | !interactive()) {
  cat(x, ...)
 }

 invisible(x)

}



