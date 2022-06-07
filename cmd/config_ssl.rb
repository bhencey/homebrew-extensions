# frozen_string_literal: true

module Homebrew
  module_function

  def conf_ssl_args
  end
  
  def config_ssl
    cmd_path = __dir__
    # puts cmd_path
    # args = temp_args.parse
 
    puts "Setup p11-kit with opensc module"
    system "echo module: #{HOMEBREW_PREFIX}/Cellar/opensc/*/lib/opensc-pkcs11.so >#{HOMEBREW_PREFIX}/etc/pkcs11/modules/opensc.module"
    
    puts "Setup openssl with pkcs11 engine"
    system "sh #{cmd_path}/setup_openssl.sh #{HOMEBREW_PREFIX}"

    if !`p11-kit list-modules`.chomp.match(/opensc/)
      puts "p11-kit missing opensc module"
    end
    if !`openssl engine pkcs11 -t`.chomp.match(/available/)
      puts "openssl missing pkcs11 engine"
    end
    if !`curl --engine list`.chomp.match(/pkcs11/)
      puts "curl missing pkcs11 engine"
    end

   end

end
