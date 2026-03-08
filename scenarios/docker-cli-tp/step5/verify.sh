#!/bin/bash
# Vérifie qu'il ne reste aucun conteneur à l'état "exited"
EXITED=$(docker ps -a --filter "status=exited" -q | wc -l)
if [ "$EXITED" -gt 0 ]; then
  echo "ERREUR : $EXITED conteneur(s) arrêté(s) encore présents."
  echo "Supprimez tous les conteneurs arrêtés."
  exit 1
fi

# Vérifie que docker inspect fonctionne sur un conteneur existant (en cours ou stoppé)
ALL=$(docker ps -a -q | head -1)
if [ -n "$ALL" ]; then
  if ! docker inspect "$ALL" &>/dev/null; then
    echo "ERREUR : docker inspect ne fonctionne pas."
    exit 1
  fi
fi

echo "✓ Aucun conteneur arrêté restant. Nettoyage réussi."
exit 0
