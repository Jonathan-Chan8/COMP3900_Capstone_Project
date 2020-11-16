#!/bin/bash 

set -e
sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

sudo apt install -y      \
    postgresql
    

