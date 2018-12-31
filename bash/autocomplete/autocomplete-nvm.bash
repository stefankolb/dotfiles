#!/usr/bin/env bash

# nvm (Node Version Manager) completion

# https://raw.githubusercontent.com/Bash-it/bash-it/master/completion/available/nvm.completion.bash

if [ "$NVM_DIR" ] && [ -r "$NVM_DIR"/bash_completion ];
then
  . "$NVM_DIR"/bash_completion
fi
