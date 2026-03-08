#!/bin/bash
# Vérifie que vol1 a bien été supprimé

if docker volume inspect vol1 &>/dev/null; then
  echo "ERREUR : le volume 'vol1' existe encore."
  echo "Arrêtez d'abord tous les conteneurs qui l'utilisent, puis : docker volume rm vol1"
  exit 1
fi

echo "✓ Le volume 'vol1' a été supprimé avec succès."
exit 0
