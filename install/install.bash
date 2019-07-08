#!/usr/bin/env bash

# Check for install tools/helper and configuration
DEPS=(_install-vars.sh _install-helper.sh)
  for dep in "${DEPS[@]}"; do 
    if [ -e ${dep} ]; then
    . ${dep}
  else
    printf "\n\n⚠️ ${dep} not found! Aborting ..."
    exit 1;
  fi
done
unset dep

# Preparations
print_headline "PREPARING DOTFILES INSTALLATION"

for dir in "${REQUIRED_DIRS[@]}"; do
  print_in_white "Checking if ${dir} is available... "
  if [ ! -d "${dir}" ]; then
    print_lb 1
    print_warning "${dir} not available, creating it... " false
    mkdir -p ${dir}
  fi
  print_success_short
  print_lb 1
done
unset dir

print_lb 1
print_success "Preparations completed successfully"


# ##############################################################################
# NVM (Node Version Manager)
# ##############################################################################

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


# ##############################################################################
# NODE
# ##############################################################################

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


# ##############################################################################
# HOMEBREW
# ##############################################################################

# Install Homebrew package manager
print_headline "INSTALLING HOMEBREW"
if ! exists brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  
  print_lb 1
  print_success "Brew successfully installed"
else
  print_success_silent "Brew already installed"
fi


# ##############################################################################
# BASH SETUP
# ##############################################################################

# Verify that we are allowed to install/override current .dotfiles
print_lb 2
printf "Ready for installation!
Continuing will override existing files!
${TEXT_BOLD}Are you sure you want to continue? (y|N)${TEXT_RESET} "
read -n 1 -r <&2
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    print_headline 'INSTALLING BREW PACKAGES'
    install_file_list 'brew install' './_install-file-lists/brew'
    
    print_headline 'SETTING UP SYMLINKS FOR NPM'
    setup_symlinks './_install-file-lists/symlinks.npm'
    
    print_headline 'INSTALLING GLOBAL NPM PACKAGES'
    install_file_list 'npm install -g' './_install-file-lists/npm'

    print_headline 'COPYING BASH FILES'
    copy_file_list './_install-file-lists/files.bash'
    
    print_headline 'SETTING UP SYMLINKS FOR BASH'
    setup_symlinks './_install-file-lists/symlinks.bash'
    
    print_headline 'COPYING GIT CONFIG'
    copy_file_list './_install-file-lists/files.git'
    
    print_headline 'SETTING UP SYMLINKS FOR GIT'
    setup_symlinks './_install-file-lists/symlinks.git'
    
    print_headline 'COPYING VIM FILES'
    copy_file_list './_install-file-lists/files.vim'
    
    print_headline 'SETTING UP SYMLINKS FOR VIM'
    setup_symlinks './_install-file-lists/symlinks.vim'
    
    # Source Bash profile to make everything available that we installed
    . ${DIR_BASE}/bash/.bash_profile
    
    print_success "Dotfiles successfully installed! :)"
fi
