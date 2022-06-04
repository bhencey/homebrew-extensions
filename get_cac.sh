#~/bin/sh
KEYID=PIV%20Authentication
CACCERT=( $(p11tool --list-tokens | grep -oe "token=$LNAME\+[a-zA-Z0-9._]\+") )
set | grep CACCERT > cac_token.sh
CACKEY=( $(p11tool --list-all-certs pkcs11:$CACCERT | grep -oe "$CACCERT\+[a-zA-Z0-9=%.;]\+$KEYID") )
set | grep CACKEY >> cac_token.sh
