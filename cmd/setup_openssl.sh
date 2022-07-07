#!/usr/bin/env bash
# setup pkcs11 engine for openssl
ETC=$(brew --prefix)/etc

CNF_FILE=$ETC/openssl@1.1/openssl.cnf
OPENSC_FILE=$(brew --prefix opensc)/lib/pkcs11/opensc-pkcs11.so
LIBP11_FILE=$(brew --prefix libp11)/lib/engines-1.1/libpkcs11.dylib
# TODO - Adjust for Linux libpkcs11.so

# prepend to orginal openssl.cnf 
cp -n $CNF_FILE $CNF_FILE.orig
echo 'openssl_conf = openssl_init' > $CNF_FILE
cat $CNF_FILE.orig >> $CNF_FILE

# append to original openssl.cnf
echo '# engine for pkcs11' >> $CNF_FILE
echo '[openssl_init]' >> $CNF_FILE
echo 'engines=engine_section' >> $CNF_FILE
echo '[engine_section]' >> $CNF_FILE
echo 'pkcs11 = pkcs11_section' >> $CNF_FILE
echo '[pkcs11_section]' >> $CNF_FILE
echo 'engine_id = pkcs11' >> $CNF_FILE
echo "dynamic_path = $LIBP11_FILE" >> $CNF_FILE
echo "MODULE_PATH = $OPENSC_FILE" >> $CNF_FILE
