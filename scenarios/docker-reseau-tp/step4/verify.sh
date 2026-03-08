#!/bin/bash
# Vérifie que ≥2 conteneurs nginx tournent avec des ports mappés sur l'hôte

NGINX_RUNNING=$(docker ps --format '{{.Image}} {{.Ports}}' \
  | grep '^nginx' | grep -c '0.0.0.0:')

if [ "${NGINX_RUNNING:-0}" -lt 2 ]; then
  echo "ERREUR : seulement $NGINX_RUNNING conteneur(s) nginx avec port mapping actif."
  echo "Lancez au moins 2 nginx : un avec -p 8080:80, un avec -P"
  exit 1
fi

# Vérifier qu'au moins un port répond avec curl
RESPONDED=0
for port in $(docker ps --format '{{.Ports}}' | grep -oP '0\.0\.0\.0:\K[0-9]+(?=->80)'); do
  if curl -s --max-time 3 "http://localhost:$port" | grep -qi "nginx\|html\|Welcome"; then
    RESPONDED=1
    break
  fi
done

if [ "$RESPONDED" -eq 0 ]; then
  echo "ERREUR : aucun port nginx ne répond via curl."
  echo "Vérifiez que les conteneurs nginx sont bien démarrés."
  exit 1
fi

echo "✓ $NGINX_RUNNING conteneur(s) nginx actifs avec port mapping, nginx répond."
exit 0
