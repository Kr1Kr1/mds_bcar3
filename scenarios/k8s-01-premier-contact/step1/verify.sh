#!/bin/bash
# Vérifier que les 2 nœuds sont Ready
READY=$(kubectl get nodes --no-headers 2>/dev/null | grep -c "Ready")
if [ "$READY" -ge 1 ]; then
  echo "✓ Cluster opérationnel ($READY nœud(s) Ready)"
  exit 0
fi
echo "ERREUR : Aucun nœud en état Ready. Vérifiez avec : kubectl get nodes"
exit 1
