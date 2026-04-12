#!/bin/bash
# Vérifier que le pod avec toleration est Running
STATUS=$(kubectl get pod app-avec-toleration --no-headers 2>/dev/null | awk '{print $3}')
if [ "$STATUS" = "Running" ]; then
  echo "✓ app-avec-toleration est en état Running"
  exit 0
fi
echo "ERREUR : app-avec-toleration n'est pas Running (état: ${STATUS:-non trouvé})"
echo "Vérifiez avec : kubectl get pod app-avec-toleration -o wide"
exit 1
