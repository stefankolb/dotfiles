#!/bin/bash

# Set defaults
NOTAVAILABLE="false"
TAG_ERROR="$(tput setaf 1)[ERROR]$(tput sgr 0)"

# Read arguments from command line
printf "\n##### Reading arguments from command line ...\n"
SOURCE=${1:-$NOTAVAILABLE}
TARGETS=${2:-$NOTAVAILABLE}

# Verify command line arguments
printf "\n##### Verifying command line arguments ...\n"
if [[ $SOURCE == $NOTAVAILABLE || $TARGETS == $NOTAVAILABLE ]]; then
  echo "$TAG_ERROR"
  echo "  Missing command line argument(s)!"
  echo "  Should look something like ./git-multimerge.sh {SOURCE_BRANCH} {TARGET_BRANCH[, TARGET_BRANCH...]}"
  echo "$TAG_ERROR"
  exit 1;
fi

# Verifying that source branch does exists
printf "\n##### Veriying that source branch exists ...\n"
git co ${SOURCE} >/dev/null 2>&1
if [ ! $? == 0 ]; then
  echo "$TAG_ERROR"
  echo "  Source branch \"${1}\" does not exist!"
  echo "  ABORTING"
  echo "$TAG_ERROR"
  exit 1
fi

# Iterate over every target branch that the source branch should be merged into
TARGETS=(${TARGETS//,/ });
for i in "${!TARGETS[@]}"; do
  TARGET=${TARGETS[i]}   # Get current target branch
  
  printf "\n##### Verifying that target branch \"${TARGET}\" exists ...\n"
  git co ${TARGET} >/dev/null 2>&1
  if [ ! $? == 0 ]; then
    echo "$TAG_ERROR"
    echo "  Target branch \"${TARGET}\" does not exist!"
    echo "  ABORTING"
    echo "$TAG_ERROR"
    exit 1
  fi
  
  printf "\n##### Updating local branch \"${TARGET}\" from remote ...\n"
  git pull || exit 1			# TODO What if pull fails?
  
  printf "\n##### Merging \"${SOURCE}\" into \"${TARGET}\" ...\n"
  git merge ${SOURCE} || exit 1		# TODO How to automatically close vi with commit message?
  
  printf "\n#### Pushing local branch \"${TARGET}\" to remote ...\n"
  git push || exit 1			# TODO What if push fails?
done

git co ${SOURCE} >/dev/null 2>&1

exit 0
