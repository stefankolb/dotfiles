# Set .dotfiles directory
DOTFILES="${HOME}/.dotfiles"

# Load other .dotfiles
for FILE in aliases exports functions bash_prompt; do
  FILE="${DOTFILES}/.${FILE}"
  [ -e "${FILE}" ] && source "${FILE}"
done
unset FILE

# -----------------------------------------------------------------------------
# HISTROY CONTROL
# -----------------------------------------------------------------------------

# Don't duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set history size
HISTSIZE=1000000
HISTFILESIZE=${HISTSIZE}

# Specify history file and entry format
HISTFILE="${DOTFILES}/.bash_history"
HISTTIMEFORMAT="%y-%m-%d %T "

# Append to the history file, don't overwrite it
shopt -s histappend;

# -----------------------------------------------------------------------------
# AUTOCOMPLETION
# -----------------------------------------------------------------------------

# SSH
[ -f ~/.dotfiles/autocomplete/autocomplete-ssh.bash ] && . ~/.dotfiles/autocomplete/autocomplete-ssh.bash

# Git
[ -f ~/.dotfiles/autocomplete/autocomplete-git.bash ] && . ~/.dotfiles/autocomplete/autocomplete-git.bash

# NVM
[ -f ~/.dotfiles/autocomplete/autocomplete-nvm.bash ] && . ~/.dotfiles/autocomplete/autocomplete-nvm.bash

# NPM
[ -f ~/.dotfiles/autocomplete/autocomplete-npm.bash ] && . ~/.dotfiles/autocomplete/autocomplete-npm.bash

# Grunt
[ -f ~/.dotfiles/autocomplete/autocomplete-grunt.bash ] && . ~/.dotfiles/autocomplete/autocomplete-grunt.bash


# -----------------------------------------------------------------------------
# MISC.
# -----------------------------------------------------------------------------

# Node Version Manager (NVM)                                                                        
export NVM_DIR=~/.dotfiles/.nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . ${NVM_DIR}/nvm.sh

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
