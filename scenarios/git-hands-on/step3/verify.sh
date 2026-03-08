#!/bin/bash
# Vérifie : au moins 2 commits + README avec description (>= 3 lignes)

REPO="/root/git-practice"

commit_count=$(git -C "$REPO" rev-list --count HEAD 2>/dev/null)
if [ -z "$commit_count" ] || [ "$commit_count" -lt 2 ]; then
  echo "ERREUR : Il faut au moins 2 commits (commit initial + commit de la branche feature)."
  echo "Commits actuels : ${commit_count:-0}"
  exit 1
fi

if [ ! -f "$REPO/README.md" ]; then
  echo "ERREUR : README.md introuvable dans $REPO."
  exit 1
fi

line_count=$(wc -l < "$REPO/README.md")
if [ "$line_count" -lt 3 ]; then
  echo "ERREUR : README.md doit contenir au moins 3 lignes (titre + description)."
  echo "Lignes actuelles : $line_count"
  echo "Ajoutez une description sur la branche feature et mergez-la dans main."
  exit 1
fi

echo "✓ $commit_count commits trouvés"
echo "✓ README.md contient $line_count lignes (titre + description présents)"
exit 0
