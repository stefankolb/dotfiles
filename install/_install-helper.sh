#!/usr/bin/env bash

# ##############################################################################
# FILE OPERATIONS
# ##############################################################################

# $1 = file name that holds the file(s) to copy
function copy_file_list {
  local file_list=$1

  # Check if the list file exists
  if [ ! -f $file_list ]; then
    print_error "File '$file_list' does not exist"
    return 1
  fi

  # https://stackoverflow.com/a/23697848
  local files_to_copy=`cat $file_list`
  for file in $files_to_copy; do 
    local source=${file%=*}
    local target=${file#*=}
    local realsource=$(eval echo -e "${source}")
    local realtarget=$(eval echo -e "${target}")

    print_in_white "Copying $realsource to ${DIR_BASE}/$realtarget ... "
    
    # Make sure the destination directory exists
    local dirname=$(dirname "${realtarget}")
    mkdir -p ${DIR_BASE}/$dirname
    cp -R $realsource ${DIR_BASE}/$realtarget 2>/dev/null || \
      ( \
        print_error_short && \
        print_lb 1
      )
    if [ $? -eq 0 ]; then
      print_success_short
      print_lb 1
    fi
  done
}


# $1 = The Bash command to install each item in $2
# $2 = file name that holds the file(s) to install
function install_file_list {
  local command=$1
  local file_list=$2

  # Check if the list file exists
  if [ ! -f $file_list ]; then
    print_error "File '$file_list' does not exist"
    return 1
  fi

  local files_to_install=`cat $file_list`
  for file in $files_to_install; do
    print_in_white "Executing $command $file...\n"
    $command $file
  done
}


# $1 = file name that holds the list of symlinks to create
function setup_symlinks {
  local file_list=$1

  # Check if the list file exists
  if [ ! -f $file_list ]; then
    print_error "File '$file_list' does not exist"
    return 1;
  fi

  local symlinks=`cat $file_list`
  for link in $symlinks; do
    local source=${link%=*}
    local target=${link#*=}
    local realsource=$(eval echo -e "${source}")
    local realtarget=$(eval echo -e "${target}")
    
    print_in_white "Symlinking $realsource to $realtarget... "
    ln -s $realsource $realtarget
    
    print_success_short
    print_lb 1
  done
}

# $1 = The command to check
# https://stackoverflow.com/q/592620#comment18301447_6471205
function exists() {
  hash $1 &> /dev/null
}


# ##############################################################################
# PRINT/OUTPUT FUNCTIONS
# ##############################################################################

# COLORED OUTPUT

function _print_in_color {
  printf "%b" \
    "$(tput setaf "$2" 2> /dev/null)" \
    "$1" \
    "$(tput sgr0 2> /dev/null)"
}

function print_in_red {
  _print_in_color "$1" 1
}

function print_in_green {
  _print_in_color "$1" 2
}

function print_in_yellow {
  _print_in_color "$1" 3
}

function print_in_blue {
  _print_in_color "$1" 4
}

function print_in_magenta {
  _print_in_color "$1" 5
}

function print_in_cyan {
  _print_in_color "$1" 6
}

function print_in_white {
  _print_in_color "$1" 7
}


# STATUS MESSAGES

function print_success {
  print_in_green "[✓] $1"
  
  if [ -z $2 ] || [ ! $2 == false ]; then
    printf "\n"
  fi
}

function print_warning {
  print_in_yellow "[!] $1"
  
  if [ -z $2 ] || [ ! $2 == false ]; then
    printf "\n"
  fi
}

function print_error {
  print_in_red "[🚨] $1 $2"
  
  if [ -z $2 ] || [ ! $2 == false ]; then
    printf "\n"
  fi
}

function print_success_silent {
  printf "${COLOR_DIM}[✓] $1${COLOR_RESET}\n" "$@"
}


# SHORTENED STATUS MESSAGES

function print_success_short {
  print_in_green "[✓]"
}

function print_warning_short {
  print_in_yellow "[️️⚠️]"
}

function print_error_short {
  print_in_red "[🚨]"
}


# LABELS

function print_label_red {
    printf "${COLOR_BG_RED}${COLOR_WHITE} $1 ${COLOR_RESET}${COLOR_RED} $2 ${COLOR_RESET}\n"
}

function print_label_green {
    printf "${COLOR_BG_GREEN}${COLOR_BLACK} $1 ${COLOR_RESET}${COLOR_GREEN} $2 ${COLOR_RESET}\n"
}

function print_label_yellow {
    printf "${COLOR_BG_YELLOW}${COLOR_WHITE} $1 ${COLOR_RESET}${COLOR_YELLOW} $2 ${COLOR_RESET}\n"
}

function print_label_blue {
    printf "${COLOR_BG_BLUE}${COLOR_WHITE} $1 ${COLOR_RESET}${COLOR_BLUE} $2 ${COLOR_RESET}\n"
}

function print_label_magenta {
    printf "${COLOR_BG_MAGENTA}${COLOR_WHITE} $1 ${COLOR_RESET}${COLOR_MAGENTA} $2 ${COLOR_RESET}\n"
}

function print_label_cyan {
    printf "${COLOR_BG_CYAN}${COLOR_BLACK} $1 ${COLOR_RESET}${COLOR_CYAN} $2 ${COLOR_RESET}\n"
}

function print_label_white {
    printf "${COLOR_BG_WHITE}${COLOR_BLACK} $1 ${COLOR_RESET}${COLOR_WHITE} $2 ${COLOR_RESET}\n"
}


# MISC.

function print_headline {
  print_in_white "\n\n\n##### ${1} #####\n\n"
}

function print_lb {
  for (( i=0; i<${1}; i++ )); do
    printf "\n"
  done
}


# ##############################################################################
# PROMPTS/QUESTIONS
# ##############################################################################
