#!/bin/bash
# Étape 5 : 0 exited + au moins 1 conteneur running (stop/start validé)
EXITED=$(docker ps -a --filter "status=exited" -q | wc -l)
if [ "$EXITED" -gt 0 ]; then
  echo "ERREUR : $EXITED conteneur(s) arrêté(s) encore présents."
  echo "Supprimez tous les conteneurs arrêtés (tous, pas seulement un)."
  exit 1
fi

# Après stop/start, au moins un conteneur doit tourner
RUNNING=$(docker ps -q | wc -l)
if [ "$RUNNING" -lt 1 ]; then
  echo "ERREUR : aucun conteneur en cours d'exécution."
  echo "Relancez (sans recréer) le conteneur que vous avez arrêté, puis nettoyez les exited."
  exit 1
fi

# Vérifie que docker inspect fonctionne et retourne une IP (preuve qu'ils l'ont utilisé)
ID=$(docker ps -q | head -1)
IP=$(docker inspect "$ID" --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 2>/dev/null)
if [ -z "$IP" ]; then
  echo "AVERTISSEMENT : pas d'IP trouvée sur le conteneur (réseau host ?). Vérifiez docker inspect --format."
fi

echo "✓ Nettoyage OK — $RUNNING conteneur(s) actif(s), 0 exited."
exit 0
