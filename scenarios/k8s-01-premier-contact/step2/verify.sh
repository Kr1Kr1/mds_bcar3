#!/bin/bash
# Vérifier que nginx-pod est Running
STATUS=$(kubectl get pod nginx-pod --no-headers 2>/dev/null | awk '{print $3}')
if [ "$STATUS" = "Running" ]; then
  echo "✓ nginx-pod est en état Running"
  exit 0
fi
echo "ERREUR : nginx-pod n'est pas Running (état: ${STATUS:-non trouvé})"
echo "Vérifiez avec : kubectl get pods"
exit 1
