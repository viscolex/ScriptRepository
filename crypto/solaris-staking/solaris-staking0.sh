#!/bin/bash
echo "Solaris Install Part 1"
apt update
apt upgrade
sudo apt-get install nano
mkdir solaris
cd solaris 
wget https://github.com/Solaris-Project/Solaris/releases/download/v2.8.0.0/solaris-daemon-2.8.0.0-linux64.tar.gz
tar xzvf solaris-daemon-2.8.0.0-linux64.tar.gz
./solarisd -daemon
wget https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/solaris-staking/solaris-staking1.sh
chmod +x solaris-staking1.sh
sudo bash solaris-staking1.sh
