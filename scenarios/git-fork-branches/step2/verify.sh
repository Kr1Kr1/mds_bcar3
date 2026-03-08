#!/bin/bash
REPO="/root/first-day-c"

if [ ! -d "$REPO/.git" ]; then
  echo "ERREUR : dépôt introuvable."
  exit 1
fi

cd "$REPO"

# Une branche autre que main et go doit exister
FEATURE=$(git branch | grep -v "^\*\? *main$" | grep -v "^\*\? *go$" | head -1 | tr -d '* ')
if [ -z "$FEATURE" ]; then
  echo "ERREUR : aucune branche de feature trouvée."
  echo "Créez-en une avec : git checkout -b ma-feature"
  exit 1
fi

# Cette branche doit avoir au moins un commit de plus que main
AHEAD=$(git rev-list main.."$FEATURE" --count 2>/dev/null)
if [ "${AHEAD:-0}" -lt 1 ]; then
  echo "ERREUR : la branche '$FEATURE' n'a pas encore de commit."
  echo "Créez un fichier, git add, puis git commit."
  exit 1
fi

# monfichier.txt doit être tracké
if ! git -C "$REPO" ls-files | grep -q "monfichier.txt"; then
  echo "ERREUR : monfichier.txt n'est pas commité."
  exit 1
fi

echo "✓ Branche '$FEATURE' créée avec $(git rev-list main..\"$FEATURE\" --count) commit(s)."
exit 0
