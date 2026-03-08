#!/bin/bash
# Vérifie : au moins 1 commit + README.md suivi par Git

REPO="/root/git-practice"

commit_count=$(git -C "$REPO" rev-list --count HEAD 2>/dev/null)
if [ -z "$commit_count" ] || [ "$commit_count" -lt 1 ]; then
  echo "ERREUR : Aucun commit trouvé dans $REPO."
  echo "Créez un fichier, puis : git add README.md && git commit -m \"message\""
  exit 1
fi

if ! git -C "$REPO" ls-files --error-unmatch README.md &>/dev/null; then
  echo "ERREUR : README.md n'est pas suivi par Git."
  echo "Lancez : git add README.md && git commit -m \"message\""
  exit 1
fi

echo "✓ $commit_count commit(s) trouvé(s)"
echo "✓ README.md est suivi par Git"
exit 0
