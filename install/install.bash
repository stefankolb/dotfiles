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

print_headline 'SETTING UP BASH'

print_in_white 'Copying Bash files ...'
print_lb 1
copy_file_list './_install-file-lists/files.bash'
print_lb 1
print_in_white 'Setting up symlinks for Bash ...'
print_lb 1
setup_symlinks './_install-file-lists/symlinks.bash'

# Source Bash profile to make everything available that we installed
. ${DIR_BASE}/bash/.bash_profile
    
fi
