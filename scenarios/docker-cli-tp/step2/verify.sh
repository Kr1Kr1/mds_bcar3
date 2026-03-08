#!/bin/bash
# Vérifie que l'image ubuntu est présente et qu'au moins un conteneur a été lancé
if ! docker images --format '{{.Repository}}' | grep -q "^ubuntu$"; then
  echo "ERREUR : l'image 'ubuntu' n'est pas présente localement."
  echo "Indice : cherchez comment télécharger une image Docker."
  exit 1
fi

TOTAL=$(docker ps -a -q | wc -l)
if [ "$TOTAL" -lt 1 ]; then
  echo "ERREUR : aucun conteneur trouvé."
  echo "Lancez au moins un conteneur à partir de l'image ubuntu."
  exit 1
fi

echo "✓ Image ubuntu présente, $TOTAL conteneur(s) au total."
exit 0
