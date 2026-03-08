#!/bin/bash
REPO="/root/first-day-c"

# Le dépôt a bien été cloné
if [ ! -d "$REPO/.git" ]; then
  echo "ERREUR : le dépôt /root/first-day-c n'existe pas encore."
  echo "Lancez : git clone /root/first-day-c.git /root/first-day-c"
  exit 1
fi

cd "$REPO"

# La branche go existe localement
if ! git branch | grep -q "go"; then
  echo "ERREUR : la branche locale 'go' n'existe pas."
  echo "Lancez : git branch go origin/go"
  exit 1
fi

# On est sur main (ou n'importe quelle branche sauf go — flexible)
echo "✓ Dépôt cloné, branche 'go' créée localement."
exit 0
