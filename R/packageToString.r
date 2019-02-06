packageToString = function(pkg) {
  UseMethod("packageToString")
}

#' @export
packageToString.default = function(pkg) {
  if (testString(pkg))
    return(pkg)
  stop("No method found to convert package to a string: ", pkg)
}

#' @export
packageToString.PackageCran = function(pkg) {
  pkg$name
}

#' @export
packageToString.PackageLocale = function(pkg) {
  pkg$file_path
}

#' @export
packageToString.PackageGit = function(pkg) {
  subdir = ifelse(is.na(pkg$subdir), "", pkg$subdir)
  ref = ifelse(is.na(pkg$ref), "", paste0("@", pkg$ref))
  paste0(pkg$repo, pkg$ref, pkg$subdir)
}

#' @export
packageToString.PackageGitHub = function(pkg) {
  paste0("github:", pkg$handle)
}

#' @export
packageToString.PackageGitLab = function(pkg) {
  host = ifelse(is.na(pkg$host), "", sprintf("(%s):", pgk$host))
  paste0("gitlab:", host, pkg$handle)
}
