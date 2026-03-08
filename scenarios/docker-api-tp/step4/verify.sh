#!/bin/bash
# Vérifie que le conteneur api-test a été supprimé

EXISTS=$(docker inspect api-test --format '{{.Id}}' 2>/dev/null)

if [ -n "$EXISTS" ]; then
  echo "ERREUR : le conteneur 'api-test' existe encore (${EXISTS:0:12})."
  echo "Supprimez-le via : DELETE /v1.xx/containers/api-test"
  exit 1
fi

echo "✓ Conteneur 'api-test' correctement supprimé."
exit 0
