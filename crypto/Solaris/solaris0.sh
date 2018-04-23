#!/bin/bash
echo "Solaris Install Part 1"
apt update
apt upgrade
echo "Install text editor"
echo "This part can sometimes fail"
sudo apt-get install nano
echo "Create Solaris folder"
mkdir solaris
cd solaris
wget https://github.com/Solaris-Project/Solaris/releases/download/v2.8.0.0/solaris-daemon-2.8.0.0-linux64.tar.gz
tar xzvf solaris-daemon-2.8.0.0-linux64.tar.gz
./solarisd -daemon
wget https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/Solaris/solaris1.sh
chmod +x solaris1.sh
sudo bash solaris1.sh
