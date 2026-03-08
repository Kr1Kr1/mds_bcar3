#!/bin/bash
# Vérifie que l'API Docker est accessible sur TCP 2375

HTTP_CODE=$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 http://localhost:2375/version 2>/dev/null)

if [ "$HTTP_CODE" != "200" ]; then
  echo "ERREUR : l'API Docker ne répond pas sur http://localhost:2375/version (HTTP $HTTP_CODE)"
  echo "Vérifiez la configuration du daemon et que Docker est redémarré."
  exit 1
fi

API_VERSION=$(curl -s http://localhost:2375/version | grep -o '"ApiVersion":"[^"]*"' | cut -d'"' -f4)
echo "✓ API Docker accessible sur TCP 2375 (ApiVersion: $API_VERSION)"
exit 0
