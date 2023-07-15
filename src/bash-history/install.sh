#!/usr/bin/env bash
set -eux

USERNAME=${USERNAME:-"auto"}

source $(dirname $0)/get-user.sh

# ====================[ Setup History ]====================
SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history"
mkdir /commandhistory
touch /commandhistory/.bash_history
chown -R $USERNAME /commandhistory
echo "$SNIPPET" >>"/home/$USERNAME/.bashrc" >>"/home/$USERNAME/.zshrc"
