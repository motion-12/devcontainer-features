#!/bin/bash

# Optional: Import test library
source dev-container-features-test-lib

set -e

check "git-delta-exists" delta --version

# Report result
reportResults