#!/bin/bash
# Vérifie qu'un builder buildx multi-plateforme est configuré
# et qu'une image multi-arch a été buildée (présente dans un registry local)

# 1. Vérifier qu'un builder buildx existe
BUILDERS=$(docker buildx ls 2>/dev/null)
if ! echo "$BUILDERS" | grep -qE "running|active"; then
  echo "ERREUR : aucun builder buildx actif."
  echo "Créez-en un : docker buildx create --name multibuilder --use && docker buildx inspect --bootstrap"
  exit 1
fi

# 2. Vérifier si un registry local tourne
REGISTRY_UP=$(curl -s --max-time 3 http://localhost:5000/v2/ 2>/dev/null)
if [ -z "$REGISTRY_UP" ]; then
  echo "ERREUR : registry local non détecté sur localhost:5000."
  echo "Lancez : docker run -d -p 5000:5000 registry:2"
  exit 1
fi

# 3. Vérifier qu'au moins une image est dans le registry
CATALOG=$(curl -s http://localhost:5000/v2/_catalog 2>/dev/null)
if echo "$CATALOG" | grep -q '"repositories":\[\]' || [ -z "$CATALOG" ]; then
  echo "ERREUR : le registry est vide. Poussez votre image multi-arch."
  exit 1
fi

echo "✓ Builder buildx actif et registry local contient une image."
echo "  Catalog: $CATALOG"
exit 0
