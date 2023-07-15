#!/usr/bin/env bash
set -eux

# Comma separated list of plugins to install
PLUGINS=${PLUGINS:-""}
# The user to install Antidote for
USERNAME=${USERNAME:-"auto"}

source $(dirname $0)/get-user.sh

# ====================[ Prerequisites ]====================
# If git is not installed, install it
if ! command -v git >/dev/null; then
  apt-get update
  apt-get install -y git
fi

# If sudo is not installed, install it
if ! command -v sudo >/dev/null; then
  apt-get update
  apt-get install -y sudo
fi

# If curl is not installed, install it
if ! command -v curl >/dev/null; then
  apt-get update
  apt-get install -y curl
fi

# ====================[ Install Antidote ]====================
# Install Antidote
git clone --depth=1 https://github.com/mattmc3/antidote.git $user_home/.antidote
# Set permissions to user
chown -R ${USERNAME}:${group_name} $user_home/.antidote

# Create .zsh_plugins.txt
touch $user_home/.zsh_plugins.txt
# Set permissions to user
chown ${USERNAME}:${group_name} $user_home/.zsh_plugins.txt

# ====================[ Add Plugins ]====================

# Function to add a plugin to .zsh_plugins.txt
add_plugin() {
  echo $1 >>$user_home/.zsh_plugins.txt
}

# Add oh-my-zsh & plugins
add_plugin "ohmyzsh/ohmyzsh path:lib"
add_plugin "ohmyzsh/ohmyzsh path:plugins/git"
add_plugin "ohmyzsh/ohmyzsh path:plugins/z"
add_plugin "ohmyzsh/ohmyzsh path:plugins/colorize"
add_plugin "ohmyzsh/ohmyzsh path:plugins/command-not-found"

# Add plugins to .zsh_plugins.txt, split comma separated list into newlines
echo $PLUGINS | tr ',' '\n' >>$user_home/.zsh_plugins.txt

add_plugin "zsh-users/zsh-syntax-highlighting"
add_plugin "zsh-users/zsh-autosuggestions"
add_plugin "zsh-users/zsh-completions"

# Now, configure and run compinit to initialize completions
add_plugin "belak/zsh-utils path:completion"

# ====================[ Configure Antidote ]====================

# Add Antidote to start of .zshrc
printf '%s\n%s\n' "
source $user_home/.antidote/antidote.zsh
antidote load $user_home/.zsh_plugins.txt
" "$(cat $user_home/.zshrc)" >$user_home/.zshrc

# ====================[ Configure oh-my-zsh ]====================

# Comment out oh-my-zsh source in .zshrc
sed -i 's/^source $ZSH\/oh-my-zsh.sh/# source $ZSH\/oh-my-zsh.sh/g' $user_home/.zshrc

# ====================[ Set Default Shell ]====================

# Set zsh as default shell
chsh -s /bin/zsh ${USERNAME}

# ====================[ Install Starship ]====================
sudo -u ${USERNAME} sh -c 'curl -sS https://starship.rs/install.sh | sh -s -- --yes'
# Add starship to .zshrc
echo 'eval "$(starship init zsh)"' >>$user_home/.zshrc
# Add starship completions to .zshrc
echo 'eval "$(starship completions zsh)"' >>$user_home/.zshrc

# Create starship.toml
mkdir -p $user_home/.config && touch $user_home/.config/starship.toml
# Set permissions to user
chown -R ${USERNAME}:${group_name} $user_home/.config

# ====================[ Starship Config ]====================
# Add starship config to starship.toml
echo '
  format = '\''$directory$all'\''

[kubernetes]
  format = '\''[$symbol$context( \($namespace\))]($style) '\''
  style = '\''blue'\''
  disabled = false

[gcloud]
  disabled = true

[aws]
  disabled = true

[nodejs]
  disabled = true

[python]
  disabled = true

[php]
  disabled = true
' >$user_home/.config/starship.toml
