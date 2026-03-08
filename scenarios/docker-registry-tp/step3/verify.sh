#!/bin/bash
# Vérifie qu'une image localhost:5000/... est présente localement (après pull)

LOCAL_IMAGE=$(docker images --format "{{.Repository}}:{{.Tag}}" 2>/dev/null \
  | grep "^localhost:5000/" | head -1)

if [ -z "$LOCAL_IMAGE" ]; then
  echo "ERREUR : aucune image avec le préfixe 'localhost:5000/' trouvée localement."
  echo "Faites un 'docker pull localhost:5000/<nom>:<tag>' depuis votre registry."
  exit 1
fi

# Vérifie également que le registry répond toujours
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/v2/ 2>/dev/null)
if [ "$HTTP_CODE" != "200" ]; then
  echo "ERREUR : le registry ne répond plus (code HTTP : ${HTTP_CODE:-000})."
  exit 1
fi

echo "✓ Image '${LOCAL_IMAGE}' tirée depuis le registry privé."
exit 0
