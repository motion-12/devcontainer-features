#!/usr/bin/env bash

set -eux

# If curl is not installed, install it
if ! command -v curl >/dev/null; then
  apt-get update
  apt-get install -y curl
fi

# Download the WP CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Install the CLI
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
