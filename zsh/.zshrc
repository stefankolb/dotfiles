#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Cache directory
CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}

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

# Make bookmarks available
setopt auto_cd
cdpath=(${DOTFILES_BASE}/zsh/bookmarks)

# Make Node usable by importing Node Version Manager (NVM)
export NVM_DIR=${DOTFILES_BASE}/.nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . ${NVM_DIR}/nvm.sh

# Always position the prompt at the bottom of the window
printf '\n%.0s' {1..100}
fastfetch -c ${DOTFILES_BASE}/fastfetch.jsonc


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

# Bug: https://github.com/zsh-users/zsh-autosuggestions/issues/619
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end)

# Enable autocompletions that are not part of the ZSH core
fpath=(${DOTFILES_BASE}/zsh/plugins/zsh-completions/src $fpath)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Make tab autocomplete regardless of filename case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Use select menu for ambiguous completion
zstyle ':completion:*' menu select

# Use caching for autocompletion
[ -d "$CACHE_DIR/zsh" ] || mkdir -p "$CACHE_DIR/zsh"
autoload -Uz compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${CACHE_DIR}/zsh/.zcompcache"

# Initialize the autocompletion
compinit -C -d "${CACHE_DIR}/zsh/.zcompdump-${HOST}"


# ------------------------------------------------------------------------------
# ATUIN
# ------------------------------------------------------------------------------

# Initialize atuin
eval "$(atuin init zsh)"


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

# Insert a new line before transient prompt
function p10k-on-pre-prompt() {
  if [[ $P9K_TTY == new ]]; then
    p10k display 'empty_line'=hide
  else
    p10k display 'empty_line'=print
  fi
}

source ${DOTFILES_BASE}/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ${DOTFILES_BASE}/zsh/themes/.p10k.zsh ]] || source ${DOTFILES_BASE}/zsh/themes/.p10k.zsh

# Overwrite Powerlevel10k options here
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=30
typeset -g POWERLEVEL9K_NVM_BACKGROUND=14
typeset -g POWERLEVEL9K_PACKAGE_CONTENT_EXPANSION='${P9K_PACKAGE_NAME//\%/%%}@${P9K_PACKAGE_VERSION//\%/%%}'
typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=15
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=15

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  vcs
  vcs_additional_info
  newline
  dir
  newline
  status
)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  package
  nvm
  rust_version
  newline
  newline
)

typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%244F│ '
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%244F │'
