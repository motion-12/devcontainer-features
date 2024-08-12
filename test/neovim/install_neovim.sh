#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Check neovim exists
check "neovim-exists" test -f /usr/local/bin/nvim

# Check lazygit exists
check "lazygit-exists" test -f /usr/local/bin/lazygit

# Check ripgrep exists
check "ripgrep-exists" test -f /usr/bin/rg

# Report result
reportResults
