#!/bin/bash
echo "Solaris Install Part 1"
apt update
apt upgrade


echo "Solaris Install Part 2"
echo "Creating Swap File..."
echo "This may take a few minutes, please be patient..."

sudo dd if=/dev/zero of=/swapfile bs=1024 count=2097152
chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab


echo "Install nano and curl"
sudo apt-get install -y nano
sudo apt-get install -y curl
echo "Solaris Install Part 3"
echo "Download wallet"
mkdir /root/solaris
cd /root/solaris
wget https://github.com/Solaris-Project/Solaris/releases/download/v2.8.1.0/solaris-daemon-2.8.1.0-linux64.tar.gz
tar xzvf solaris-daemon-2.8.1.0-linux64.tar.gz
cp solarisd solaris-cli /usr/local/bin

solarisd

echo "Solaris Install Part 3"
echo "Creating solaris.conf and starting daemon..."
IP=$(curl http://checkip.amazonaws.com/)
PW=$(date +%s | sha256sum | base64 | head -c 32 ;)
echo "==========================================================="
pwd
echo "rpcallowip=127.0.0.1" >> /root/.solaris/solaris.conf
echo "rpcuser=solarisusernodesupply">> /root/.solaris/solaris.conf
echo "rpcpassword="$PW >> /root/.solaris/solaris.conf
echo "daemon=1" >> /root/.solaris/solaris.conf
echo "staking=1" >> /root/.solaris/solaris.conf
echo "listen=1" >> /root/.solaris/solaris.conf
echo "server=1" >>/root/.solaris/solaris.conf
echo "externalip="$IP":60020" >>/root/.solaris/solaris.conf
echo "masternodeaddr="$IP":60020" >>/root/.solaris/solaris.conf
echo "masternode=1" >>/root/.solaris/solaris.conf
echo "masternodeprivkey="$1 >>/root/.solaris/solaris.conf
cat /root/.solaris/solaris.conf

solarisd -daemon
echo "Installation complete..."
echo "Your Masternode is now synchronizing with the network..."
