#!/usr/bin/env bash
#
#         __      __  _____ __
#    ____/ /___  / /_/ __(_) /__  _____
#   / __  / __ \/ __/ /_/ / / _ \/ ___/
#  / /_/ / /_/ / /_/ __/ / /  __(__  )
#  \__,_/\____/\__/_/ /_/_/\___/____/
# 
# (c) Copyright 2019-present Stefan Kolb
#

# #############################################################################
# COLOR DEFINITIONS
# #############################################################################

# https://misc.flogisoft.com/bash/tip_colors_and_formatting

COLOR_DEFAULT="\e[39m"
COLOR_BLACK="\e[30m"
COLOR_RED="\e[31m"
COLOR_GREEN="\e[32m"
COLOR_YELLOW="\e[33m"
COLOR_BLUE="\e[34m"
COLOR_MAGENTA="\e[35m"
COLOR_CYAN="\e[36m"
COLOR_WHITE="\e[97m"
COLOR_DIM="\e[2m"

COLOR_BG_DEFAULT="\e[49m"
COLOR_BG_BLACK="\e[40m"
COLOR_BG_RED="\e[41m"
COLOR_BG_GREEN="\e[42m"
COLOR_BG_YELLOW="\e[43m"
COLOR_BG_BLUE="\e[44m"
COLOR_BG_MAGENTA="\e[45m"
COLOR_BG_CYAN="\e[46m"
COLOR_BG_WHITE="\e[107m"
COLOR_BG_DIM="\e[47m"

COLOR_RESET="\e[0m"


# #############################################################################
# TEXT FORMAT DEFINITIONS
# #############################################################################

# https://misc.flogisoft.com/bash/tip_colors_and_formatting

TEXT_BOLD="\e[1m"
TEXT_UNDERLINED="\e[4m"
TEXT_UNDERLINED="\e[5m"
TEXT_REVERSED="\e[7m"

TEXT_RESET="\e[0m"


# #############################################################################
# PATHS
# #############################################################################

DIR_DOTFILES=".dotfiles";
DIR_BASE="${HOME}/${DIR_DOTFILES}"

DIR_NVM="${DIR_BASE}/.nvm"
DIR_NPM="${DIR_BASE}/.npm"
DIR_GIT="${DIR_BASE}/git"

REQUIRED_DIRS=($DIR_BASE $DIR_NVM $DIR_NPM $DIR_GIT)


# #############################################################################
# APP VERSIONS
# #############################################################################

NVM_VERSION="0.34.0"
NODE_VERSION="12.4.0"
