#!/bin/bash
SVC=$(kubectl get svc webapp-svc --no-headers 2>/dev/null | awk '{print $1}')
NP=$(kubectl get svc webapp-nodeport --no-headers 2>/dev/null | awk '{print $1}')
if [ "$SVC" = "webapp-svc" ] && [ "$NP" = "webapp-nodeport" ]; then
  echo "✓ Services ClusterIP et NodePort créés"
  exit 0
fi
echo "ERREUR : Services manquants (webapp-svc: ${SVC:-absent}, webapp-nodeport: ${NP:-absent})"
exit 1
