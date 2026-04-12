#!/bin/bash
# Attendre que le cluster soit prêt
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do sleep 2; done
echo "Cluster ready"
