#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading system..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install git if not already installed
echo "Installing Git..."
sudo apt-get install git -y

# Clone v4l2rtspserver
echo "Cloning v4l2rtspserver..."
git clone https://github.com/mpromonet/v4l2rtspserver.git

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add current user to docker group to avoid using sudo with Docker
sudo usermod -aG docker $(whoami)

# Enable Docker with systemctl
echo "Enabling Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# Connect to Wi-Fi network
echo "Please enter your Wi-Fi SSID:"
read ssid
echo "Please enter your Wi-Fi password:"
read -s password

nmcli device wifi rescan
nmcli device wifi connect "$ssid" password "$password"

echo "Script execution completed."
