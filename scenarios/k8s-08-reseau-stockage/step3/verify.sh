#!/bin/bash
# Vérifier que le PVC mon-pvc est en état Bound
STATUS=$(kubectl get pvc mon-pvc --no-headers 2>/dev/null | awk '{print $2}')
if [ "$STATUS" = "Bound" ]; then
  CAPACITY=$(kubectl get pvc mon-pvc -o jsonpath='{.status.capacity.storage}' 2>/dev/null)
  echo "✓ PVC mon-pvc est Bound (capacité : ${CAPACITY:-inconnue})"
  exit 0
fi
echo "ERREUR : PVC mon-pvc n'est pas Bound (état: ${STATUS:-non trouvé})"
echo "Vérifiez avec : kubectl get pvc && kubectl describe pvc mon-pvc"
exit 1
