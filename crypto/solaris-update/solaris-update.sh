#!/bin/bash
echo "Solaris VPS update"
cd solaris
./solarisd -stop
wget https://github.com/Solaris-Project/Solaris/releases/download/v2.5.0.0/solaris-daemon-2.5.0.0-linux64.tar.gz
tar xzvf solaris-daemon-2.5.0.0-linux64.tar.gz
./solarisd -daemon