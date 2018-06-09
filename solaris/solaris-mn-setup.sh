#!/bin/bash

# Write variables
privkey=$1

echo "Solaris Install Part 1"
apt update
apt upgrade
echo "Install nano and curl"
sudo apt-get install -y nano
sudo apt-get install -y curl

echo "Part 2, download wallet"

mkdir /root/solaris
cd /root/solaris
wget https://github.com/Solaris-Project/Solaris/releases/download/v2.8.0.0/solaris-daemon-2.8.0.0-linux64.tar.gz
tar xzvf solaris-daemon-2.8.0.0-linux64.tar.gz
cp solarisd solaris-cli /usr/local/bin

solarisd -daemon

echo "Part 3, create solaris.conf"
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
echo "masternodeprivkey="$privkey >>/root/.solaris/solaris.conf
cat /root/.solaris/solaris.conf

Echo "Part 4, start daemon"
solarisd
