#!/bin/bash
if [ ! -f "/tmp/bilan_step2.txt" ]; then
  echo "ERREUR : Quiz non complété. Lancez : bash /root/quiz_step2.sh"; exit 1
fi
mapfile -t a < "/tmp/bilan_step2.txt"
if [ "${#a[@]}" -ne 8 ]; then
  echo "ERREUR : Quiz incomplet (${#a[@]}/8). Relancez : bash /root/quiz_step2.sh"; exit 1
fi
echo "✓ $(cat /tmp/quiz_pseudo.txt | xargs) — Étape 2 complétée."
exit 0
