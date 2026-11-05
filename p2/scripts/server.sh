#!/bin/sh

set -e

if [ ! -f /swapfile ] ; then
	dd if=/dev/zero of=/swapfile bs=1M count=1024 #if -> input file, of -> ouptut file, bs -> block size, count -> copie 1024 blocks
	chmod 600 /swapfile # only root can read and write
	mkswap /swapfile # swap format -> writes an header at the beginning of the file (signature + size + uuid) to make the file recognizable as a swap zone
fi

if ! grep -q '^/swapfile[[:space:]]' /etc/fstab; then
	echo "/swapfile none swap sw 0 0" >> /etc/fstab # makes the file available in /etc/fstab that lists all the known swaps
fi

# Enable swap now
swapon -a
# Enable swap at boot
rc-update add swap boot

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644" sh -s - \
  --node-ip 192.168.56.110 \
  --flannel-iface eth1 \
  --disable metrics-server \
  --disable local-storage
