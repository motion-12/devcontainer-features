#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Check neovim exists
check "neovim-exists" test -f /usr/local/bin/nvim

# Check lazygit exists
check "lazygit-exists" test -f /usr/local/bin/lazygit

# Check fzf exists
check "fzf-exists" test -f /usr/bin/fzf

# Check ripgrep exists
check "ripgrep-exists" test -f /usr/bin/rg

# Check lemonade exists
check "lemonade-exists" test -f /usr/bin/lemonade

# Check git exists
check "git-exists" command -v git

# Check sudo exists
check "sudo-exists" command -v sudo

# Check curl exists
check "curl-exists" command -v curl

# Check go exists
check "go-exists" command -v go

# Check lua5.1 exists
check "lua5.1-exists" command -v lua5.1

# Check python3 exists
check "python3-exists" command -v python3

# Check uv exists
check "uv exists" command -v uv

# Report result
reportResults
