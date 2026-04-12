#!/bin/bash
# Vérifier que les 2 NetworkPolicies existent dans le namespace backend
NP_COUNT=$(kubectl get networkpolicy -n backend --no-headers 2>/dev/null | wc -l)
if [ "$NP_COUNT" -ge 2 ]; then
  echo "✓ $NP_COUNT NetworkPolicy(ies) créée(s) dans le namespace backend"
  exit 0
fi
echo "ERREUR : Seulement $NP_COUNT NetworkPolicy dans backend (2 attendues)"
echo "Vérifiez avec : kubectl get networkpolicy -n backend"
exit 1
