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
    assert `which git | grep "$(brew --prefix)"`!=nil, "Using brewed git"
    assert `p11-kit list-modules`.chomp.match(/opensc/), "OpenSC module installed for p11-kit"
    assert `openssl engine pkcs11 -t`.chomp.match(/available/), "OpenSSL has pkcs11 engine"
    assert `curl --engine list`.chomp.match(/pkcs11/), "curl sees OpenSSL's pkcs11 engine"
    # puts "Setup p11-kit with opensc module"
    # system "echo module: #{HOMEBREW_PREFIX}/Cellar/opensc/*/lib/opensc-pkcs11.so >#{HOMEBREW_PREFIX}/etc/pkcs11/modules/opensc.module"
    
    # system "false"
  end
end
