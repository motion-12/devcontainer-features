#!/usr/bin/env bash
set -eux

USERNAME=${USERNAME:-"auto"}

source $(dirname $0)/get-user.sh

# Install Google Cloud SDK + gke-gcloud-auth-plugin
apt-get update
bash $(dirname $0)/install-gcloud.sh
apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/
