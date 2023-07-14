#!/bin/bash

HISTFILE=/commandhistory/.bash_history

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Enable history
set -o history
touch test123.txt
set +o history

history -a

check "history-file-exists" test -f "/commandhistory/.bash_history"

check "history-file-matches-history" diff --brief <(history | cut -c 8-) /commandhistory/.bash_history

# Report result
reportResults
