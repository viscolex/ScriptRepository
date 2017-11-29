#!bin/bash
ufw allow ssh/tcp
ufw limit ssh/tcp
ufw allow 8168/tcp
ufw logging on
ufw enable
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "Add this to the end of the file Add the following line at the end of the file press tab to separate each word/number"
echo "/swapfile none swap sw 0 0"
nano /etc/fstab
reboot now
