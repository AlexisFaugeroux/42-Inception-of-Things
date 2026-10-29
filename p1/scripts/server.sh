#!/bin/sh

set -e
: "${K3S_TOKEN:?Missing K3S_TOKEN, check env file}"

curl -sfL https://get.k3s.io | K3S_TOKEN="$K3S_TOKEN" K3S_KUBECONFIG_MODE="644" \
  sh -s - server \
  --node-ip 192.168.56.110 \
  --flannel-iface eth1 \
  --disable metrics-server \
  --disable local-storage
