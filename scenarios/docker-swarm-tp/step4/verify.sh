#!/bin/bash
# Vérifie que le nœud est de retour en disponibilité "Active" après le cycle drain/active

NODE_AVAIL=$(docker node ls --format '{{.Availability}}' 2>/dev/null | head -1)

if [ "$NODE_AVAIL" != "Active" ]; then
  echo "ERREUR : le nœud n'est pas en disponibilité Active (état actuel : ${NODE_AVAIL:-inconnu})."
  echo "Remettez-le en ligne avec : docker node update --availability active <nom_du_noeud>"
  exit 1
fi

# Le Swarm doit toujours être actif
SWARM_STATUS=$(docker info --format '{{.Swarm.LocalNodeState}}' 2>/dev/null)
if [ "$SWARM_STATUS" != "active" ]; then
  echo "ERREUR : le Swarm n'est plus actif."
  exit 1
fi

echo "✓ Nœud de retour en disponibilité Active — le Swarm fonctionne normalement."
exit 0
