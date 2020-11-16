#!/bin/bash 

set -e
#sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

sudo apt install -y postgresql

#Docker commands install Ubuntu
#sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt install -y      \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get install docker-ce docker-ce-cli containerd.io


