#!/bin/bash
# Vérifie le Dockerfile corrigé dans /root/good-app/

DOCKERFILE="/root/good-app/Dockerfile"

if [ ! -f "$DOCKERFILE" ]; then
  echo "ERREUR : fichier '$DOCKERFILE' introuvable."
  echo "Créez votre Dockerfile corrigé dans /root/good-app/Dockerfile"
  exit 1
fi

ERRORS=0

# 1. Pas de secrets en dur
if grep -qiE "^\s*ENV.*(PASSWORD|PASS|SECRET|TOKEN|KEY)\s*=\s*\S+" "$DOCKERFILE"; then
  echo "ERREUR : secrets en dur détectés dans le Dockerfile (ENV PASSWORD=...)."
  ERRORS=$((ERRORS + 1))
fi

# 2. Un USER non-root doit être défini
if ! grep -qE "^\s*USER\s+[a-zA-Z]" "$DOCKERFILE"; then
  echo "ERREUR : aucune instruction USER non-root trouvée."
  echo "Ajoutez : RUN useradd -m appuser && USER appuser"
  ERRORS=$((ERRORS + 1))
fi

# 3. USER root explicite interdit
if grep -qE "^\s*USER\s+root" "$DOCKERFILE"; then
  echo "ERREUR : USER root explicitement défini — à corriger."
  ERRORS=$((ERRORS + 1))
fi

# 4. WORKDIR ne doit pas être /root
if grep -qE "^\s*WORKDIR\s+/root" "$DOCKERFILE"; then
  echo "ERREUR : WORKDIR /root est une mauvaise pratique."
  ERRORS=$((ERRORS + 1))
fi

# 5. .dockerignore présent
if [ ! -f "/root/good-app/.dockerignore" ]; then
  echo "AVERTISSEMENT : pas de .dockerignore dans /root/good-app/"
fi

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "$ERRORS problème(s) détecté(s) dans le Dockerfile corrigé."
  exit 1
fi

echo "✓ Dockerfile corrigé valide : pas de secrets en dur, USER non-root, WORKDIR correct."
exit 0
