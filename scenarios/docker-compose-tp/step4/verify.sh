#!/bin/bash
# Vérifie qu'un volume nommé Compose est utilisé par un service MySQL

# 1. Lister les volumes nommés (exclure les volumes anonymes = hash 64 chars)
NAMED_VOLS=$(docker volume ls --format '{{.Name}}' \
  | grep -vE '^[a-f0-9]{64}$')

if [ -z "$NAMED_VOLS" ]; then
  echo "ERREUR : aucun volume nommé trouvé."
  echo "Ajoutez une section 'volumes:' dans votre docker-compose.yml et nommez votre volume."
  exit 1
fi

# 2. Trouver un conteneur MySQL via Compose (nommé mysql ou db)
MYSQL_CTR=$(docker ps \
  --filter "label=com.docker.compose.service=mysql" \
  --format "{{.ID}}" | head -1)

if [ -z "$MYSQL_CTR" ]; then
  MYSQL_CTR=$(docker ps \
    --filter "label=com.docker.compose.service=db" \
    --format "{{.ID}}" | head -1)
fi

if [ -z "$MYSQL_CTR" ]; then
  echo "ERREUR : aucun service MySQL (nommé 'mysql' ou 'db') en cours via Compose."
  exit 1
fi

# 3. Vérifier que le conteneur MySQL monte un volume nommé (non anonyme)
VOL_USED=$(docker inspect "$MYSQL_CTR" \
  --format '{{range .Mounts}}{{if eq .Type "volume"}}{{.Name}} {{end}}{{end}}' \
  | tr ' ' '\n' \
  | grep -vE '^[a-f0-9]{64}$' \
  | grep -v '^$' \
  | head -1)

if [ -z "$VOL_USED" ]; then
  echo "ERREUR : le service MySQL n'utilise pas de volume nommé."
  echo "Vérifiez que votre docker-compose.yml monte un volume nommé dans /var/lib/mysql."
  exit 1
fi

# 4. Vérifier que le point de montage cible /var/lib/mysql
MOUNT_DEST=$(docker inspect "$MYSQL_CTR" \
  --format '{{range .Mounts}}{{if eq .Name "'"$VOL_USED"'"}}{{.Destination}}{{end}}{{end}}')

if [ "$MOUNT_DEST" != "/var/lib/mysql" ]; then
  echo "ATTENTION : le volume '$VOL_USED' n'est pas monté sur /var/lib/mysql (monté sur : ${MOUNT_DEST:-inconnu})."
  echo "Les données MySQL doivent être dans /var/lib/mysql pour être persistées."
  exit 1
fi

echo "✓ Volume nommé '$VOL_USED' monté sur /var/lib/mysql dans le service MySQL."
echo "  Les données persistent entre docker compose down et up."
exit 0
