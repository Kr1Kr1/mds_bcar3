#!/bin/bash
# Vérifie qu'une image monimage-dockerfile existe
if ! docker images --format '{{.Repository}}' | grep -q "monimage-dockerfile"; then
  echo "ERREUR : l'image 'monimage-dockerfile' est introuvable."
  echo "Créez un Dockerfile et construisez l'image avec : docker build -t monimage-dockerfile ."
  exit 1
fi

# Vérifie que wget ET zip sont présents
if ! docker run --rm monimage-dockerfile which wget &>/dev/null; then
  echo "ERREUR : wget n'est pas installé dans monimage-dockerfile."
  exit 1
fi

if ! docker run --rm monimage-dockerfile which zip &>/dev/null; then
  echo "ERREUR : zip n'est pas encore installé dans monimage-dockerfile."
  echo "Ajoutez l'installation de zip dans le Dockerfile et reconstruisez."
  exit 1
fi

# Vérifie qu'un Dockerfile existe quelque part
DOCKERFILE=$(find /root -name "Dockerfile" 2>/dev/null | head -1)
if [ -z "$DOCKERFILE" ]; then
  echo "ERREUR : aucun Dockerfile trouvé sous /root."
  exit 1
fi

echo "✓ Image monimage-dockerfile avec wget et zip. Dockerfile : $DOCKERFILE"
exit 0
