#!/bin/bash
# Vérifie que le registry:2 répond sur localhost:5000/v2/

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/v2/ 2>/dev/null)

if [ "$HTTP_CODE" != "200" ]; then
  echo "ERREUR : le registry ne répond pas sur localhost:5000/v2/ (code HTTP : ${HTTP_CODE:-000})."
  echo "Assurez-vous qu'un conteneur registry:2 est lancé et expose le port 5000."
  exit 1
fi

echo "✓ Registry disponible sur localhost:5000/v2/ (HTTP 200)."
exit 0
