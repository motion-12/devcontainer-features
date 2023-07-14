#!/usr/bin/env bash
set -eux

USERNAME=${USERNAME:-"auto"}

# ====================[ Get User ]====================
# If in automatic mode, determine if a user already exists, if not use vscode
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
  if [ "${_REMOTE_USER}" != "root" ]; then
    USERNAME="${_REMOTE_USER}"
  else
    USERNAME=""
    POSSIBLE_USERS=("devcontainer" "vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
      if id -u ${CURRENT_USER} >/dev/null 2>&1; then
        USERNAME=${CURRENT_USER}
        break
      fi
    done
    if [ "${USERNAME}" = "" ]; then
      USERNAME=vscode
    fi
  fi
elif [ "${USERNAME}" = "none" ]; then
  USERNAME=root
  USER_UID=0
  USER_GID=0
fi

# The group for the user
group_name="${USERNAME}"

# The home directory of the user
if [ "${USERNAME}" = "root" ]; then
  user_home="/root"
else
  user_home="/home/${USERNAME}"
  if [ ! -d "${user_home}" ]; then
    mkdir -p "${user_home}"
    chown ${USERNAME}:${group_name} "${user_home}"
  fi
fi

# ====================[ Setup History ]====================
SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history"
mkdir /commandhistory
touch /commandhistory/.bash_history
chown -R $USERNAME /commandhistory
echo "$SNIPPET" >>"/home/$USERNAME/.bashrc" >>"/home/$USERNAME/.zshrc"
