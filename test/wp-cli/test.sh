#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Check if /usr/local/bin/wp exists
check "wp-cli-is-installed" bash -c "[ -f /usr/local/bin/wp ]"

# Report result
reportResults
