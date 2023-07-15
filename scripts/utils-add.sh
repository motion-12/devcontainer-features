#!/bin/bash

# Return help if no arguments are passed
if [ $# -eq 0 ]; then
  echo "Usage: utils add <util-name> <feature-name>"
  echo ""
  echo "Adds a util to a feature."
  echo ""
  echo "Arguments:"
  echo "  <util-name>    The name of the util to add."
  echo "  <feature-name> The name of the feature to add the util to."
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

# If feature doesn't have a utils.txt, create it
if [ ! -f src/${2}/utils.txt ]; then
  touch src/${2}/utils.txt
fi

# Add the util to the end of the feature's utils.txt, if it doesn't already exist
if ! grep -q ${1} src/${2}/utils.txt; then
  echo ${1} >>src/${2}/utils.txt
  echo -e "\033[32mAdded util \"${1}\" to feature \"${2}\"\033[0m"
else
  echo -e "\033[31mError: Util \"${1}\" already exists in feature \"${2}\"\033[0m"
  exit 1
fi

# Run utils-sync.sh
scripts/utils-sync.sh
