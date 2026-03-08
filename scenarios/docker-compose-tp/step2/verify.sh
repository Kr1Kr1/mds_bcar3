#!/bin/bash
# Vérifie qu'une stack Compose tourne avec nginx ET un second service distinct

# 1. Lister les services distincts en cours dans tous les projets Compose
SERVICES=$(docker ps \
  --filter "label=com.docker.compose.service" \
  --format "{{.Label \"com.docker.compose.project\"}}_{{.Label \"com.docker.compose.service\"}}" \
  | sort -u)

SERVICE_COUNT=$(echo "$SERVICES" | grep -c .)

if [ "${SERVICE_COUNT:-0}" -lt 2 ]; then
  echo "ERREUR : seulement $SERVICE_COUNT service(s) Compose en cours, 2 minimum attendus."
  echo "Ajoutez un second service (ex. redis) dans votre docker-compose.yml et relancez."
  exit 1
fi

# 2. Vérifier que le service nginx est présent
NGINX_CTR=$(docker ps \
  --filter "label=com.docker.compose.service=nginx" \
  --format "{{.ID}}" | head -1)

if [ -z "$NGINX_CTR" ]; then
  echo "ERREUR : le service nginx n'est pas trouvé parmi les services Compose."
  exit 1
fi

# 3. Trouver le projet du service nginx
PROJECT=$(docker inspect "$NGINX_CTR" \
  --format '{{index .Config.Labels "com.docker.compose.project"}}')

# 4. Vérifier qu'un réseau Compose existe pour ce projet
NET=$(docker network ls --format '{{.Name}}' | grep "^${PROJECT}_" | head -1)

if [ -z "$NET" ]; then
  echo "ERREUR : aucun réseau Compose trouvé pour le projet '$PROJECT'."
  exit 1
fi

# 5. Compter les conteneurs du projet sur ce réseau
CTR_COUNT=$(docker network inspect "$NET" \
  --format '{{range .Containers}}{{.Name}} {{end}}' 2>/dev/null | wc -w)

if [ "${CTR_COUNT:-0}" -lt 2 ]; then
  echo "ERREUR : seulement $CTR_COUNT conteneur(s) sur le réseau '$NET'."
  echo "Vérifiez que les deux services sont bien dans le même projet Compose."
  exit 1
fi

echo "✓ Stack multi-services OK : $SERVICE_COUNT services sur le réseau '$NET' ($CTR_COUNT conteneurs)."
exit 0
