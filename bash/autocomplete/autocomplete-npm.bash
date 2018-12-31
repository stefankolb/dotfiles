#!/usr/bin/env bash

# npm (Node Package Manager) completion
# https://docs.npmjs.com/cli/completion

# https://raw.githubusercontent.com/Bash-it/bash-it/master/completion/available/npm.completion.bash

if command -v npm &>/dev/null
then
  eval "$(npm completion)"
fi
