#!/bin/bash
wget -O /root/.solaris/masternode.conf https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/ams/masternode.conf
echo "Copy the contents from your local Masternode.conf to the VPS"
nano /root/.amsterdamcoin/masternode.conf
echo "Copy the contents from your local solaris.conf to the VPS"
wget -O /root/.solaris/solaris.conf https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/ams/ams.conf
nano /root/.amsterdamcoin/ams.conf
./amsterdamcoind -daemon
