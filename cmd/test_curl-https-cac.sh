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

# put together cert and key
SSL_CERT="pkcs11:token=$TOKEN"
SSL_KEY="$SSL_CERT;id=$ID_NUMB"

echo
echo
echo Using Public Key:   $SSL_CERT
echo Using Private Key:  $SSL_KEY
echo Using URL: $URL
echo
echo
# set verbosity for cac authentication
#export OPENSC_DEBUG=3

# explicitly passing flags
echo Testing curl with flags
curl -v --engine pkcs11 --cert $SSL_CERT --cert-type $ENG --key $SSL_KEY --key-type ENG $URL

# set curl option flags
export CULROPT_SSLCERT=$SSL_CERT
export CURLOPT_SSLKEY=$SSL_KEY
export CURLOPT_SSLCERTTYPE=ENG
export CURLOPT_SSLKEYTYPE=ENG
export CURLOPT_SSLENGINE=pkcs11

echo Testing cur with environment variables
curl -v $URL

