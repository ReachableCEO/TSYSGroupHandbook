#!/bin/bash
#Make a proxmox server

rm -f /etc/apt/sources.list.d/*
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg
chmod +r /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg  # optional, if you have a non-default umask
apt update && apt -y full-upgrade
apt-get -y install ifupdown2 ipmitool ethtool net-tools lshw

curl -s http://dl.turnsys.net/newSrv.sh|/bin/bash

