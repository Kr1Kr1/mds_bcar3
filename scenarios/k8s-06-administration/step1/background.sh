#!/bin/bash
# Attendre que le cluster soit prêt
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do sleep 2; done
# Créer un workload de test sur node01 pour la démo drain
kubectl create deployment demo-admin --image=nginx:1.25 --replicas=3 2>/dev/null || true
echo "Cluster ready, demo workload created"
