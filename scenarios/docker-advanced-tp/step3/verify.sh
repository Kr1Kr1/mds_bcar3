#!/bin/bash
# Vérifie : Dockerfile optimisé (COPY package*.json avant COPY . .) + image buildée + .dockerignore

# 1. Trouver le Dockerfile optimisé
DOCKERFILE=$(find /root -name "Dockerfile*" 2>/dev/null | xargs grep -l "package\*\.json\|package\.json" 2>/dev/null | head -1)

if [ -z "$DOCKERFILE" ]; then
  echo "ERREUR : aucun Dockerfile avec 'COPY package*.json' trouvé."
  echo "Créez un Dockerfile optimisé qui copie d'abord les fichiers de dépendances."
  exit 1
fi

# 2. Vérifier l'ordre : package*.json doit apparaître AVANT "COPY . ."
PKG_LINE=$(grep -n "package\*\.json\|package\.json" "$DOCKERFILE" | head -1 | cut -d: -f1)
DOT_LINE=$(grep -n "COPY \. \." "$DOCKERFILE" | head -1 | cut -d: -f1)

if [ -n "$PKG_LINE" ] && [ -n "$DOT_LINE" ] && [ "$PKG_LINE" -lt "$DOT_LINE" ]; then
  echo "✓ Ordre correct : COPY package*.json (ligne $PKG_LINE) avant COPY . . (ligne $DOT_LINE)"
else
  echo "ERREUR : 'COPY package*.json' doit apparaître AVANT 'COPY . .' dans le Dockerfile."
  exit 1
fi

# 3. Vérifier qu'une image a été buildée depuis ce répertoire
DIR=$(dirname "$DOCKERFILE")
if ! docker images --format '{{.Repository}}' | grep -qv "^<none>$"; then
  echo "ERREUR : aucune image buildée. Lancez : docker build -t node-app ."
  exit 1
fi

# 4. Vérifier la présence d'un .dockerignore
if [ ! -f "$DIR/.dockerignore" ]; then
  echo "AVERTISSEMENT : pas de .dockerignore trouvé dans $DIR."
fi

echo "✓ Dockerfile optimisé valide : $DOCKERFILE"
exit 0
