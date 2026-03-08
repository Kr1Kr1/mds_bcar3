#!/bin/bash
# Vérifie les réponses du QCM Étape 1 : Linux & Réseau
# Réponses correctes : Q1=2 Q2=3 Q3=3 Q4=4 Q5=4

ANSWER_FILE="/tmp/quiz_step1.txt"
CORRECT=(2 3 3 4 4)

if [ ! -f "$ANSWER_FILE" ]; then
  echo "ERREUR : Fichier de réponses introuvable."
  echo "Lancez le quiz : bash /root/quiz_step1.sh"
  exit 1
fi

mapfile -t answers < "$ANSWER_FILE"

if [ "${#answers[@]}" -ne 5 ]; then
  echo "ERREUR : Quiz incomplet (${#answers[@]}/5 réponses enregistrées)."
  echo "Relancez le quiz : bash /root/quiz_step1.sh"
  exit 1
fi

score=0
for i in "${!CORRECT[@]}"; do
  if [ "${answers[$i]}" = "${CORRECT[$i]}" ]; then
    ((score++))
  fi
done

echo "Score : $score/5"

if [ "$score" -ge 3 ]; then
  echo "✓ Étape validée ! ($score/5 bonnes réponses)"
  exit 0
else
  echo "✗ Score insuffisant ($score/5). Minimum requis : 3/5."
  echo "Relancez le quiz : bash /root/quiz_step1.sh"
  exit 1
fi
