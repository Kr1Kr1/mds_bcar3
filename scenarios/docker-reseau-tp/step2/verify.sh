#!/bin/bash
# Vérifie qu'un réseau bridge personnalisé existe avec ≥2 conteneurs nommés connectés

# 1. Trouver un réseau bridge personnalisé (pas "bridge", "host" ou "none")
CUSTOM_NET=$(docker network ls --format '{{.Name}} {{.Driver}}' \
  | awk '$2=="bridge" && $1!="bridge" {print $1}' | head -1)

if [ -z "$CUSTOM_NET" ]; then
  echo "ERREUR : aucun réseau bridge personnalisé trouvé."
  echo "Créez un réseau avec : docker network create <nom>"
  exit 1
fi

# 2. Compter les conteneurs sur ce réseau
NET_CONTAINERS=$(docker network inspect "$CUSTOM_NET" \
  --format '{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null | wc -w)

if [ "${NET_CONTAINERS:-0}" -lt 2 ]; then
  echo "ERREUR : seulement $NET_CONTAINERS conteneur(s) sur '$CUSTOM_NET', 2 minimum attendus."
  echo "Lancez des conteneurs avec : docker run --network $CUSTOM_NET --name <nom> ..."
  exit 1
fi

echo "✓ Réseau personnalisé '$CUSTOM_NET' avec $NET_CONTAINERS conteneur(s)."
exit 0
