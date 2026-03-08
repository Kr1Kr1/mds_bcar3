#!/bin/bash
# Vérifie que :
#  1. vol1 existe
#  2. vol1 contient au moins 2 fichiers (un par conteneur)
#  3. au moins 2 conteneurs ont vol1 monté simultanément (ou l'ont eu)

# 1. vol1 doit exister
if ! docker volume inspect vol1 &>/dev/null; then
  echo "ERREUR : le volume 'vol1' n'existe pas."
  echo "Créez-le avec : docker volume create vol1"
  exit 1
fi

# 2. vol1 doit contenir au moins 2 fichiers
FILE_COUNT=$(docker run --rm -v vol1:/data ubuntu:latest \
  sh -c 'ls /data 2>/dev/null | wc -l' 2>/dev/null)

if [ "${FILE_COUNT:-0}" -lt 2 ]; then
  echo "ERREUR : vol1 contient seulement $FILE_COUNT fichier(s), 2 minimum attendus."
  echo "Lancez deux conteneurs sur vol1 et créez un fichier dans /data depuis chacun."
  exit 1
fi

# 3. Au moins 2 conteneurs (en cours ou arrêtés) ont eu vol1 monté
CONTAINERS_WITH_VOL=$(docker ps -a --format '{{.Names}}' | while read name; do
  docker inspect "$name" --format '{{range .Mounts}}{{.Name}} {{end}}' 2>/dev/null
done | grep -w vol1 | wc -l)

if [ "${CONTAINERS_WITH_VOL:-0}" -lt 2 ]; then
  echo "ERREUR : seulement $CONTAINERS_WITH_VOL conteneur(s) ont utilisé vol1, 2 minimum attendus."
  echo "Lancez au moins 2 conteneurs différents en montant vol1."
  exit 1
fi

echo "✓ vol1 existe, contient $FILE_COUNT fichier(s), utilisé par $CONTAINERS_WITH_VOL conteneur(s)."
exit 0
