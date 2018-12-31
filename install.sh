#!/bin/bash

# Clear console
clear

# Configuration
NVM_VERSION="0.33.11"
NODE_VERSION="11.6.0"
DIR_DOTFILES=".dotfiles";
DIR_TEMP="/tmp/dotfiles"  # We don't want this hidden
DIR_BASE="${HOME}/${DIR_DOTFILES}"

# Helper function to print section headlines
function print_headline {
  printf "\n\n\n ##### {1} #####\n\n"
}

# Logo and intro
echo "        __      __  _____ __           "
echo "   ____/ /___  / /_/ __(_) /__  _____  "
echo "  / __  / __ \/ __/ /_/ / / _ \/ ___/  "
echo " / /_/ / /_/ / /_/ __/ / /  __(__  )   "
echo " \__,_/\____/\__/_/ /_/_/\___/____/    "

printf "\n SLOGAN MISSING \n\n"

# Preparations
print_headline "PREPARING DOTFILES INSTALLATION"
[ ! -d "${DIR_TEMP}" ] && mkdir -p ${DIR_TEMP}
[ ! -d "${DIR_BASE}" ] && mkdir ${DIR_BASE}

print_headline "INSTALLING NVM (Node Version Manager) v${NVM_VERSION}"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v{NVM_VERSION}/install.sh | NVM_DIR={DIR_BASE}/.nvm bash
export NVM_DIR="${DIR_BASE}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"

print_headline "INSTALLING NODE v${NODE_VERSION}"
nvm install ${NODE_VERSION}
nvm alias default ${NODE_VERSION}

