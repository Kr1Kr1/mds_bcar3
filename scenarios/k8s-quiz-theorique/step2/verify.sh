#!/bin/bash
ANSWER_FILE="/tmp/quiz_step2.txt"

if [ ! -f "/tmp/quiz_pseudo.txt" ] || [ -z "$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs)" ]; then
  echo "ERREUR : identification manquante."
  echo "Lancez d'abord : bash /root/set_pseudo.sh"
  exit 1
fi

if [ ! -f "$ANSWER_FILE" ]; then
  echo "ERREUR : Quiz non complété."
  echo "Lancez : bash /root/quiz_step2.sh"
  exit 1
fi

mapfile -t answers < "$ANSWER_FILE"

if [ "${#answers[@]}" -ne 8 ]; then
  echo "ERREUR : Quiz incomplet (${#answers[@]}/8 réponses). Relancez : bash /root/quiz_step2.sh"
  exit 1
fi

PSEUDO=$(cat /tmp/quiz_pseudo.txt | xargs)
echo "✓ $PSEUDO — Étape 2 complétée."
exit 0
