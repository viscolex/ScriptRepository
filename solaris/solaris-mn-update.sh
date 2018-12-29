#!/bin/bash

echo "Creating Swap File..."
echo "This may take a few minutes, please be patient..."

sudo dd if=/dev/zero of=/swapfile bs=1024 count=2097152
chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "Installing new Solaris wallet version...."

wget https://github.com/Solaris-Project/Solaris/releases/download/v2.8.1.0/solaris-daemon-2.8.1.0-linux64.tar.gz
tar xzvf solaris-daemon-2.8.1.0-linux64.tar.gz

echo "Startining the wallet and synchronizing from Block 0..."

./solarisd -daemon -reindex
