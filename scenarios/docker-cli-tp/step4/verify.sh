#!/bin/bash
# Étape 4 : un conteneur tourne EN CE MOMENT en mode détaché + a des logs

# Il doit y avoir au moins 1 conteneur en cours d'exécution (détaché = toujours vivant)
RUNNING=$(docker ps -q | wc -l)
if [ "$RUNNING" -lt 1 ]; then
  echo "ERREUR : aucun conteneur en cours d'exécution."
  echo "Lancez un conteneur en mode détaché (-d) avec une commande qui produit des logs."
  exit 1
fi

# Ce conteneur doit avoir des logs (preuve qu'une commande tourne et produit de la sortie)
HAS_LOGS=0
for id in $(docker ps -q); do
  COUNT=$(docker logs "$id" 2>&1 | wc -l)
  if [ "${COUNT:-0}" -ge 1 ]; then
    HAS_LOGS=1
    LOGCOUNT=$COUNT
    break
  fi
done

if [ "$HAS_LOGS" -eq 0 ]; then
  echo "ERREUR : aucun conteneur en cours d'exécution ne produit de logs."
  echo "Lancez un conteneur détaché avec une commande qui génère de la sortie (ping, echo en boucle...)."
  exit 1
fi

echo "✓ $RUNNING conteneur(s) actif(s), logs disponibles ($LOGCOUNT ligne(s))."
exit 0
