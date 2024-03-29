# Installation Notes
## Disclaimer
Use the formulae and scripts at your own risk. Although significant effort has been made to avoid issues, there may be unexpected side effects for different system/platform configurations.

## Setup Homebrew in Your User-Space
This is a crucial step if you aren't a `sudo` user, or you simply want to ensure Homebew does not modify system files. The following adapts the steps for [Untar Anwyere](https://docs.brew.sh/Installation#untar-anywhere). Run the following commands:
```
BREWPATH="$HOME/.brew"
echo "Downloading Homebrew to $BREWPATH"
git clone --depth=1 https://github.com/Homebrew/brew $BREWPATH
echo "---------------------------------------------------------"
echo "Temporarily setting environment variables..."
test -d $BREWPATH && eval "$($BREWPATH/bin/brew shellenv)"
echo "Adding to envirnonment variables to profile..."
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
```

Finally, run the terminal command:
```
brew doctor
```
## Some Preliminaries
First, run the following terminal commands to define some convenient shell variables:

```
ORG_NAME="bhencey"
TAP_NAME="extensions"
HB_TAP="$ORG_NAME/$TAP_NAME"
TAP_PATH="$ORG_NAME/homebrew-$TAP_NAME"
```

## Automatically Install Tap
If you found this page on github: `https://github.com/$TAP_PATH`. Then simply download the tap by running the following in your terminal.

```
brew tap $HB_TAP
```

## Manually Install Tap
If it's on an authenticated repository, it's going to take a few more steps.

### Download the Tap as a Zip or Tar Ball
In your browser, navigate to the `dev` or `main` branch in the repo and download the zip or tar ball file for that branch. Next, unzip/unpack the compressed file,  and setup a handy dandy shell variable by running the terminal command:
```
UNPACK_DIR=<<Folder Path Here>>
```
**Hint:** You can drag the folder onto the terminal window to automatically fill in the `<<Folder Path Here>>` in the above.

### Add the Tap to Homebrew
Now, let's move the unpacked tap to the location of the new tap:
```
echo "creating new local tap: $HB_TAP"
brew tap-new $HB_TAP
echo "moving $UNPACK_DIR to $(brew --repository $HB_TAP)"
mv $UNPACK_DIR $(brew --repository $HB_TAP)
```
### Download GIT-CONFIG-CAC Files
In browser, navigate to the `setup_cac` branch and download the zip or tar ball file for the branch. We need to download the files that are installed by the formula. Navigate
```
SETUP_CAC_ZIP=<<File Path Here>>
```
```
echo "moving $SETUP_CAC_ZIP to $(brew --cache -s $HB_TAP/git-config-cac)"
mv $SETUP_CAC_ZIP $(brew --cache -s $HB_TAP/git-config-cac)
```
Now, you can use the commands documented in the [Read Me](README.md).

## How to remove the Tap

**Warning:** Proceed carefully since the following will actually delete files.

Before removing the tap uninstall the tap's formula:
```
brew uninstall git-https-cac
brew uninstall git-config-cac`
```

You may also want to clean up anything that was installed a  dependency: `curl`, `openssl@1.1`, `opensc`, etc. Then run the following terminal commands:

```
brew untap $HB_TAP
rm -r -f $(brew --prefix)/Library/Taps/$HB_TAP
```
