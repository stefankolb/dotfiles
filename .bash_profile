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
