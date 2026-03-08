#!/bin/bash
# Vérifie qu'un service Compose a été scalé à au moins 3 instances

# Construire la liste des comptes par projet_service
SERVICE_COUNTS=$(docker ps \
  --filter "label=com.docker.compose.service" \
  --format "{{.Label \"com.docker.compose.project\"}}_{{.Label \"com.docker.compose.service\"}}" \
  | sort | uniq -c | sort -rn)

if [ -z "$SERVICE_COUNTS" ]; then
  echo "ERREUR : aucun service Docker Compose en cours d'exécution."
  exit 1
fi

# Extraire le nombre maximum d'instances pour un même service
MAX_INSTANCES=$(echo "$SERVICE_COUNTS" | awk '{print $1}' | head -1)
MAX_SERVICE=$(echo "$SERVICE_COUNTS" | awk '{print $2}' | head -1)

if [ "${MAX_INSTANCES:-0}" -lt 3 ]; then
  echo "ERREUR : le service le plus scalé a ${MAX_INSTANCES:-0} instance(s), 3 minimum attendus."
  echo "Utilisez : docker compose up -d --scale <service>=3"
  exit 1
fi

echo "✓ Service '$MAX_SERVICE' scalé à $MAX_INSTANCES instances."
exit 0
