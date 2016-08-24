#!/bin/bash

# Clear console
clear

# Set-up
NVM_VERSION="0.31.5"
NODE_VERSION="6.4.0"
DIR_TEMP="/tmp/dotfiles"
DIR_BASE=${HOME}/.dotfiles


# Helper function to print section headlines
function print_headline {
  printf "\n ##### ${1} #####\n\n"
}


# Logo and Intro
echo "        __      __  _____ __           "
echo "   ____/ /___  / /_/ __(_) /__  _____  "
echo "  / __  / __ \/ __/ /_/ / / _ \/ ___/  "
echo " / /_/ / /_/ / /_/ __/ / /  __(__  )   "
echo " \__,_/\____/\__/_/ /_/_/\___/____/    "


printf "\n SLOGIN MISSING \n\n"

print_headline "PREPARING DOTFILES INSTALLATION"
[ ! -d "${DIR_TEMP}" ] && mkdir -p ${DIR_TEMP}
[ ! -d "${DIR_BASE}" ] && mkdir ${DIR_BASE}

print_headline "INSTALLING NVM (Node Version Manager) v${NVM_VERSION}"
curl https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | NVM_DIR=~/.dotfiles/.nvm bash
export NVM_DIR="${DIR_BASE}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"

print_headline "INSTALLING NODE v${NODE_VERSION}"
nvm install ${NODE_VERSION}
nvm alias default ${NODE_VERSION}

printf "\n ##### INSTALLING GRUNT.JS GLOBALLY #####\n\n"
npm install -g grunt grunt-cli
