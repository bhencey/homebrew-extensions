#!/usr/bin/env bash
# setup pkcs11 engine for openssl
HOMEBREW_PREFIX=$1
etc=$HOMEBREW_PREFIX/etc

CNF_FILE=$etc/openssl@1.1/openssl.cnf
echo "TODO check $CNF_FILE exists"
echo
LIBP11_FILE=( $(brew info libp11 | grep -oe '[./a-zA-Z]\+/libp11/\+[0-9.]\+')/lib/engines-1.1/libpkcs11.dylib )
echo "TODO check whether $LIBP11_FILE exists"
echo
OPENSC_FILE=( $(brew info opensc | grep -oe '[./a-zA-Z]\+/opensc/\+[0-9.]\+')/lib/pkcs11/opensc-pkcs11.so )
echo "TODO check whether $OPENSC_FILE exists"
echo

# prepend
cp -n $CNF_FILE $CNF_FILE.orig
echo 'openssl_conf = openssl_init' > $CNF_FILE
cat $CNF_FILE.orig >> $CNF_FILE

# append
echo '# engine for pkcs11' >> $CNF_FILE
echo '[openssl_init]' >> $CNF_FILE
echo 'engines=engine_section' >> $CNF_FILE
echo '[engine_section]' >> $CNF_FILE
echo 'pkcs11 = pkcs11_section' >> $CNF_FILE
echo '[pkcs11_section]' >> $CNF_FILE
echo 'engine_id = pkcs11' >> $CNF_FILE
echo "dynamic_path = $LIBP11_FILE" >> $CNF_FILE
echo "MODULE_PATH = $OPENSC_FILE" >> $CNF_FILE
