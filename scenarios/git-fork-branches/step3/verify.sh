#!/bin/bash
REPO="/root/first-day-c"

if [ ! -d "$REPO/.git" ]; then
  echo "ERREUR : dépôt introuvable."
  exit 1
fi

cd "$REPO"

# .gitignore doit exister et contenir au moins une entrée
if [ ! -f ".gitignore" ]; then
  echo "ERREUR : .gitignore n'existe pas."
  echo "Créez-le : echo 'temp.log' >> .gitignore && git add .gitignore && git commit -m '...'"
  exit 1
fi

if ! git ls-files | grep -q "^\.gitignore$"; then
  echo "ERREUR : .gitignore n'est pas commité."
  echo "Lancez : git add .gitignore && git commit -m 'chore: ajout .gitignore'"
  exit 1
fi

# temp.log ne doit pas apparaître dans git status (ignoré ou absent)
if git status --short | grep -q "temp.log"; then
  echo "ERREUR : temp.log apparaît encore dans git status."
  echo "Ajoutez 'temp.log' dans .gitignore puis commitez."
  exit 1
fi

# La branche de feature doit avoir au moins 3 commits (feat + maj + chore)
FEATURE=$(git branch | grep -v "^\*\? *main$" | grep -v "^\*\? *go$" | head -1 | tr -d '* ')
AHEAD=$(git rev-list main.."${FEATURE:-ma-feature}" --count 2>/dev/null)
if [ "${AHEAD:-0}" -lt 3 ]; then
  echo "ERREUR : il manque des commits (${AHEAD}/3 minimum)."
  exit 1
fi

echo "✓ .gitignore en place, temp.log ignoré, ${AHEAD} commits sur la branche."
exit 0
