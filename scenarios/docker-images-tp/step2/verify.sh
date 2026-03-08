#!/bin/bash
# Vérifie qu'une image nommée monrocky-wget existe
if ! docker images --format '{{.Repository}}' | grep -q "monrocky-wget"; then
  echo "ERREUR : l'image 'monrocky-wget' est introuvable."
  echo "Utilisez docker commit pour créer une image depuis le conteneur modifié."
  exit 1
fi

# Vérifie que wget est présent dans cette image
if ! docker run --rm monrocky-wget which wget &>/dev/null; then
  echo "ERREUR : wget n'est pas disponible dans l'image monrocky-wget."
  exit 1
fi

echo "✓ Image monrocky-wget présente et wget fonctionnel."
exit 0
