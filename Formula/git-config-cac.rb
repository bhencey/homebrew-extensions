# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GitConfigCac < Formula
  desc ""
  homepage ""
  url "https://github.com/bhencey/homebrew-extensions/archive/refs/tags/setup_cac_0.2.tar.gz"
  sha256 "022552fa65bc49a02ac97fb54568115a3b98909c89b9fb45bb92d5f45abed18f"
  license ""
  
  depends_on "opensc"
  depends_on "gnutls"
  depends_on "git-https-cac"

  #def install
    #bin.install "setup_cac"
    #system "patch -b #{etc}/openssl@1.1/opensssl.cnf diffs/openssl_cnf.diff"
  #end

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
