#!/bin/bash
# Write variables
privkey=$1
echo "Solaris Install Part 1"
apt update
apt upgrade
echo "Install nano and curl"
sudo apt-get install -y nano
sudo apt-get install -y curl
echo "Let's move to part two"
wget https://gist.githubusercontent.com/viscolex/bf2d3aca195ec18281a826a1e3487b49/raw/1fe16fd5b8239f07a21479d6ca9d4bc66f0e8a00/solaris-masternode-setup.sh
chmod +x solaris-masternode-setup.sh
sudo bash solaris-masternode-setup.sh
