#!/bin/bash
if [ ! -f "/tmp/quiz_pseudo.txt" ] || [ -z "$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs)" ]; then
  echo "ERREUR : Lancez d'abord : bash /root/set_pseudo.sh"; exit 1
fi
if [ ! -f "/tmp/ck_step1.txt" ]; then
  echo "ERREUR : Quiz non complété. Lancez : bash /root/quiz_step1.sh"; exit 1
fi
mapfile -t a < "/tmp/ck_step1.txt"
if [ "${#a[@]}" -ne 9 ]; then
  echo "ERREUR : Quiz incomplet (${#a[@]}/9). Relancez : bash /root/quiz_step1.sh"; exit 1
fi
echo "✓ $(cat /tmp/quiz_pseudo.txt | xargs) — Étape 1 complétée."
exit 0
