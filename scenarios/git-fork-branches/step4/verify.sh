#!/bin/bash
REPO="/root/first-day-c"

if [ ! -d "$REPO/.git" ]; then
  echo "ERREUR : dépôt introuvable."
  exit 1
fi

cd "$REPO"

# L'alias git lg doit exister
if ! git config --global alias.lg &>/dev/null; then
  echo "ERREUR : l'alias 'git lg' n'est pas configuré."
  echo "Relancez la commande git config --global alias.lg ..."
  exit 1
fi

# Une branche de feature doit exister sur le remote (dans le bare repo)
FEATURE=$(git branch | grep -v "^\*\? *main$" | grep -v "^\*\? *go$" | head -1 | tr -d '* ')
if [ -z "$FEATURE" ]; then
  echo "ERREUR : aucune branche de feature trouvée."
  exit 1
fi

# Vérifier que la branche est poussée sur origin
if ! git ls-remote origin "$FEATURE" 2>/dev/null | grep -q "$FEATURE"; then
  echo "ERREUR : la branche '$FEATURE' n'est pas encore sur le remote."
  echo "Lancez : git push origin $FEATURE"
  exit 1
fi

echo "✓ Alias git lg configuré, branche '$FEATURE' poussée sur origin."
exit 0
