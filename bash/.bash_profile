# Set .dotfiles base directory
DOTFILES_BASE="${HOME}/.dotfiles"

# Load other parts
for FILE in aliases exports functions bash_prompt; do
  FILE="${DOTFILES_BASE}/bash/.${FILE}"
  [ -e "${FILE}" ] && source "${FILE}"
done
unset FILE

# Make Node usable by importing Node Version Manager (NVM)
export NVM_DIR=${DOTFILES_BASE}/.nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . ${NVM_DIR}/nvm.sh

# ------------------------------------------------------------------------------
# BASH HISTORY CONTROL
# ------------------------------------------------------------------------------

# Where to store history and specify entry format
HISTFILE="${DOTFILES_BASE}/bash/.bash_history"
HISTTIMEFORMAT="%y-%m-%d %T "

# Don't duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set history size
HISTSIZE=1000000
HISTFILESIZE=${HISTSIZE}

# Append to the history file, don't overwrite it
shopt -s histappend;

# ------------------------------------------------------------------------------
# AUTOCOMPLETE
# ------------------------------------------------------------------------------

# Git
[ -f ${DOTFILES_BASE}/bash/autocomplete/autocomplete-git.bash ] &&
  . ${DOTFILES_BASE}/bash/autocomplete/autocomplete-git.bash

# NPM
[ -f ${DOTFILES_BASE}/bash/autocomplete/autocomplete-npm.bash ] &&
  . ${DOTFILES_BASE}/bash/autocomplete/autocomplete-npm.bash

# NVM
[ -f ${DOTFILES_BASE}/bash/autocomplete/autocomplete-nvm.bash ] &&
  . ${DOTFILES_BASE}/bash/autocomplete/autocomplete-nvm.bash

# SSH
[ -f ${DOTFILES_BASE}/bash/autocomplete/autocomplete-ssh.bash ] &&
  . ${DOTFILES_BASE}/bash/autocomplete/autocomplete-ssh.bash


# ------------------------------------------------------------------------------
# MISC.
# ------------------------------------------------------------------------------

#
shopt -s nocaseglob;
shopt -s cdspell;

# Add highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# iTerm2 tools
. ${DOTFILES_BASE}/bash/iterm2_shell_integration.bash
