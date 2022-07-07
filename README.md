# Homebrew Extensions
This software simplifies installation, configuration, and usage of CAC functionality with DevOps workflows on MacOS and Linux systems. The software consists of scripts for the [Homebrew](https://brew.sh/) package manager, which automate the installation and configuration of required open source packages needed for CAC authentication. The scripts include Ruby scripts, Shell scripts, and a generic diff/patch for git.

## Disclaimer
Use the formulae and scripts at your own risk. Although significant effort has been made to avoid issues, there may be unexpected side effects for different system/platform configurations.

## Approach
The basic approach for CAC authentication is built on several standard and stable open source projects:
* Install
[OpenSC](https://github.com/OpenSC/OpenSC/wiki) and
[p11-kit](https://p11-glue.github.io/p11-glue/p11-kit.html) (using
[GnuTLS](https://www.gnutls.org/))
for smart card access.
* Configure p11-kit with an opensc module definition.
*	Install
`curl--with-openssl` since the built-in version of [curl](https://curl.se/) is linked to
[libressl](https://www.libressl.org/).
*	Configure
[OpenSSL](https://github.com/openssl/openssl)
with a pkcs11 engine definition.
*	Install a patched version of [Git](https://github.com/git/git) that uses curl--with-openssl.

## What's in the tap?
The tap contains following Homebrew formulae and commands:
* `git-https-config` formula: Install the packages needed to access your CAC and configure your git repo CAC authentication.
* `git-https-cac` formula: Install a patched version of Git that passes http config elements to curl.
*	`config_ssl` command: Setup an opensc module for p11-kit and a pkcs11 engine for openssl.


Sound like a lot? Thankfully, you only need the following commands to setup a git repository with CAC access:
```
brew install git-https-config
brew setup_openssl
git-config-cac -l $LASTNAME -m config
```
## Formula and external commands: git-https-config
This formula installs a helper shell script for extracting pkcs11 URI from a CAC by running the terminal command:
```
brew install git-https-config
```
Note, this formula installs `opensc`, `gnutls`, and `git-https-cac` (see below) formulae as required dependencies. After installing the formula, the Hombrew command `config_ssl` (discussed below) will setup a pkcs11 engiine for openssl.

The local git repo is configured to use your CAC's PIV authentication by running the command:
```
git-config-cac -l $LASTNAME -m config
```

Troubleshoot git
```
git-config-cac -l $LASTNAME -m test_git -u $HTTPS_GIT_URL
```
More verbose troubleshooting via curl:
```
git-config-cac -l $LASTNAME -m test_curl -u $HTTPS_GIT_URL
```

## Command: config_ssl
This Homebrew command enables openssl to use a smartcard by running the terminal command:

```
brew config_ssl
```

This includes the following steps:
* Define a config file for an opensc module for p11-kit.
* Augment the openssl config file to setup an pkcs11 engine.
## Formula: git-https-cac
This formula installs patched version of git that enables CAC-based authentication over https. In additional to git's normal dependencies, this formula installs curl linked to openssl 1.1, rather than the built-in curl linked to libressl. The formula is installed with the terminal command:
```
brew install git-https-cac
```

The location of the public and private keys are specified by `http.sslcert` and `http.sslkey`, respectively. The public and private key locations are passed to curl, and it assumes it is being passed file paths rather than pkcs11 URIs (universal resource indictaors). The patch enables `git` to pass the additional configuration elements `http.sslcerttype`, `http.sslkeytype`, and `http.sslengine` so `curl` can properly interprets the public and private key locations as pkcs11 URIs. Alternatively, the patched git also supports passing the shell variables `GIT_SSL_KEYTYPE`, `GIT_SSL_CERTTYPE`, and `GIT_SSL_ENGINE` to help clarify the `GIT_SSL_CERT` and `GIT_SSL_KEY`.

This patch was based on Brett Stahlman [CAC-Enabled-Git-Setup](https://github.com/bpstahlman/cac-enabled-git-setup).

## Documentation
For more details of [installation](INSTALL.md).
`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

Distribution Statement A: Approved for Public Release; Distribution is Unlimited. PA# AFRL-2022-3020
