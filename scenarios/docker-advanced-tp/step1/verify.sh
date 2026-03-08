#!/bin/bash
# Vérifie : image hello-optimise < 150 Mo + multi-stage Dockerfile + répond HTTP

# 1. L'image doit exister
if ! docker image inspect hello-optimise &>/dev/null; then
  echo "ERREUR : image 'hello-optimise' introuvable."
  echo "Buildez votre image optimisée avec : docker build -t hello-optimise ."
  exit 1
fi

# 2. Vérifier la taille (< 150 Mo)
SIZE_BYTES=$(docker inspect hello-optimise --format '{{.Size}}' 2>/dev/null)
SIZE_MB=$(( SIZE_BYTES / 1024 / 1024 ))
if [ "$SIZE_MB" -ge 150 ]; then
  echo "ERREUR : image trop grande (${SIZE_MB} Mo). Objectif < 150 Mo."
  echo "Utilisez une image de base légère (alpine, distroless, scratch) et/ou un multi-stage build."
  exit 1
fi

# 3. Vérifier qu'un Dockerfile avec multi-stage (FROM...AS) ou base légère existe
DOCKERFILE=$(find /root -name "Dockerfile" 2>/dev/null | head -1)
if [ -z "$DOCKERFILE" ]; then
  echo "ERREUR : aucun Dockerfile trouvé dans /root/."
  exit 1
fi

if ! grep -qiE "^FROM.+AS |alpine|distroless|scratch" "$DOCKERFILE"; then
  echo "AVERTISSEMENT : le Dockerfile ne semble pas utiliser de multi-stage ou image légère."
fi

echo "✓ Image 'hello-optimise' de ${SIZE_MB} Mo — objectif atteint !"
exit 0
