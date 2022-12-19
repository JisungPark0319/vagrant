#!/bin/bash

sudo apt-get update
sudo apt install -y git vim wget curl

function flow_display() {
  local message = $1
  echo
  echo "********** ${message} **********"
}

flow_display "Set up the repository of docker"

sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg -dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

flow_display "Install docker"
sudo apt-get install -y docker-cd docker-ce-cli containerd.io docker-compose-plugin

flow_display "Add vagrant user to docker group"
sudo usermod -aG docker vagrant
