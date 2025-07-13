#!/bin/bash
set -euo pipefail

# Detect OS
. /etc/os-release
OS="$ID"
VERSION="$VERSION_ID"

# 1. Remove old versions (optional)
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
sudo yum remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

# 2. Install dependencies
if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl gnupg lsb-release
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/$OS/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$OS \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

elif [[ "$OS" == "rocky" || "$OS" == "centos" || "$OS" == "almalinux" ]]; then
  sudo yum install -y yum-utils ca-certificates curl gnupg
  sudo mkdir -p /etc/yum/keyrings
  curl -fsSL https://download.docker.com/linux/centos/gpg | gpg --dearmor | sudo tee /etc/yum/keyrings/docker.gpg > /dev/null
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# 3. Start and enable Docker
sudo systemctl enable --now docker

# 4. Test Docker
sudo docker version
sudo docker compose version

# 5. Add current user to docker group (optional, safer than running as root)
sudo usermod -aG docker "$USER"
echo "✅ Docker & Docker Compose installed. Please log out and log back in to use Docker without sudo."
