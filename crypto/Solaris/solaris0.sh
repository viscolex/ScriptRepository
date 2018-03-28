#!/bin/bash
echo "Solaris Install Part 1"
apt update
apt upgrade
sudo apt-get install nano
mkdir solaris
cd solaris 
wget https://github.com/Solaris-Project/Solaris/releases/download/v2.5.0.0/solaris-daemon-2.5.0.0-linux64.tar.gz
tar xzvf solaris-daemon-2.5.0.0-linux64.tar.gz
./solarisd -daemon
wget https://raw.githubusercontent.com/HysMagus/ScriptRepository/master/crypto/masternode/solaris1.sh
chmod +x solaris1.sh
sudo bash solaris1.sh
