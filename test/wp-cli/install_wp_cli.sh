#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

check "wp-cli-is-installed" bash -c "wp --version"

# Report result
reportResults