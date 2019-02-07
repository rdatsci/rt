context("packageToString")

test_that("packageToString and vice versa", {
  s = "checkmate"
  p = stringToPackage(s)
  expect_is(p, "Package")
  expect_is(p, "PackageCran")
  expect_equal(p$name, "checkmate")
  expect_equal(packageToString(p), s)

  s = "mllg/checkmate"
  p = stringToPackage(s)
  expect_is(p, "Package")
  expect_is(p, "PackageGitHub")
  expect_equal(p$handle, "mllg/checkmate")
  expect_equal(p$name, "checkmate")
  expect_equal(packageToString(p), paste0("github:", s))

  s = "github:mllg/checkmate@v1.8.4"
  p = stringToPackage(s)
  expect_is(p, "Package")
  expect_is(p, "PackageGitHub")
  expect_equal(p$handle, "mllg/checkmate@v1.8.4")
  expect_equal(p$name, "checkmate")
  expect_equal(packageToString(p), s)

  s = "github:mllg/checkmate@v1.8.4/somewhere/deep"
  p = stringToPackage(s)
  expect_is(p, "Package")
  expect_is(p, "PackageGitHub")
  expect_equal(p$handle, "mllg/checkmate@v1.8.4/somewhere/deep")
  expect_equal(p$name, "checkmate")
  expect_equal(packageToString(p), s)

  s = "https://github.com/mllg/checkmate.git"
  p = stringToPackage(s)
  expect_is(p, "Package")
  expect_is(p, "PackageGit")
  expect_false(inherits(p, "PackageGitHub"))
  expect_equal(p$repo, "https://github.com/mllg/checkmate.git")
  expect_equal(p$name, "checkmate")
  expect_equal(p$ref, "")
  expect_equal(p$subdir, "")
  expect_equal(packageToString(p), s)

  s = "https://github.com/mllg/checkmate.git@v1.8.4/somewhere/deep"
  p = stringToPackage(s)
  expect_is(p, "Package")
  expect_is(p, "PackageGit")
  expect_equal(p$repo, "https://github.com/mllg/checkmate.git")
  expect_equal(p$name, "checkmate")
  expect_equal(p$ref, "v1.8.4")
  expect_equal(p$subdir, "somewhere/deep")
  expect_equal(packageToString(p), s)

  expect_error(stringToPackage("http://checkmate.de"), "unknown")
})
