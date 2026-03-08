#!/bin/bash
# Vérifie la présence d'un fichier .env et l'utilisation de variables d'env dans Compose

# 1. Chercher un fichier .env dans les répertoires probables
ENV_FILE=$(find /root /home -maxdepth 4 -name ".env" 2>/dev/null | head -1)

if [ -z "$ENV_FILE" ]; then
  echo "ERREUR : aucun fichier .env trouvé."
  echo "Créez un fichier .env dans votre répertoire de projet."
  exit 1
fi

# 2. Vérifier qu'il contient au moins une variable (format KEY=VALUE)
VAR_COUNT=$(grep -cE '^[A-Z_]+=.+' "$ENV_FILE" 2>/dev/null || echo 0)

if [ "$VAR_COUNT" -lt 1 ]; then
  echo "ERREUR : le fichier .env existe mais ne contient aucune variable au format KEY=VALUE."
  exit 1
fi

# 3. Vérifier qu'un service MySQL tourne via Compose
MYSQL_CTR=$(docker ps \
  --filter "label=com.docker.compose.service=mysql" \
  --format "{{.ID}}" | head -1)

# Accepter aussi "db" comme nom de service courant pour mysql
if [ -z "$MYSQL_CTR" ]; then
  MYSQL_CTR=$(docker ps \
    --filter "label=com.docker.compose.service=db" \
    --format "{{.ID}}" | head -1)
fi

if [ -z "$MYSQL_CTR" ]; then
  echo "ERREUR : aucun service MySQL (nommé 'mysql' ou 'db') en cours via Compose."
  echo "Ajoutez mysql:8 à votre stack et assurez-vous qu'il démarre correctement."
  exit 1
fi

# 4. Vérifier que le conteneur MySQL a des variables d'environnement MYSQL_*
MYSQL_VARS=$(docker inspect "$MYSQL_CTR" \
  --format '{{range .Config.Env}}{{.}} {{end}}' | tr ' ' '\n' | grep -c '^MYSQL_' || echo 0)

if [ "${MYSQL_VARS:-0}" -lt 1 ]; then
  echo "ERREUR : le conteneur MySQL ne semble pas avoir de variables MYSQL_* configurées."
  exit 1
fi

echo "✓ Fichier .env présent ($VAR_COUNT variable(s)) — service MySQL opérationnel avec $MYSQL_VARS variable(s) MYSQL_*."
exit 0
