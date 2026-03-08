#!/bin/bash
# Vérifie qu'un conteneur ubuntu tourne en arrière-plan
RUNNING=$(docker ps --filter "ancestor=ubuntu" --format '{{.ID}}' | wc -l)
if [ "$RUNNING" -lt 1 ]; then
  echo "ERREUR : aucun conteneur ubuntu en cours d'exécution."
  echo "Lancez un conteneur ubuntu en arrière-plan avec bash."
  exit 1
fi

echo "✓ $RUNNING conteneur(s) ubuntu actif(s)."
exit 0
