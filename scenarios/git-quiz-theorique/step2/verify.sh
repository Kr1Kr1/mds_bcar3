#!/bin/bash
# Vérifie QCM Étape 2 : Docker — concepts & pourquoi
# Réponses correctes : Q1=2 Q2=2 Q3=3 Q4=3 Q5=2
ANSWER_FILE="/tmp/quiz_step2.txt"
CORRECT=(2 2 3 3 2)

if [ ! -f "$ANSWER_FILE" ]; then
  echo "ERREUR : Fichier de réponses introuvable."
  echo "Lancez le quiz : bash /root/quiz_step2.sh"
  exit 1
fi

mapfile -t answers < "$ANSWER_FILE"

if [ "${#answers[@]}" -ne 5 ]; then
  echo "ERREUR : Quiz incomplet (${#answers[@]}/5 réponses enregistrées)."
  echo "Relancez : bash /root/quiz_step2.sh"
  exit 1
fi

score=0
for i in "${!CORRECT[@]}"; do
  [ "${answers[$i]}" = "${CORRECT[$i]}" ] && ((score++))
done

echo "Score : $score/5"
if [ "$score" -ge 3 ]; then
  echo "✓ Étape validée ! ($score/5 bonnes réponses)"
  exit 0
else
  echo "✗ Score insuffisant ($score/5). Minimum requis : 3/5."
  echo "Relancez : bash /root/quiz_step2.sh"
  exit 1
fi
