#!/bin/bash

source dev-container-features-test-lib

check "version" gcloud --version

# Report result
reportResults
