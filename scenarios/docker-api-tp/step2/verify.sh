#!/bin/bash
# Vérifie que alpine:latest a été pullée via l'API

# Chercher alpine dans les images locales (via API ou docker)
if docker image inspect alpine:latest &>/dev/null; then
  echo "✓ Image alpine:latest présente localement."
  exit 0
fi

# Aussi vérifiable via l'API si TCP est up
IMAGES=$(curl -s http://localhost:2375/images/json 2>/dev/null)
if echo "$IMAGES" | grep -q '"alpine"'; then
  echo "✓ Image alpine:latest trouvée via l'API."
  exit 0
fi

echo "ERREUR : alpine:latest n'est pas présente localement."
echo "Pullez-la via : POST /v1.xx/images/create?fromImage=alpine&tag=latest"
exit 1
