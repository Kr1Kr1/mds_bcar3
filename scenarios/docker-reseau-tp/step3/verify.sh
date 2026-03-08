#!/bin/bash
# Vérifie qu'au moins un conteneur est connecté à deux réseaux bridge personnalisés

# Trouver tous les réseaux bridge personnalisés
CUSTOM_NETS=$(docker network ls --format '{{.Name}} {{.Driver}}' \
  | awk '$2=="bridge" && $1!="bridge" {print $1}')

NET_COUNT=$(echo "$CUSTOM_NETS" | grep -c .)

if [ "$NET_COUNT" -lt 2 ]; then
  echo "ERREUR : seulement $NET_COUNT réseau(x) bridge personnalisé(s). Il en faut au moins 2."
  exit 1
fi

# Chercher un conteneur présent sur ≥2 réseaux bridge perso
MULTI_NET_CONTAINER=""
for cid in $(docker ps -q); do
  cname=$(docker inspect "$cid" --format '{{.Name}}' | sed 's|/||')
  count=0
  for net in $CUSTOM_NETS; do
    if docker network inspect "$net" --format '{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null | grep -qw "$cname"; then
      count=$((count + 1))
    fi
  done
  if [ "$count" -ge 2 ]; then
    MULTI_NET_CONTAINER="$cname"
    break
  fi
done

if [ -z "$MULTI_NET_CONTAINER" ]; then
  echo "ERREUR : aucun conteneur connecté à plusieurs réseaux personnalisés."
  echo "Utilisez : docker network connect <reseau-b> <nom-conteneur>"
  exit 1
fi

echo "✓ Le conteneur '$MULTI_NET_CONTAINER' est connecté à plusieurs réseaux."
exit 0
