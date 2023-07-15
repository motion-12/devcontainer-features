USERNAME=${USERNAME:-"auto"}
USER_UID="${USERUID:-"automatic"}"
USER_GID="${USERGID:-"automatic"}"

# ====================[ Prerequisites ]====================
# If sudo is not installed, install it
if ! command -v sudo >/dev/null; then
  apt-get update
  apt-get install -y sudo
fi

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

if id -u ${USERNAME} >/dev/null 2>&1; then
  # User exists, update if needed
  if [ "${USER_GID}" != "automatic" ] && [ "$USER_GID" != "$(id -g $USERNAME)" ]; then
    group_name="$(id -gn $USERNAME)"
    groupmod --gid $USER_GID ${group_name}
    usermod --gid $USER_GID $USERNAME
  fi
  if [ "${USER_UID}" != "automatic" ] && [ "$USER_UID" != "$(id -u $USERNAME)" ]; then
    usermod --uid $USER_UID $USERNAME
  fi
else
  # Create user
  if [ "${USER_GID}" = "automatic" ]; then
    groupadd $USERNAME
  else
    groupadd --gid $USER_GID $USERNAME
  fi
  if [ "${USER_UID}" = "automatic" ]; then
    useradd -s /bin/bash --gid $USERNAME -m $USERNAME
  else
    useradd -s /bin/bash --uid $USER_UID --gid $USERNAME -m $USERNAME
  fi
fi

# Add add sudo support for non-root user if they are not already added
if [ "${USERNAME}" != "root" ]; then
  if ! sudo -l -U ${USERNAME} | grep -q "ALL = (ALL) NOPASSWD: ALL"; then
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/$USERNAME
    chmod 0440 /etc/sudoers.d/$USERNAME
  fi
fi

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
