#!/bin/bash
READY=$(kubectl get deployment webapp --no-headers 2>/dev/null | awk '{print $2}')
if [ "$READY" = "3/3" ]; then
  echo "✓ Deployment webapp : 3/3 pods Running"
  exit 0
fi
echo "ERREUR : Deployment webapp pas prêt (état: ${READY:-non trouvé})"
echo "Vérifiez : kubectl get deployment webapp"
exit 1
