#!/bin/bash
# Vérifie que le démon Docker tourne et répond
if ! docker info &>/dev/null; then
  echo "ERREUR : le démon Docker ne répond pas."
  echo "Indice : cherchez comment démarrer un service système."
  exit 1
fi
echo "✓ Docker est installé et le démon tourne."
exit 0
