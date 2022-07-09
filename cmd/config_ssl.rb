# frozen_string_literal: true

module Homebrew
  module_function

  def config_ssl; end

  def config_ssl
    cmd_path = __dir__

    puts "Setup p11-kit with opensc module"
    system  "echo module: $(brew --prefix opensc)/lib/pkcs11/opensc-pkcs11.so > " \
            "$(brew --prefix)/etc/pkcs11/modules/opensc.module"

    puts "Setup openssl with pkcs11 engine"
    system "sh", "#{cmd_path}/setup_openssl.sh"
  end
end
