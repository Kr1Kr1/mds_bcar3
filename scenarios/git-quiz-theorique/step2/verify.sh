#!/bin/bash
# QCM de positionnement — toujours validé, score affiché à titre indicatif
ANSWER_FILE="/tmp/quiz_step2.txt"

if [ ! -f "$ANSWER_FILE" ]; then
  echo "ERREUR : Quiz non complété."
  echo "Lancez d'abord : bash /root/quiz_step2.sh"
  exit 1
fi

mapfile -t answers < "$ANSWER_FILE"

if [ "${#answers[@]}" -ne 8 ]; then
  echo "ERREUR : Quiz incomplet (${#answers[@]}/8 réponses). Relancez : bash /root/quiz_step2.sh"
  exit 1
fi

echo "✓ Quiz complété — bilan à l'étape finale."
exit 0
