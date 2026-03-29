#!/bin/bash
ANSWER_FILE="/tmp/quiz_step2.txt"

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

PSEUDO=$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs)
echo "✓ Identifié(e) : $PSEUDO — Quiz étape 2 complété. Bilan à l'étape finale."
exit 0
