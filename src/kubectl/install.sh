#!/usr/bin/env bash
set -eux

USERNAME=${USERNAME:-"auto"}

source $(dirname $0)/get-user.sh

# Install kubectl, helm + minikube
apt-get update
/bin/bash $(dirname $0)/install-kubectl.sh "latest" "latest" "none"
apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

# Alias kubectl to k
echo "alias k=kubectl" | tee -a /root/.bashrc /root/.zshrc /home/${USERNAME}/.bashrc >>/home/${USERNAME}/.zshrc
# Add autocomplete for kubectl to bash/zsh shell
echo "source <(kubectl completion zsh)" >>/home/${USERNAME}/.zshrc
echo "source <(kubectl completion bash)" >>/home/${USERNAME}/.bashrc

# Fix permissions for .kube folder
mkdir -p /home/${USERNAME}/.kube
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.kube