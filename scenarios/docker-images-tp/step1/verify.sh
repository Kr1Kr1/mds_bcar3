#!/bin/bash
# Vérifie qu'un conteneur rockylinux existe et a des modifications (diff non vide)
CONTAINER=$(docker ps -a --filter "ancestor=rockylinux/rockylinux" -q | head -1)

if [ -z "$CONTAINER" ]; then
  echo "ERREUR : aucun conteneur basé sur rockylinux/rockylinux trouvé."
  echo "Lancez un conteneur rockylinux et installez wget à l'intérieur."
  exit 1
fi

DIFF=$(docker diff "$CONTAINER" 2>/dev/null)
if [ -z "$DIFF" ]; then
  echo "ERREUR : le conteneur ne présente aucune modification par rapport à l'image de base."
  echo "Avez-vous bien installé un paquet à l'intérieur ?"
  exit 1
fi

echo "✓ Conteneur modifié trouvé ($(echo "$DIFF" | wc -l) fichiers modifiés)."
exit 0
