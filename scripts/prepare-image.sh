#!/bin/bash
set -e

echo "Preparing image for AWS compatibility..."

# Install AWS drivers and cloud-init adjustments
sudo apt-get update
sudo apt-get install -y ec2-hibinit-agent cloud-init

# Remove Azure-specific agents
sudo apt-get remove -y walinuxagent || true

# Clean machine ID
sudo rm -f /etc/machine-id
sudo touch /etc/machine-id

echo "Image prepared. Now you can generalize and create Azure Managed Image."
