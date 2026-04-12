#!/bin/bash
CM=$(kubectl get configmap app-config --no-headers 2>/dev/null | awk '{print $1}')
POD1=$(kubectl get pod app-pod --no-headers 2>/dev/null | awk '{print $3}')
POD2=$(kubectl get pod app-pod-vol --no-headers 2>/dev/null | awk '{print $3}')
if [ "$CM" = "app-config" ] && [ "$POD1" = "Running" ] && [ "$POD2" = "Running" ]; then
  echo "✓ ConfigMap créé, les 2 pods utilisent la configuration"
  exit 0
fi
echo "ERREUR : configmap=${CM:-absent}, app-pod=${POD1:-absent}, app-pod-vol=${POD2:-absent}"
exit 1
