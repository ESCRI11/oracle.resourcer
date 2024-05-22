.onAttach <- function(libname, pkgname) {
  resourcer::registerResourceResolver(OracleResourceResolver$new())
}

.onDetach <- function(libpath) {
  resourcer::unregisterResourceResolver("OracleResourceResolver")
}