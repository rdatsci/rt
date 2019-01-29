# rt: R Tools for the Command Line

This package ships some command line utilities which simplify working with R packages from the command line.
Many commands *rt* provides are just wrappers around , e.g. [remotes](https://github.com/r-lib/remotes) and [testthat](https://github.com/r-lib/testthat).
They ensure a valid exit code which is required to use these commands for shell scripting.
You find additional packages via [R infrastructure](https://github.com/r-lib).
Furthermore, *rt* allows you to maintain a collection of you favorite packages in a plain text file which you can add to your [dotfiles](https://dotfiles.github.io/) and share across systems.
This file may also contain git sources to keep you up to date with packages not yet released on CRAN.


## Available Commands
* `rbuild` to bundle a local package.
* `rcheck` to check a local package.
* `rclean` to remove `.[o|so]` files from a local package.
* `rcov` to test the coverage of a local package.
* `rdoc` to document a local package using roxygen.
* `rhub` to upload a local package to rhub service.
* `rinstall` to install a remote package, e.g. a package hosted on CRAN or GitHub.
* `rknit` to knit a document (.Rnw, .Rmd, ...) via rknit.
* `rmake` to make a local package (document and install).
* `rpkgdown` to build static HTML documentation with [pkgdown](https://github.com/hadley/pkgdown).
* `rremove` to remove (uninstall) R packages.
* `rshine` to run a shiny app.
* `rspell` to check spelling in generated .Rd files.
* `rtest` to test a local package.
* `rupdate` to update all CRAN packages on your system, install missing CRAN packages listed in your collection `~/.rt/packages` and update all packages with a git source.
* `rusage` to check variable usage.
* `rwinbuild` to upload a local package to the winbuilder service.

Call the respective command with `--help` to list available command line arguments.
All commands are also available as regular R functions, using the same names.


## Setup
First, you need to install *rt* itself.
Using a personal library (e.g., `echo 'R_LIBS_USER=~/.R/library' >> ~/.Renviron`) is strongly advised.
```r
install.packages("remotes")
remotes::install_github("rdatsci/rt")
```
Alternatively, if you start from scratch and do not have [remotes](https://github.com/r-lib/remotes) installed, run the following command in your shell:
```{sh}
Rscript -e 'install.packages("remotes", repos = "http://cloud.r-project.org/")'
Rscript -e 'remotes::install_github("rdatsci/rt")'
```

The *rt* command line scripts are now installed in the subdirectory `rt/bin` of your R library (call `.libPaths()` in R if
unsure about its location). You need to add this directory to your `PATH` variable, see the section below that applies to you.


### On Linux
Add this directory to your `PATH` in your `.bashrc`, `.zshrc` or `config.fish`:
```sh
# bash
PATH=~/.R/library/rt/bin:$PATH

# zsh
path=(~/.R/library/rt/bin $path)

# fish
if test -d ~/.R/library/rt
    set -gx PATH $HOME/.R/library/rt/bin $PATH
end
```


### On Windows
Add this directory to your `PATH` variable in the system environment via the control panel.
As an alternative use the admin console command:
```
SETX /M PATH "%PATH%;path-to-rt-repository/win"
```
(Option `/M` changes the `PATH` in `HKEY_LOCAL_MACHINE` instead of `HKEY_CURRENT_USER`).
If it does not work for you, try it without the `/M` option.
In any case you need to open a new windows prompt or terminal windows in order to reload the `PATH` variable.


### Continue for both Systems
After sourcing this file (or after a re-login) you should be all set to use *rt*.

To keep *rt* updated, you can let it maintain itself via `rupdate` by adding it to your collection file `~/.rt/packages`.
To do this, first initialize an empty collection with
```sh
rt init
```
and then uncomment the respective line with your favorite text editor.
To add more packages to your collection, see `?rupdate` for a format description of this file.
Note that packages with a git source will be kept in `~/.rt/git` and only reinstalled if the remote repository has been updated.
