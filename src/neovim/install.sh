#!/bin/bash -i

set -e

source $(dirname $0)/library-scripts.sh

# The user to install Antidote for
USERNAME=${USERNAME:-"auto"}

source $(dirname $0)/get-user.sh

ensure_nanolayer nanolayer_location "v0.4.46"

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

# ====================[ Install Neovim ]====================

# Use ghcr.io/duduribeiro/devcontainer-features/neovim:1
$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/duduribeiro/devcontainer-features/neovim:1" \
    --option version='stable'


# ====================[ Install LazyGit ]====================

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# ====================[ Install ripgrep ]====================

$nanolayer_location \
    install \
    apt-get \
    ripgrep