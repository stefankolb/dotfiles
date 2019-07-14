#!/usr/bin/env sh

# Clear console
clear

printf "
        __      __  _____ __
   ____/ /___  / /_/ __(_) /__  _____
  / __  / __ \/ __/ /_/ / / _ \/ ___/
 / /_/ / /_/ / /_/ __/ / /  __(__  )
 \__,_/\____/\__/_/ /_/_/\___/____/

(c) Copyright 2019-present Stefan Kolb"

# ##############################################################################
# CONFIGURATION
# ##############################################################################

# Only configure what is needed before _install_vars.sh is downloaded from 
# Github and sourced in

VERSION="master" # @TODO: Ask which version/branch to install
DIR_TMP="/tmp"
DIR_TMP_INSTALL="${DIR_TMP}/dotfiles"
DIR_TMP_ZIP="${DIR_TMP_INSTALL}/dotfiles-${VERSION}"
FILE_INSTALL_ZIP="${DIR_TMP_INSTALL}/dotfiles-${VERSION}.zip"


# ##############################################################################
# INSTALLATION HELPER METHODS
# ##############################################################################

# Check for install tools/helper and configuration
check_for_install_tools() {
  DEPS=(_install-vars.sh _install-helper.sh)
  local dep
  
  for dep in "${DEPS[@]}"; do 
    if [ -e "install/${dep}" ]; then
      . "install/${dep}"
    else
      printf "\n⚠️ ${dep} not found! Aborting ..."
      exit 1;
    fi
  done
}

prepare_installation() {
  for dir in "${REQUIRED_DIRS[@]}"; do
    print_in_white "Checking if ${dir} is available... "
    if [ ! -d "${dir}" ]; then
      print_lb 1
      print_warning "${dir} not available, creating it... " false
      mkdir -p ${dir} || exit 1
    fi
    print_success_short
    print_lb 1
  done
  unset dir
}


# ##############################################################################
# INIT
# ##############################################################################

# If curl is not available, we cannot do anything (for now)
if [ ! -x "$(command -v curl)" ]; then
  print_error "cURL not found! Aborting ..."
  exit 1
fi

# Makre sure we have a temporary install directory
if [ ! -d "${DIR_TMP_INSTALL}" ]; then
  mkdir -p "${DIR_TMP_INSTALL}" || exit 1
fi

printf "\n\n\n##### PREPARING DOTFILES INSTALLATION #####\n\n"

# Get the requested version of dotfiles from Github and unzip
printf "Downloading version '${VERSION}' from GitHub...\n"
curl https://codeload.github.com/stefankolb/dotfiles/zip/${VERSION} -o ${FILE_INSTALL_ZIP}
printf "\nUnzipping ..."
unzip -qn ${FILE_INSTALL_ZIP} -d ${DIR_TMP_INSTALL}
printf "[✓]\n\n"

# Preparations
cd ${DIR_TMP_ZIP}
check_for_install_tools
prepare_installation

print_lb 1
print_success "Preparations completed successfully"


# ##############################################################################
# INSTALLATION
# ##############################################################################

# Verify that we are allowed to install/override current .dotfiles
print_lb 2
printf "Ready for installation!
Continuing will override existing files!
${TEXT_BOLD}Are you sure you want to continue? (y|N)${TEXT_RESET} "
read -n 1 -r <&2
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  print_lb 1
  print_warning "Aborting installation on user's request ..."
  exit 0
fi


# NVM (Node Version Manager)
# ##########################

# Install NVM to make it easier to handle various Node versions
# installed in parallel
print_headline "INSTALLING NVM (Node Version Manager) v${NVM_VERSION}"
if ! exists nvm; then
  export NVM_DIR="${DIR_BASE}/.nvm"
  export METHOD="script" # We cannot asume git is installed
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh \
    | bash
  [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"

  print_lb 1
  print_success "NVM v${NVM_VERSION} successfully installed"
else
  print_success_silent "NVM already installed"
fi


# NODE
# ####

# Install Node itself
print_headline "INSTALLING NODE v${NODE_VERSION}"
if ! exists node; then
  nvm install ${NODE_VERSION}
  nvm alias default ${NODE_VERSION}
  
  print_lb 1
  print_success "Node v${NODE_VERSION} successfully installed"
else
  print_success_silent "Node already installed"
fi

# Install global NPM packages
print_lb 1
print_in_white 'Setting up symlinks for NPM ...'
print_lb 1
setup_symlinks './install/_install-file-lists/symlinks.npm'
print_in_white 'Installing global NPM packages ...'
print_lb 1
install_file_list 'npm install -g' './install/_install-file-lists/npm'
print_lb 1
print_success "NPM packages successfully installed"


# HOMEBREW
# ########

# Install Homebrew package manager
print_headline "INSTALLING HOMEBREW"
if ! exists brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  
  print_lb 1
  print_success "Brew successfully installed"
else
  print_success_silent "Brew already installed"
fi

# Install homebrew packages
print_lb 1
print_in_white 'Installing brew packages ...'
print_lb 1
install_file_list 'brew install' './install/_install-file-lists/brew'
print_lb 1
print_success "Brew packages successfully installed"


# VIM
# ###

print_headline 'SETTING UP VIM'
print_in_white 'Copying vim files ...'
print_lb 1
copy_file_list './install/_install-file-lists/files.vim'
print_lb 1
print_in_white 'Setting up symlinks for vim ...'
print_lb 1
setup_symlinks './install/_install-file-lists/symlinks.vim'
print_lb 1
print_success "VIM successfully set up"


# GIT
# ###

print_headline 'SETTING UP GIT'
print_in_white 'Copying Git config ...'
print_lb 1
copy_file_list './install/_install-file-lists/files.git'
print_lb 1
print_in_white 'Setting up symlinks for Git ...'
print_lb 1
setup_symlinks './install/_install-file-lists/symlinks.git'
print_lb 1
print_success "Git successfully set up"


# APPLICATIONS
# ############

print_headline 'INSTALLING APPS VIA HOMEBREW/CASK'
brew tap caskroom/cask
print_lb 1
install_file_list 'brew cask install' './install/_install-file-lists/brew-cask'
print_lb 1
print_in_white 'Copying app configs and preference files ...'
print_lb 1
copy_file_list './install/_install-file-lists/files.apps' true


# SHELL
# #####

# @TODO Furture versions could have install scripts for various shells
cd ${DIR_TMP_ZIP}/install
chmod +x install.bash
./install.bash

# ##########################################################################
# DONE
# ##########################################################################

print_lb 1
print_success "Dotfiles successfully installed! :)"
