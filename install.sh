#!/usr/bin/env sh

# Clear console
clear

printf "
        __      __  _____ __
   ____/ /___  / /_/ __(_) /__  _____
  / __  / __ \/ __/ /_/ / / _ \/ ___/
 / /_/ / /_/ / /_/ __/ / /  __(__  )
 \__,_/\____/\__/_/ /_/_/\___/____/

(c) Copyright 2019-present Stefan Kolb
\n"

# Configuration
VERSION="master" # @TODO: Ask which version/branch to install
DIR_TMP="/tmp"
DIR_TMP_INSTALL="${DIR_TMP}/dotfiles"
DIR_TMP_ZIP="${DIR_TMP_INSTALL}/dotfiles-${VERSION}"
FILE_INSTALL_ZIP="${DIR_TMP_INSTALL}/dotfiles-${VERSION}.zip"

# If curl is not available, we cannot do anything (for now)
if [ -x curl ]; then
  printf "You need curl"
  exit 1
fi

# Make sure we have a temporary install directory
if [ ! -d ${DIR_TMP_INSTALL} ]; then
  mkdir -p ${DIR_TMP_INSTALL} || exit 1
fi

# Get the requested version from Github and unzip
printf "Downloading ...\n"
curl https://codeload.github.com/stefankolb/dotfiles/zip/${VERSION} -o ${FILE_INSTALL_ZIP}
printf "\nUnzipping ...\n"
unzip -qn ${FILE_INSTALL_ZIP} -d ${DIR_TMP_INSTALL}

# Start installation
# @TODO Furture versions could have install scripts for various shells
cd ${DIR_TMP_ZIP}/install
chmod +x install.bash
./install.bash
