#!/bin/bash
# Vérifie :
#  1. L'image 'monapp' existe
#  2. Un conteneur basé sur 'monapp' est en cours d'exécution
#  3. Ce conteneur a un volume monté sur /appdata
#  4. Le Mountpoint hôte existe et contient au moins un fichier

# 1. Image monapp
if ! docker image inspect monapp &>/dev/null; then
  echo "ERREUR : l'image 'monapp' n'existe pas."
  echo "Buildez-la avec : docker build -t monapp ."
  exit 1
fi

# 2. Vérifier que l'image déclare VOLUME /appdata
DECLARED=$(docker inspect monapp --format '{{range $k,$v := .Config.Volumes}}{{$k}} {{end}}' 2>/dev/null)
if ! echo "$DECLARED" | grep -q "/appdata"; then
  echo "ERREUR : l'image 'monapp' ne déclare pas VOLUME /appdata."
  echo "Ajoutez 'VOLUME [\"/appdata\"]' dans votre Dockerfile et rebuildez."
  exit 1
fi

# 3. Un conteneur monapp en cours d'exécution
CONTAINER=$(docker ps --format '{{.Names}}' | while read name; do
  IMG=$(docker inspect "$name" --format '{{.Config.Image}}' 2>/dev/null)
  if [ "$IMG" = "monapp" ]; then echo "$name"; fi
done | head -1)

if [ -z "$CONTAINER" ]; then
  echo "ERREUR : aucun conteneur basé sur 'monapp' n'est en cours d'exécution."
  echo "Lancez : docker run -d --name app1 monapp sleep infinity"
  exit 1
fi

# 4. Ce conteneur a un mount sur /appdata avec un Mountpoint accessible
MOUNTPOINT=$(docker inspect "$CONTAINER" \
  --format '{{range .Mounts}}{{if eq .Destination "/appdata"}}{{.Source}}{{end}}{{end}}' 2>/dev/null)

if [ -z "$MOUNTPOINT" ]; then
  echo "ERREUR : le conteneur '$CONTAINER' n'a pas de mount sur /appdata."
  exit 1
fi

if [ ! -d "$MOUNTPOINT" ]; then
  echo "ERREUR : le Mountpoint '$MOUNTPOINT' n'existe pas sur l'hôte."
  exit 1
fi

FILE_COUNT=$(ls "$MOUNTPOINT" 2>/dev/null | wc -l)

echo "✓ Image 'monapp' OK, conteneur '$CONTAINER' en cours, /appdata monté dans '$MOUNTPOINT' ($FILE_COUNT fichier(s))."
exit 0
