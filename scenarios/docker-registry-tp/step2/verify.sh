#!/bin/bash
# Vérifie qu'au moins une image a été poussée dans le registry

CATALOG=$(curl -s http://localhost:5000/v2/_catalog 2>/dev/null)

if [ -z "$CATALOG" ]; then
  echo "ERREUR : impossible de joindre le registry sur localhost:5000."
  echo "Assurez-vous que le conteneur registry:2 tourne toujours."
  exit 1
fi

# Vérifie que repositories n'est pas vide
if echo "$CATALOG" | grep -q '"repositories":\[\]'; then
  echo "ERREUR : le registry est vide — aucune image poussée."
  echo "Taguez une image avec 'localhost:5000/<nom>:<tag>' puis faites un 'docker push'."
  exit 1
fi

REPOS=$(echo "$CATALOG" | grep -o '"[^"]*"' | grep -v repositories | tr -d '"' | tr '\n' ' ')
echo "✓ Registry non vide. Images présentes : ${REPOS}"
exit 0
