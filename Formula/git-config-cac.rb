class GitConfigCac < Formula
  desc "Setup CAC authentication over https for Git"
  homepage "https://weaponone.test.cce.af.mil/"
  url "https://gitlab.rdte.afrl.dren.mil/henceybm/homebrew-extensions/-/archive/setup_cac_0.4/homebrew-extensions-setup_cac_0.4.tar.gz"
  sha256 "1cde121a2cf2fada1c8ac5a6a54b11989b9b20a10cab545da8a4d73481438c88"
  license ""

  depends_on "git-https-cac"
  depends_on "gnutls"
  depends_on "opensc"

  def install
    bin.install "git-config-cac"
  end

  test do
    assert !`which git| grep $(brew --prefix)`.nil?, "Not using brewed git "
    assert_match "opensc", `p11-kit list-modules`, "OpenSC module not installed for p11-kit"
    assert_match "available", `$(brew --prefix openssl@1.1)/bin/openssl engine pkcs11 -t`,
      "OpenSSL does not have pkcs11 engine"
    assert_match "pkcs11", `$(brew --prefix curl)/bin/curl --engine list`,
      "curl does not see OpenSSL's pkcs11 engine"
  end
end
