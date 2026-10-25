#!/bin/sh

set -e
: "${K3S_TOKEN:?Missing K3S_TOKEN, check env file}"

curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.110:6443" K3S_TOKEN="$K3S_TOKEN" \
  sh -s - agent --node-ip 192.168.56.111 --flannel-iface eth1
