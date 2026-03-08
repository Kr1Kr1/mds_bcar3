#!/bin/bash
# Vérifie qu'un service nginx tourne via Docker Compose et répond en HTTP

# 1. Trouver un conteneur nginx lancé par Compose
NGINX_CTR=$(docker ps \
  --filter "label=com.docker.compose.service=nginx" \
  --format "{{.ID}}" | head -1)

if [ -z "$NGINX_CTR" ]; then
  echo "ERREUR : aucun service 'nginx' en cours d'exécution via Docker Compose."
  echo "Créez un docker-compose.yml avec un service nginx et lancez : docker compose up -d"
  exit 1
fi

# 2. Trouver le port hôte mappé sur le port 80 du conteneur
HOST_PORT=$(docker port "$NGINX_CTR" 80 2>/dev/null | grep -oP '(?<=:)\d+' | head -1)

if [ -z "$HOST_PORT" ]; then
  echo "ERREUR : le port 80 du service nginx n'est pas mappé sur l'hôte."
  echo "Ajoutez une section 'ports:' dans votre docker-compose.yml."
  exit 1
fi

# 3. Vérifier que nginx répond en HTTP
HTTP_CODE=$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 "http://localhost:$HOST_PORT")

if [ "$HTTP_CODE" != "200" ]; then
  echo "ERREUR : nginx ne répond pas correctement (HTTP $HTTP_CODE) sur le port $HOST_PORT."
  exit 1
fi

echo "✓ Service nginx opérationnel via Compose (port hôte $HOST_PORT, HTTP 200)."
exit 0
