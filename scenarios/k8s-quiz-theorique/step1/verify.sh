#!/bin/bash
ANSWER_FILE="/tmp/quiz_step1.txt"

if [ ! -f "/tmp/quiz_pseudo.txt" ] || [ -z "$(cat /tmp/quiz_pseudo.txt 2>/dev/null | xargs)" ]; then
  echo "ERREUR : identification manquante."
  echo "Lancez d'abord : bash /root/set_pseudo.sh"
  exit 1
fi

if [ ! -f "$ANSWER_FILE" ]; then
  echo "ERREUR : Quiz non complété."
  echo "Lancez : bash /root/quiz_step1.sh"
  exit 1
fi

mapfile -t answers < "$ANSWER_FILE"

if [ "${#answers[@]}" -ne 8 ]; then
  echo "ERREUR : Quiz incomplet (${#answers[@]}/8 réponses). Relancez : bash /root/quiz_step1.sh"
  exit 1
fi

PSEUDO=$(cat /tmp/quiz_pseudo.txt | xargs)
echo "✓ Identifié(e) : $PSEUDO — Quiz complété. Bilan à l'étape finale."
exit 0
