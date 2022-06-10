# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GitConfigCac < Formula
  desc ""
  homepage ""
  #url "https://github.com/bhencey/homebrew-extensions/archive/refs/tags/setup_cac_0.4.tar.gz"
  url "https://gitlab.rdte.afrl.dren.mil/henceybm/homebrew-extensions/-/archive/setup_cac_0.4/homebrew-extensions-setup_cac_0.4.tar.gz"
  sha256 "ed3c77d5603e534ac62fca5dc674772d3c3c031f8318e5c726937c2fef9383ea"
  license ""
  
  depends_on "opensc"
  depends_on "gnutls"
  depends_on "git-https-cac"

  def install
    bin.install "git-config-cac"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test homebrew-extensions`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
