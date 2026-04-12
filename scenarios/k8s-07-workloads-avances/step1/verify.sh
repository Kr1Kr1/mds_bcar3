#!/bin/bash
# Vérifier que le StatefulSet db a 3 pods Running
READY=$(kubectl get statefulset db --no-headers 2>/dev/null | awk '{print $2}')
if [ "$READY" = "3/3" ]; then
  echo "✓ StatefulSet db : 3/3 pods Ready"
  exit 0
fi
echo "ERREUR : StatefulSet db pas encore prêt (état: ${READY:-non trouvé})"
echo "Vérifiez avec : kubectl get statefulset db"
exit 1
