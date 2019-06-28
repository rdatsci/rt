context("rinstall")

# installs package `s` with name `name` and removes it
test_basic_rinstall = function(s, name, ...) {
  expect_true(suppressMessages(rinstall(s, force = TRUE)), ...)
  expect_true(name %in% rownames(installed.packages()), ...)
  expect_true(suppressMessages(rremove(name)), ...)
  expect_true(!(name %in% rownames(installed.packages())), ...)
}

test_that("rinstall works for remote packages", {
  skip_on_cran()
  pkgs = list(
    list(str = "rdatsci/rt/tests/testthat/assets/package", name = "testpkg", type = "GitHub"),
    list(str = "rdatsci/rt/tests/testthat/assets/package@master", name = "testpkg", type = "GitHub"),
    list(str = "https://github.com/rdatsci/rt.git/tests/testthat/assets/package", name = "testpkg", type = "Git"),
    list(str = "https://github.com/rdatsci/rt.git/tests/testthat/assets/package@master", name = "testpkg", type = "Git")
  )
  for (pkg in pkgs) {
    test_basic_rinstall(pkg$str, pkg$name, info = pkg$str)
  }
})

test_that("rinstall works for local packages", {
  skip_on_cran()
  test_basic_rinstall("./assets/package", "testpkg")
})

test_that("rinstall works for local packages on windows", {
  skip_on_os(c("mac", "linux", "solaris"))
  skip_on_cran()
  test_basic_rinstall(".\\assets\\package", "testpkg")
})
