#!/bin/bash
# Vérifie que le Dockerfile installe wget et zip dans une seule instruction RUN
DOCKERFILE=$(find /root -name "Dockerfile" 2>/dev/null | head -1)

if [ -z "$DOCKERFILE" ]; then
  echo "ERREUR : aucun Dockerfile trouvé."
  exit 1
fi

# Compte le nombre de lignes RUN qui contiennent wget ou zip
RUN_WGET=$(grep -c "RUN.*wget" "$DOCKERFILE" 2>/dev/null || true)
RUN_ZIP=$(grep -c "RUN.*zip" "$DOCKERFILE" 2>/dev/null || true)

# Les deux doivent être dans le même RUN → un seul RUN contient les deux
COMBINED=$(grep -c "RUN.*wget.*zip\|RUN.*zip.*wget" "$DOCKERFILE" 2>/dev/null || true)

if [ "${COMBINED:-0}" -lt 1 ]; then
  echo "ERREUR : wget et zip ne sont pas installés dans la même instruction RUN."
  echo "Fusionnez les deux installations en une seule commande RUN."
  exit 1
fi

# Vérifie que l'image a bien été reconstruite avec cette config
if ! docker run --rm monimage-dockerfile which zip &>/dev/null || \
   ! docker run --rm monimage-dockerfile which wget &>/dev/null; then
  echo "ERREUR : l'image n'est pas à jour. Reconstruisez avec docker build."
  exit 1
fi

LAYERS=$(docker history monimage-dockerfile --no-trunc --format '{{.CreatedBy}}' | grep -c "RUN" || true)
echo "✓ wget + zip dans un seul RUN — image reconstruite ($LAYERS layer(s) RUN)."
exit 0
