class GitConfigCac < Formula
  desc "Setup CAC authentication over https for Git"
  homepage "https://weaponone.test.cce.af.mil/"
  url "https://github.com/bhencey/homebrew-extensions/archive/refs/tags/setup_cac_0.5.3.tar.gz"
  sha256 "403ceab3b61e229b52b61159a81a033be7a74b94c7c5d47cdd487006ce72d3cfbres"
  license ""

  depends_on "git-https-cac"
  depends_on "libp11"
  depends_on "opensc"
  depends_on "p11-kit"

  def install
    bin.install "git-config-cac"
  end

  test do
    assert_match "opensc-pkcs11.so", `ls $(brew --prefix opensc)/lib/pkcs11/`,
      "shared library opensc_pkc11.so doesn't exist"

    assert_match "libpkcs11.dylib", `ls $(brew --prefix libp11)/lib/engines-1.1/`,
      "shared library libpkcs11.dylib doesn't exist"

    assert !`which git| grep $(brew --prefix)`.nil?,
      "brewed git not default-- try: brew link git"

    assert_match "opensc", `p11-kit list-modules`,
      "p11-kit missing opensc module"

    assert_match "available", `$(brew --prefix openssl@1.1)/bin/openssl engine pkcs11 -t`,
      "openssl missing pkcs11 engine"

    assert_match "pkcs11", `$(brew --prefix curl)/bin/curl --engine list`,
      "curl missing pkcs11 engine"

    assert_match "openssl.cnf", `ls $(brew --prefix)/etc/openssl@1.1/`,
      "openssl.cnf file doesn't exist"

    assert_match "engine_id = pkcs11", `cat $(brew --prefix)/etc/openssl@1.1/openssl.cnf`,
      "openssl.cnf missing pkcs11 engine"
  end
end
