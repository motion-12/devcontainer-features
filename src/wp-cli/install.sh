#!/usr/bin/env bash

set -eux

# Download the WP CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Install the CLI
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp