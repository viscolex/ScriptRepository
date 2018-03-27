#!/bin/bash
wget -O /root/.solaris/masternode.conf https://raw.githubusercontent.com/HysMagus/ScriptRepository/master/crypto/masternode/masternode.conf
echo "Copy the contents from your local Masternode.conf to the VPS"
nano /root/.solaris/masternode.conf
nano /root/.solaris/masternode.conf
echo "Copy the contents from your local solaris.conf to the VPS"
wget -O /root/.solaris/solaris.conf https://raw.githubusercontent.com/HysMagus/ScriptRepository/master/crypto/masternode/solaris.conf
nano /root/.solaris/solaris.conf
./solarisd -daemon
