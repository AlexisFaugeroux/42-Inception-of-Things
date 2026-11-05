#!/bin/sh

until kubectl get nodes 2>/dev/null | grep -q Ready; do
	sleep 2
done

kubectl apply -R -f /home/vagrant/k8s/


