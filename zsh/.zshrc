#!/usr/bin/env zsh

# Set keyboard bindings to Vim style
bindkey -e

# Set .dotfiles base directory
DOTFILES_BASE="${HOME}/.dotfiles"

# Load other parts
for FILE in aliases exports functions; do
  FILE="${DOTFILES_BASE}/zsh/.${FILE}"
  [ -e "${FILE}" ] && source "${FILE}"
done
unset FILE

# Make custom functions available
fpath+=${DOTFILES_BASE}/zsh/functions

# Make Node usable by importing Node Version Manager (NVM)
export NVM_DIR=${DOTFILES_BASE}/.nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . ${NVM_DIR}/nvm.sh

# ------------------------------------------------------------------------------
# HISTORY CONTROL
# ------------------------------------------------------------------------------

# Where to store history
HISTFILE="${DOTFILES_BASE}/zsh/.zsh_history"

# Set history size
HISTSIZE=1000000
SAVEHIST=${HISTSIZE}

# Don't duplicate lines or lines starting with space in the history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space

# Append immediately to the history file instead of doing it on exiting the shell
setopt inc_append_history


# ------------------------------------------------------------------------------
# AUTOCOMPLETE
# ------------------------------------------------------------------------------

# Enable Autosuggestions plugin
source ${DOTFILES_BASE}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Enable autocompletions that are not part of the ZSH core
fpath=(${DOTFILES_BASE}/zsh/plugins/zsh-completions/src $fpath)

# Make tab autocomplete regardless of filename case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Use select menu for ambiguous completion
zstyle ':completion:*' menu select

# Initialize the autocompletion
autoload -Uz compinit && compinit -i -d ${DOTFILES_BASE}/zsh/.zcompdump


# ------------------------------------------------------------------------------
# IMPROVE INPUT/COMMAND LINE
# ------------------------------------------------------------------------------

# Use the text that has already been typed as the prefix for searching through
# commands (i.e. more intelligent up/down behavior)
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Custom keybindings
bindkey -s "^h" "hstr -- ^M"   # Ctrl-h to open hstr
bindkey '^[[[CE' autosuggest-execute  # Ctrl+Enter to execute autosuggest

# Enable autocorrection
setopt correct_all


# ------------------------------------------------------------------------------
# MISC.
# ------------------------------------------------------------------------------

# iTerm2 tools
test -e "${DOTFILES_BASE}/zsh/.iterm2_shell_integration.zsh" && source "${DOTFILES_BASE}/zsh/.iterm2_shell_integration.zsh" || true


# ------------------------------------------------------------------------------
# PROMPT/THEME
# ------------------------------------------------------------------------------

autoload git_get_last_tag

function prompt_vcs_additional_info() {
  p10k segment -b 208 -f 0 -t "${VCS_STATUS_COMMIT[0,8]}"
  p10k segment -b 9 -f 0 -t "$(git_get_last_tag)"
}

source ${DOTFILES_BASE}/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ${DOTFILES_BASE}/zsh/themes/.p10k.zsh ]] || source ${DOTFILES_BASE}/zsh/themes/.p10k.zsh

function prompt_package_info() {
  # Only add prompt segment if there is a package.json in the current directory
  _p9k_upglob 'package.json' && return

  local project_name
  project_name=( $(grep "\"name\":" package.json | cut -d \" -f4) )

  local project_version
  project_version=( $(grep "\"version\":" package.json | cut -d \" -f4) )

  p10k segment -b 6 -f 15 -t "${project_name}@v${project_version}"
}

# Overwrite Powerlevel10k options here
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=30
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  newline
  dir
)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  package_info
  newline
  vcs
  vcs_additional_info
)
