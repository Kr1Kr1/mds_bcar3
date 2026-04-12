#!/bin/bash
# Vérifier que node01 est de nouveau schedulable (uncordonné)
STATUS=$(kubectl get node node01 --no-headers 2>/dev/null | awk '{print $2}')
if echo "$STATUS" | grep -q "SchedulingDisabled"; then
  echo "ERREUR : node01 est encore cordonné (SchedulingDisabled)"
  echo "Lancez : kubectl uncordon node01"
  exit 1
fi
if echo "$STATUS" | grep -q "Ready"; then
  echo "✓ node01 est en état Ready et schedulable"
  exit 0
fi
echo "ERREUR : node01 est dans un état inattendu : $STATUS"
exit 1
