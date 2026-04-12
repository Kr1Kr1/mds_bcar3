#!/bin/bash
# Vérifier que nginx-pod est supprimé
if kubectl get pod nginx-pod 2>/dev/null | grep -q "nginx-pod"; then
  echo "ERREUR : nginx-pod existe encore. Supprimez-le : kubectl delete pod nginx-pod"
  exit 1
fi
echo "✓ nginx-pod supprimé — cluster propre"
exit 0
