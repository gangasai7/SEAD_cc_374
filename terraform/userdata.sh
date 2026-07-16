#!/bin/bash

set -e

echo "========== Updating System =========="
apt-get update -y
apt-get upgrade -y

echo "========== Installing Required Packages =========="
apt-get install -y \
    docker.io \
    git \
    curl \
    wget \
    unzip \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

echo "========== Enabling Docker =========="
systemctl enable docker
systemctl start docker

# Allow ubuntu user to use docker without sudo
usermod -aG docker ubuntu

echo "========== Installing kubectl =========="

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm kubectl

echo "========== Installing Minikube =========="

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

install minikube-linux-amd64 /usr/local/bin/minikube

rm minikube-linux-amd64

echo "========== Installing AWS CLI =========="

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip awscliv2.zip

./aws/install

rm -rf aws

rm awscliv2.zip

echo "========== Installing Helm =========="

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "========== Installation Completed =========="