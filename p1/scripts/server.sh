#!/bin/sh

set -e
: "${K3S_TOKEN:?Missing K3S_TOKEN, check env file}"

curl -sfL https://get.k3s.io | K3S_TOKEN="$K3S_TOKEN" K3S_KUBECONFIG_MODE="644" \
  sh -s - server \
  --node-ip 192.168.56.110 \
  --flannel-iface eth1 \
  --disable metrics-server \
  --disable local-storage

# afaugeroS:~$ sudo apk update
# v3.24.3-75-g173e5df045a [http://dl-cdn.alpinelinux.org/alpine/v3.24/main]
# v3.24.3-79-gfa37588f053 [http://dl-cdn.alpinelinux.org/alpine/v3.24/community]
# OK: 28693 distinct packages available
# afaugeroS:~$ sudo apk add linux-virt
# OK: 183.7 MiB in 211 packages
# afaugeroS:~$ sudo apk add iptables
# (1/5) Installing libmnl (1.0.5-r2)
# (2/5) Installing libnftnl (1.3.1-r0)
# (3/5) Installing libxtables (1.8.13-r0)
# (4/5) Installing iptables (1.8.13-r0)
# (5/5) Installing iptables-openrc (1.8.13-r0)
# Executing busybox-1.37.0-r31.trigger
# OK: 185.8 MiB in 216 packages
# afaugeroS:~$ apk info -L linux-virt | grep -E 'ip_tables|iptable_nat|iptable_filter|br_netfilter'
# lib/modules/6.18.54-0-virt/kernel/net/bridge/br_netfilter.ko.gz
# afaugeroS:~$ ls /lib/modules/
# 6.18.54-0-virt
