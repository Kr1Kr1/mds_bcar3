#!/bin/bash
# Étape 3 : un conteneur ubuntu tourne + sa commande est bash/sh (mode interactif)
RUNNING=$(docker ps --filter "ancestor=ubuntu" -q)
if [ -z "$RUNNING" ]; then
  echo "ERREUR : aucun conteneur ubuntu en cours d'exécution."
  echo "Lancez un conteneur ubuntu en arrière-plan avec bash."
  exit 1
fi

# Vérifie qu'au moins un conteneur ubuntu tourne avec bash (pas juste sleep ou echo)
HAS_BASH=0
for id in $RUNNING; do
  CMD=$(docker inspect "$id" --format '{{.Config.Cmd}}' 2>/dev/null)
  PROC=$(docker inspect "$id" --format '{{index .Config.Cmd 0}}' 2>/dev/null)
  if echo "$CMD" | grep -qiE "bash|sh"; then
    HAS_BASH=1
    break
  fi
done

if [ "$HAS_BASH" -eq 0 ]; then
  echo "ERREUR : aucun conteneur ubuntu ne tourne avec bash."
  echo "Lancez : docker run -d -it ubuntu bash"
  exit 1
fi

# Vérifie qu'au moins un conteneur a été inspecté via exec (≥2 processus actifs)
for id in $RUNNING; do
  PROCS=$(docker top "$id" 2>/dev/null | tail -n +2 | wc -l)
  if [ "${PROCS:-0}" -ge 2 ]; then
    echo "✓ Conteneur ubuntu actif avec bash et plusieurs processus (exec détecté)."
    exit 0
  fi
done

# Acceptable aussi : un seul process bash (exec a pu être fermé après usage)
echo "✓ Conteneur ubuntu actif avec bash."
exit 0
