#!/usr/bin/env bash
set -eux

# The user to install Antidote for
VERSION=${VERSION:-"0.16.5"}

# ====================[ Get architecture ]====================
architecture="$(uname -m)"
case $architecture in
x86_64) architecture="amd64" ;;
aarch64 | armv8*) architecture="arm64" ;;
i?86) architecture="i386" ;;
*)
  echo "(!) Architecture $architecture unsupported"
  exit 1
  ;;
esac

# ====================[ Install git delta ]====================
url="https://github.com/dandavison/delta/releases/download/${VERSION}/git-delta_${VERSION}_${architecture}.deb"
curl -sL "$url" -o /tmp/git-delta.deb
sudo dpkg -i /tmp/git-delta.deb
rm /tmp/git-delta.deb