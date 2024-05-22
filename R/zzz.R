.onAttach <- function(libname, pkgname) {
  resourcer::registerDBIResourceConnector(OracleDBResourceConnector$new())
}
