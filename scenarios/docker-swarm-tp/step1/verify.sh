#!/bin/bash
# Vérifie que le Swarm est initialisé et actif

SWARM_STATUS=$(docker info --format '{{.Swarm.LocalNodeState}}' 2>/dev/null)

if [ "$SWARM_STATUS" != "active" ]; then
  echo "ERREUR : le Swarm n'est pas initialisé (état : ${SWARM_STATUS:-inconnu})."
  echo "Exécutez : docker swarm init"
  exit 1
fi

NODE_COUNT=$(docker node ls -q 2>/dev/null | wc -l)
NODE_ROLE=$(docker node ls --format '{{.ManagerStatus}}' 2>/dev/null | head -1)

echo "✓ Swarm actif — $NODE_COUNT nœud(s) dans le cluster (manager : $NODE_ROLE)."
exit 0
