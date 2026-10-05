#!/bin/bash

# Update packages
apt-get update -y

# Install Ansible
apt-get install -y ansible

# Install Git
apt-get install -y git

# Create Ansible directory
mkdir -p /home/ubuntu/ansible

# Give ownership to ubuntu user
chown -R ubuntu:ubuntu /home/ubuntu/ansible

# Verify Ansible installation
ansible --version > /home/ubuntu/ansible-installation.txt