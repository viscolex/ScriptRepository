#!bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev
git clone https://github.com/zcoinofficial/cpuminer-xzc.git
cd cpuminer-xzc/
./autogen.sh	
./configure CFLAGS="-march=native" --with-crypto --with-curl
echo "Hopefully this worked! Send me some Zcoin! a7deCQ5f9WWSkSSVjsM7wneAfMgPRQSAyG"
