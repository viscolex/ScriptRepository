#!/bin/bash
echo "Copy the contents from your local solaris.conf to the VPS"
wget -O /root/.solaris/solaris.conf https://raw.githubusercontent.com/viscolex/ScriptRepository/master/crypto/solaris-staking/solaris.conf
./solarisd &
