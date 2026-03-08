#!/bin/bash
# Vérifie qu'au moins 3 conteneurs ont été lancés au total (étapes précédentes + cette étape)
TOTAL=$(docker ps -a -q | wc -l)
if [ "$TOTAL" -lt 3 ]; then
  echo "ERREUR : pas assez de conteneurs ($TOTAL/3 minimum)."
  echo "Lancez un conteneur en mode détaché et consultez ses logs."
  exit 1
fi

# Vérifie qu'au moins un conteneur a des logs accessibles
HAS_LOGS=0
for id in $(docker ps -a -q); do
  COUNT=$(docker logs "$id" 2>&1 | wc -l)
  [ "$COUNT" -gt 0 ] && HAS_LOGS=1 && break
done

if [ "$HAS_LOGS" -eq 0 ]; then
  echo "ERREUR : aucun conteneur ne produit de logs."
  echo "Lancez un conteneur avec une commande qui génère de la sortie."
  exit 1
fi

echo "✓ $TOTAL conteneurs au total, logs accessibles."
exit 0
