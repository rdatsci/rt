% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rupdate.r
\name{rupdate}
\alias{rupdate}
\title{Update packages}
\usage{
rupdate(rebuild = FALSE, neverupgrade = FALSE, savemode = FALSE)
}
\arguments{
\item{rebuild}{[\code{logical(1)}]\cr
Rebuild R packages which are built using a different version of R.}

\item{neverupgrade}{[code{logical(1)}]\cr
Passed to \code{\link[remotes]{update_packages}} as \code{upgrade = ifelse(neverupgrade, "never", "always")}.
Default is \dQuote{FALSE} so all dependencies are upgraded.}

\item{savemode}{[code{logical(1)}]\cr
Works slower but should handle most conflicts.
Might be helpful after R-Version update or if packages are removed from CRAN.}
}
\value{
Invisibly returns \code{TRUE} on success.
}
\description{
Update packages. This includes multiple steps:
\itemize{
  \item{1.}{All outdated CRAN packages will be updated.}
  \item{2.}{New packages from \code{\link{getConfigPath}("packages")} will be installed.}
  \item{3.}{Non-CRAN packages will be updated.}
  \item{4.}{If \code{rebuild} is set to \code{TRUE}, all packages which
     are built under a different R version will be rebuilt with the current.}
}
The collection file \code{\link{getConfigPath}("packages")} expects one package per line specified in a format
which is parseable by \code{\link{stringToPackage}}. Leading and trailing whitespace characters
will automatically be trimmed. Empty lines and lines starting with a \dQuote{#} will be ignored.
}
