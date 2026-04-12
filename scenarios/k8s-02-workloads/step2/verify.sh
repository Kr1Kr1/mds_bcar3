#!/bin/bash
IMAGE=$(kubectl get pods -l app=webapp -o jsonpath='{.items[0].spec.containers[0].image}' 2>/dev/null)
READY=$(kubectl get deployment webapp --no-headers 2>/dev/null | awk '{print $2}')
if [ "$READY" = "3/3" ] && [[ "$IMAGE" == *"nginx:1.25"* ]]; then
  echo "✓ Rolling update réussi — image: $IMAGE — 3/3 pods Ready"
  exit 0
fi
echo "ERREUR : Vérifiez l'état du deployment (image: ${IMAGE:-?}, ready: ${READY:-?})"
echo "Vérifiez : kubectl get deployment webapp && kubectl rollout status deployment/webapp"
exit 1
