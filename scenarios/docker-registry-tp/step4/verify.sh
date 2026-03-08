#!/bin/bash
# Vérifie que le catalogue et les tags d'au moins une image sont accessibles via l'API

# 1. Catalogue non vide
CATALOG=$(curl -s http://localhost:5000/v2/_catalog 2>/dev/null)

if [ -z "$CATALOG" ] || echo "$CATALOG" | grep -q '"repositories":\[\]'; then
  echo "ERREUR : le catalogue est vide ou le registry est inaccessible."
  echo "Assurez-vous d'avoir poussé au moins une image (étape 2)."
  exit 1
fi

# 2. Récupère le premier dépôt et vérifie ses tags
FIRST_REPO=$(echo "$CATALOG" | grep -o '"[^"]*"' | grep -v repositories | head -1 | tr -d '"')

if [ -z "$FIRST_REPO" ]; then
  echo "ERREUR : impossible d'extraire un nom de dépôt depuis le catalogue."
  exit 1
fi

TAGS=$(curl -s "http://localhost:5000/v2/${FIRST_REPO}/tags/list" 2>/dev/null)

if [ -z "$TAGS" ] || ! echo "$TAGS" | grep -q '"tags"'; then
  echo "ERREUR : l'endpoint /v2/${FIRST_REPO}/tags/list ne retourne pas de tags valides."
  echo "Réponse obtenue : $TAGS"
  exit 1
fi

echo "✓ Catalogue : $CATALOG"
echo "✓ Tags de '${FIRST_REPO}' : $TAGS"
exit 0
