#!/bin/bash
echo "Amsterdam Coin Install Part 1"
apt update
apt upgrade
sudo apt-get install nano
mkdir ams
cd ams 
wget https://github.com/CoinProjects/AmsterdamCoin-v4/releases/download/v4.1.0.0/amsterdamcoin-daemon-4.1.0.0-linux64.tar.gz
tar xzvf amsterdamcoin-daemon-4.1.0.0-linux64.tar.gz
./amsterdamcoind -daemon
wget https://raw.githubusercontent.com/HysMagus/ScriptRepository/master/crypto/masternode/solaris1.sh
chmod +x solaris1.sh
sudo bash solaris1.sh
