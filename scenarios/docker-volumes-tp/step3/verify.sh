#!/bin/bash
# Vérifie :
#  1. Au moins un conteneur nginx tourne avec un bind mount
#  2. Des logs nginx existent sur l'hôte (access.log non vide)

# 1. Trouver un conteneur nginx en cours d'exécution avec un bind mount
NGINX_WITH_BIND=$(docker ps --format '{{.Names}}' | while read name; do
  IMAGE=$(docker inspect "$name" --format '{{.Config.Image}}' 2>/dev/null)
  if echo "$IMAGE" | grep -qi nginx; then
    BINDS=$(docker inspect "$name" \
      --format '{{range .HostConfig.Binds}}{{.}} {{end}}' 2>/dev/null)
    if [ -n "$BINDS" ]; then
      echo "$name"
    fi
  fi
done | head -1)

if [ -z "$NGINX_WITH_BIND" ]; then
  echo "ERREUR : aucun conteneur nginx en cours d'exécution avec un bind mount."
  echo "Lancez nginx avec -v /chemin/absolu/hote:/chemin/conteneur"
  exit 1
fi

# 2. Chercher un access.log non vide dans les bind mounts de ce conteneur
LOG_OK=0
while IFS= read -r bind; do
  HOST_PATH="${bind%%:*}"
  if [ -f "$HOST_PATH/access.log" ] && [ -s "$HOST_PATH/access.log" ]; then
    LOG_OK=1
    break
  fi
done < <(docker inspect "$NGINX_WITH_BIND" \
  --format '{{range .HostConfig.Binds}}{{println .}}{{end}}' 2>/dev/null)

if [ "$LOG_OK" -eq 0 ]; then
  echo "ERREUR : aucun fichier access.log non vide trouvé dans les bind mounts de nginx."
  echo "Montez /var/log/nginx sur l'hôte et faites au moins un curl vers nginx."
  exit 1
fi

echo "✓ nginx '$NGINX_WITH_BIND' tourne avec bind mount(s) et des logs sont présents sur l'hôte."
exit 0
