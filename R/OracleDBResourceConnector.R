#' OracleDB DBI resource connector
#'
#' Makes a OracleDB DBI connection from a resource description.
#'
#' @docType class
#' @format A R6 object of class OracleDBResourceConnector
#' @import R6
#' @import httr
#' @export
OracleDBResourceConnector <- R6::R6Class(
  "OracleDBResourceConnector",
  inherit = DBIResourceConnector,
  public = list(

    #' @description Creates a new OracleDBResourceConnector instance.
    #' @return A OracleDBResourceConnector object.
    initialize = function() {},

    #' @description Check that the provided resource has a URL that locates a Oracle object: the URL scheme must be "oracle".
    #' @param resource The resource object to validate.
    #' @return A logical.
    isFor = function(resource) {
      super$isFor(resource) && super$parseURL(resource)$scheme %in% c("oracle")
    },

    #' @description Creates a DBI connection object from a resource.
    #' @param resource A valid resource object.
    #' @return A DBI connection object.
    createDBIConnection = function(resource) {
      if (self$isFor(resource)) {
        super$loadDBI()
        private$loadROracle()
        driver <- DBI::dbDriver("Oracle")
        url <- super$parseURL(resource)
        DBI::dbConnect(driver, host = url$host, port = url$port,
                       username = resource$identity, password = resource$secret,
                       dbname = super$getDatabaseName(url))
      } else {
        stop("Resource is not located in a Oracle database")
      }
    }

  ),
  private = list(
    loadROracle = function() {
      if (!require("ROracle")) {
        install.packages("ROracle", repos = "https://cloud.r-project.org", dependencies = TRUE)
      }
    }
  )
)