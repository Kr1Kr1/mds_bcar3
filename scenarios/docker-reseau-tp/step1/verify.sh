#!/bin/bash
# Vérifie qu'au moins 2 conteneurs sont connectés au réseau bridge par défaut
BRIDGE_CONTAINERS=$(docker network inspect bridge \
  --format '{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null | wc -w)

if [ "${BRIDGE_CONTAINERS:-0}" -lt 2 ]; then
  echo "ERREUR : seulement $BRIDGE_CONTAINERS conteneur(s) sur le bridge par défaut, 2 minimum attendus."
  echo "Lancez au moins 2 conteneurs sans spécifier de réseau."
  exit 1
fi

echo "✓ $BRIDGE_CONTAINERS conteneur(s) sur le bridge par défaut."
exit 0
