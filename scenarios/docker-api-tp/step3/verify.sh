#!/bin/bash
# Vérifie que le conteneur api-test est en cours d'exécution

STATUS=$(docker inspect api-test --format '{{.State.Running}}' 2>/dev/null)

if [ "$STATUS" = "true" ]; then
  echo "✓ Conteneur 'api-test' en cours d'exécution."
  exit 0
fi

# Peut aussi exister mais être arrêté
EXISTS=$(docker inspect api-test --format '{{.State.Status}}' 2>/dev/null)
if [ -n "$EXISTS" ]; then
  echo "ERREUR : le conteneur 'api-test' existe mais n'est pas démarré (état: $EXISTS)."
  echo "Démarrez-le via : POST /v1.xx/containers/api-test/start"
  exit 1
fi

echo "ERREUR : conteneur 'api-test' introuvable."
echo "Créez-le via : POST /v1.xx/containers/create?name=api-test"
exit 1
