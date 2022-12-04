#' Class \code{smet}
#'
#' class representing the SMET format file for weather station data
#'  \describe{
#'     \item{\code{signature}:}{A charachter string containing SMET signature}
#'
#'     \item{\code{header}:}{Object of class \code{"list"} containing the Header Section,
#'      each key corresponds to an appropriately named element of the list.}
#'     \item{\code{data}:}{A \code{"data.frame"} containing the weather data values.
#'      The datetime field is called \code{"timestamp"} and stored in \code{\link{POSIXct}} format.}
#'
#' 	   \item{\code{file}:}{source. Either full name of the SMET file
#' 	    or other source description like an url.}
#'  }
#'
#' Detailed information about SMET format is described in \url{https://models.slf.ch/docserver/meteoio/SMET_specifications.pdf}.
#' Not all features of the SMET format are implemented:
#' * no binary data
#' * only numeric data are supported, except for timestamp
#' * no comments within the [DATA] section.
#'
#' @seealso \code{\link{smet}},\code{\link{print.smet}}
#'
#' @references \url{https://models.slf.ch/docserver/meteoio/SMET_specifications.pdf}
#'
#'
#' @note A \code{smet-class} object can be created from a SMET file via
#' function \code{\link{smet}}
#'
#'
#' @docType class
#' @title smet-class
#'
#' @keywords classes
#'
#' @author Reinhold Koch
#' @aliases smet-class
#' @name smet-class
#' @rdname smet-class
#' @exportClass smet
#'
#' @seealso \code{\link{smet-class}}
#' @examples
#'
#' showClass("smet")
#'

setClass("smet",
         slots = c(signature="character",
                   header="list",
                   data="data.frame",
                   file="character"),
         prototype = list(signature='', header=list(), data=data.frame(), file='')
         )

setGeneric("signature", function(x) standardGeneric('signature'))
setMethod("signature", "smet", function(x) x@signature)
setGeneric("header", function(x) standardGeneric('header'))
setMethod("header", "smet", function(x) x@header)
setGeneric("data", function(x) standardGeneric('data'))
setMethod("data", "smet", function(x) x@data)
setGeneric("source", function(x) standardGeneric('source'))
setMethod("source", "smet", function(x) x@file)

smet <- function(file, signature='SMET 1.1 ASCII', header=list(), data=data.frame()) {
  methods::new(signature=signature, header=header, data=data, file=file)
}

setValidity('smet', function(object) {
  if (stringr::str_split_fixed(stringr::str_squish(signature(object)), '\\s', n=3)[[3]]
      != 'ASCII')
    return('Only SMET files in ASCII format are accepted')
})
