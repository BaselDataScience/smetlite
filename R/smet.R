# functions around smet class

#' Read a SMET file into a smet dataframe
#'
#' @param filename file or connection to be read by readr::read_table()
#'
#' @return dataframe with all
#' @export
#'
#' @examples read_smet(system.file('examples/test.smet', package = 'smetlite'))
read_smet <- function(filename) {
  tmp <- readLines(filename, n = 999, warn = FALSE,
                   encoding = 'UTF-8')
  smet_version <- tmp[1]

  # determine line number of section headers
  i_data <- grep('^\\[DATA\\]', tmp)
  i_header <- grep('^\\[HEADER\\]', tmp)
  # work on smet header
  tmp <- tmp[(i_header+1):(i_data-1)]
  tmp <- sub('[;#].*', '', tmp)
  tmp <- tmp[grepl('=', tmp, fixed = TRUE)]

  xx <- stringr::str_split_fixed(tmp, '=', n = 2)
  yy <- structure(sub('\\s', '', xx[,2]), names=stringr::str_squish(xx[,1]))
  nm <- unique(names(yy))
  header <- structure(lapply(lapply(nm, function(X) names(yy)==X),
                             function(X) paste(yy[X], collapse = '\n')),
                      names=nm)

  # remove leading and trailing whitespace and uniquify repeated whitespace within
  for (x in setdiff(nm, 'note')) header[[x]] <- stringr::str_squish(header[[x]])

  # vectorise
  for (x in intersect(c('fields', 'units_multiplier', 'units_offset'), nm))
    header[x] <- stringr::str_split(header[x], '\\s', n=Inf)

  # convert numeric coordinates
  for (x in intersect(c('altitude', 'easting', 'latitude', 'longitude', 'northing',
                        'tz', 'units_multiplier', 'units_offset', 'nodata'), nm))
    header[[x]] <- vapply(str2expression(header[[x]]), eval, double(1))
  if (!is.null(header$epsg)) header$epsg <- as.integer(header$epsg)


  # read the data
  col_types <- structure(rep(list(readr::col_double()), each=length(header$fields)),
                         names = header$fields)
  col_types$timestamp <- readr::col_datetime()
  dat <- readr::read_table(filename,
                           skip = i_data,
                           col_names = header$fields,
                           col_types = col_types,
                           locale = readr::locale(tz='UTC')
                           )

  # convert timestamp to UTC timezone
  if (!is.null(header$tz)) dat$timestamp <- dat$timestamp - header$tz * 3600

  # make sure nodata is interpreted as NA
  dat[dat==header$nodata] <- NA

  # back to MKSA units
  adj_mult <- header$units_multiplier != 1
  dat[, adj_mult] <- dat[, adj_mult] * rep(header$units_multiplier[adj_mult], each=nrow(dat))
  adj_add <- header$units_offset != 0
  dat[, adj_add] <- dat[, adj_add] + rep(header$units_offset[adj_add], each=nrow(dat))

  # attach metadata as attributes
  attr(dat, 'signature') <- smet_version
  attr(dat, 'header') <- header
  attr(dat, 'file') <- filename
  attr(dat, 'class') <- c('smet', attr(dat, 'class', exact = TRUE))
  dat
}

#' retrieve header
#'
#' @param smet object of class smet
#'
#' @return named list of header information
#' @export
#'
#' @examples header(read_smet(system.file('examples/test.smet', package = 'smetlite')))
header <- function(smet) {
  attr(smet, 'header')
}
