#!/bin/bash

echo "Creating Swap File..."
echo "This may take a few minutes, please be patient."

sudo dd if=/dev/zero of=/mnt/swapfile bs=1024 count=2097152

sudo mkswap /swapfile

sudo swapon /swapfile

echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
