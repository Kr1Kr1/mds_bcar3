#!/bin/bash
if [ ! -f "/tmp/ck_step3.txt" ]; then
  echo "ERREUR : Quiz non complété. Lancez : bash /root/quiz_step3.sh"; exit 1
fi
mapfile -t a < "/tmp/ck_step3.txt"
if [ "${#a[@]}" -ne 8 ]; then
  echo "ERREUR : Quiz incomplet (${#a[@]}/8). Relancez : bash /root/quiz_step3.sh"; exit 1
fi
echo "✓ Quiz complet ! Lancez : bash /root/quiz_results.sh"
exit 0
