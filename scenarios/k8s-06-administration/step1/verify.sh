#!/bin/bash
# Vérifier que tous les composants du control plane sont Running
RUNNING=$(kubectl get pods -n kube-system --no-headers 2>/dev/null | grep -v "Completed" | grep -c "Running")
if [ "$RUNNING" -ge 5 ]; then
  echo "✓ Control plane opérationnel ($RUNNING pods Running dans kube-system)"
  exit 0
fi
echo "ERREUR : Seulement $RUNNING pods Running dans kube-system"
echo "Vérifiez avec : kubectl get pods -n kube-system"
exit 1
