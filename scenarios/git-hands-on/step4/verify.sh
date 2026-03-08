#!/bin/bash
# Vérifie : commit de merge présent + aucun marqueur de conflit + >= 4 commits

REPO="/root/git-practice"

commit_count=$(git -C "$REPO" rev-list --count HEAD 2>/dev/null)
if [ -z "$commit_count" ] || [ "$commit_count" -lt 4 ]; then
  echo "ERREUR : Il faut au moins 4 commits (dont le commit de résolution de conflit)."
  echo "Commits actuels : ${commit_count:-0}"
  exit 1
fi

if grep -rn "^<<<<<<\|^=======\|^>>>>>>>" "$REPO" \
     --include="*.md" --include="*.txt" --include="*.sh" \
     --exclude-dir=".git" 2>/dev/null | grep -q .; then
  echo "ERREUR : Des marqueurs de conflit sont encore présents dans les fichiers."
  echo "Résolvez le conflit, puis : git add <fichier> && git commit -m \"merge: résolution\""
  exit 1
fi

merge_commit=$(git -C "$REPO" log --merges --oneline 2>/dev/null | head -1)
if [ -z "$merge_commit" ]; then
  echo "ERREUR : Aucun commit de merge trouvé."
  echo "Effectuez : git merge conflit-branch, résolvez le conflit, puis committez."
  exit 1
fi

echo "✓ $commit_count commits au total"
echo "✓ Aucun marqueur de conflit dans les fichiers"
echo "✓ Commit de merge présent : $merge_commit"
exit 0
