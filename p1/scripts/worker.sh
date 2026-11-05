
#!/bin/sh
set -e

: "${K3S_TOKEN:?La variable K3S_TOKEN est obligatoire}"

echo "Redémarrage du service réseau..."
rc-service networking restart || true

echo "Attente de la connexion Internet..."
until ping -c 1 github.com >/dev/null 2>&1; do
    sleep 2
done

echo "Installation de K3s en mode agent..."
curl -sfL https://get.k3s.io -o /tmp/install-k3s.sh

export K3S_URL="https://192.168.56.110:6443"
export K3S_TOKEN

sh /tmp/install-k3s.sh agent \
    --node-ip 192.168.56.111 \
    --flannel-iface eth1 \
    --node-name afaugeroSW

