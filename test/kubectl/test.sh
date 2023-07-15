#!/bin/bash

source dev-container-features-test-lib

check "kubectl installed" command -v kubectl

# Check kubectl completion is on .zshrc
check "kubectl completion zsh" grep -q "kubectl completion zsh" /home/vscode/.zshrc
# Check kubectl completion is on .bashrc
check "kubectl completion bash" grep -q "kubectl completion bash" /home/vscode/.bashrc

# Check helm is installed
check "helm" helm version

# Check minikube is installed
check "minikube" minikube version

# Report result
reportResults
