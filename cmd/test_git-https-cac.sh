#~/bin/sh
while getopts t:i:u flag
do
  case "${flag}"
    in
    t) TOKEN=${OPTARG};;
    i) ID_NUMB=${OPTARG};;
    u) URL=${OPTARG};;
  esac
done

$ put together cert and key
SSL_CERT="pkcs11:token=$TOKEN"
SSL_KEY="$SSL_CERT;id=$ID_NUMB"

echo
echo
echo Using Public Key: $GIT_SSL_CERT
echo Using Private Key:$GIT_SSL_KEY
echo
echo

# set verbasity for git trace
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1

# set verbosity for cac authentiaction
#export OPENSC_DEBUG=3

# export GIT_SSL_CERT_PASSWORD_PROTECTED=1
export GIT_SSL_CERT=$SSL_CERT
export GIT_SSL_KEY=$SSL_KEY
export GIT_SSL_KEYTYPE=ENG
export GIT_SSL_CERTTYPE=ENG
export GIT_SSL_ENGINE=PKCS11
export GIT_SSL_BACKEND=openssl

git fetch $URL
