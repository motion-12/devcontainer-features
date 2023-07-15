#!/bin/bash

# Return help if no arguments are passed
if [ $# -eq 0 ]; then
  echo "Usage: utils remove <util-name> <feature-name>"
  echo ""
  echo "Removes a util from a feature."
  echo ""
  echo "Arguments:"
  echo "  <util-name>    The name of the util to remove."
  echo "  <feature-name> The name of the feature to remove the util from."
  exit 1
fi

# If util doesn't exist, exit
if [ ! -f shared/${1}.sh ]; then
  echo -e "\033[31mError: Util \"${1}\" does not exist\033[0m"
  exit 1
fi

# If feature argument is empty, exit
if [ -z "$2" ]; then
  echo -e "\033[31mError: No feature specified\033[0m"
  exit 1
fi

# If feature doesn't exist, exit
if [ ! -d src/${2} ]; then
  echo -e "\033[31mError: Feature \"${2}\" does not exist\033[0m"
  exit 1
fi

# If feature doesn't have a utils.txt, exit
if [ ! -f src/${2}/utils.txt ]; then
  echo -e "\033[31mError: Feature \"${2}\" does not have a utils.txt file\033[0m"
  exit 1
fi

# Remove the util from the feature's utils.txt, if it exists
if grep -q ${1} src/${2}/utils.txt; then
  sed "/${1}/d" src/${2}/utils.txt >src/${2}/utils.txt.tmp
  mv src/${2}/utils.txt.tmp src/${2}/utils.txt

  # Remove the util from the feature, if it exists
  if [ -f src/${2}/${1}.sh ]; then
    rm src/${2}/${1}.sh
  fi

  echo -e "\033[32mRemoved util \"${1}\" from feature \"${2}\"\033[0m"
else
  echo -e "\033[31mError: Util \"${1}\" does not exist in feature \"${2}\"\033[0m"
  exit 1
fi

# Run utils-sync.sh
scripts/utils-sync.sh
