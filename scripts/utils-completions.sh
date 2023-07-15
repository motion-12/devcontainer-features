#!/bin/bash

# Return help if no arguments are passed
if [ $# -eq 0 ]; then
  echo "Usage: utils completions <zsh|bash>"
  echo ""
  echo "Generates autocompletions."
  echo ""
  echo "Arguments:"
  echo "  <zsh|bash>    The name of the completion to generate."
  exit 1
fi


# If zsh argument is empty, exit
if [ -z "$1" ]; then
  echo -e "\033[31mError: No completion specified\033[0m"
  exit 1
fi

# If zsh argument is not zsh or bash, exit
if [ "$1" != "zsh" ] && [ "$1" != "bash" ]; then
  echo -e "\033[31mError: Invalid completion specified\033[0m"
  exit 1
fi

# If zsh argument is zsh, generate zsh completions
if [ "$1" == "zsh" ]; then
  cat scripts/utils-completions-zsh.sh
fi

# If zsh argument is bash, generate bash completions
if [ "$1" == "bash" ]; then
  cat scripts/utils-completions-bash.sh
fi