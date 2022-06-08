# Bhencey Extensions

## How do I setup the tap?
`brew tap bhencey/extensions`
## What's in the tap?
The tap contains following:
* git-https-cac formula: This formula installs a patched version of git that enables uses of CAC cards over https.
* git-https-config formula: This formula installs a helper shell script for extracting pkcs11 URI from a CAC.
* config_ssl command: Setup opensc module for p11-kit and pkcs11 engine for openssl.
## What's the setup process?
The approach involves the following:
* Install opensc and p11-kit for smart card access.
* Setup an opensc module for p11-kit.
* Install curl--with-openssl. That is, the native version doesn't use openssl.
* Setup a opensc engine for openssl.
* Install a patched version of git linked to the curl--with-openssl.
Thankfully, you only need the following commands:

`brew install git-https-config`

`brew setup_openssl`

`git-config-cac -l $LASTNAME -m config`

## Formula: git-https-config
This formula installs a helper shell script for extracting pkcs11 URI from a CAC. The the script uses the utilities provided by opensc and p11-kit to access the CAC.

Setup git's local config to use CAC card.

`git-config-cac -l $LASTNAME -m config`

Troubleshoot git using curl:

`git-config-cac -l $LASTNAME -m test_curl -u $HTTPS_GIT_URL`

Troubleshoot git:

`git-config-cac -l $LASTNAME -m test_git -u $HTTPS_GIT_URL`

## Formula: git-https-cac
This is a patched version of git that enables uses of CAC cards over https. In additional to git's normal dependencies, this formula uses openssl and curl, rather than the built-in libssl and curl.

The location of the public and private keys are specified by `http.sslcert` and `http.sslkey`, respectively. However, git expects them to be files rather than pkcs11 URIs (universal resource indictaors). The patch enables `git` to pass the additional configuration elements `http.sslcerttype`, `http.sslkeytype`, and `http.sslengine` so `curl` can properly interprets the public and private key locations as pkcs11 URIs.

Alternatively, the patch also supports passing the shell variables `GIT_SSL_KEYTYPE`, `GIT_SSL_CERTTYPE`, and `GIT_SSL_ENGINE` to help clarify the `GIT_SSL_CERT` and `GIT_SSL_KEY`.

## Command: config_ssl
Setup opensc module for p11-kit and pkcs11 engine for openssl.
* Setup an opensc module for p11-kit.
* Setup a opensc engine for openssl.

`brew config_ssl`

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

