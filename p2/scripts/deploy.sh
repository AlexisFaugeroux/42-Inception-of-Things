#!/bin/sh

until kubectl get nodes 2>/dev/null | grep -q Ready; do
	sleep 2
done

kubectl kustomize /home/vagrant/conf/k8s/ --load-restrictor LoadRestrictionsNone | kubectl apply -f -
