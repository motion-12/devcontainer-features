#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Check .zsh_plugins.txt file exists
check "zsh-plugins-file-exists" test -f "/home/node/.zsh_plugins.txt"

# Report result
reportResults
