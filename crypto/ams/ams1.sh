#!/bin/bash
wget -O /root/.amsterdamcoin/masternode.conf https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/ams/masternode.conf
echo "Copy the contents from your local Masternode.conf to the VPS"
nano /root/.amsterdamcoin/masternode.conf
echo "Copy the contents from your local amsterdamcoin.conf to the VPS"
wget -O /root/.amsterdamcoin/amsterdamcoin.conf https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/ams/ams.conf
nano /root/.amsterdamcoin/ams.conf
./amsterdamcoind -daemon