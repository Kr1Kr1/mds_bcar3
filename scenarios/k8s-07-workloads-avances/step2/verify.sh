#!/bin/bash
# Vérifier que le DaemonSet node-monitor a des pods Running sur les nœuds
DESIRED=$(kubectl get daemonset node-monitor --no-headers 2>/dev/null | awk '{print $2}')
READY=$(kubectl get daemonset node-monitor --no-headers 2>/dev/null | awk '{print $4}')
if [ -n "$DESIRED" ] && [ "$DESIRED" = "$READY" ] && [ "$DESIRED" -ge 2 ]; then
  echo "✓ DaemonSet node-monitor : $READY/$DESIRED pods Ready"
  exit 0
fi
echo "ERREUR : DaemonSet node-monitor pas encore prêt (DESIRED=$DESIRED READY=$READY)"
echo "Vérifiez avec : kubectl get daemonset node-monitor"
exit 1
