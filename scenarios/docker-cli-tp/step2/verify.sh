#!/bin/bash
# Étape 2 : image ubuntu présente + au moins 2 conteneurs ubuntu lancés
if ! docker images --format '{{.Repository}}' | grep -q "^ubuntu$"; then
  echo "ERREUR : l'image 'ubuntu' n'est pas présente localement."
  exit 1
fi

UBUNTU_CONTAINERS=$(docker ps -a --filter "ancestor=ubuntu" -q | wc -l)
if [ "$UBUNTU_CONTAINERS" -lt 2 ]; then
  echo "ERREUR : seulement $UBUNTU_CONTAINERS conteneur(s) ubuntu trouvé(s), 2 minimum attendus."
  echo "Lancez plusieurs conteneurs ubuntu (avec des commandes différentes)."
  exit 1
fi

echo "✓ Image ubuntu présente, $UBUNTU_CONTAINERS conteneur(s) ubuntu au total."
exit 0
