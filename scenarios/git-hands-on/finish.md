# Félicitations !

Vous avez complété le scénario Git Hands-On !

## Ce que vous avez pratiqué

- ✓ Initialiser un dépôt Git (`git init`)
- ✓ Configurer son identité (`git config`)
- ✓ Créer des fichiers et les committer (`git add`, `git commit`)
- ✓ Travailler avec des branches (`git branch`, `git checkout`)
- ✓ Fusionner des branches (`git merge`)
- ✓ Provoquer et résoudre un conflit de merge

## Récapitulatif des commandes

```bash
git init                    # Initialiser un dépôt
git config user.name "..."  # Configurer l'identité
git add <fichier>           # Ajouter au staging
git commit -m "message"     # Créer un commit
git branch <nom>            # Créer une branche
git checkout <branche>      # Changer de branche
git checkout -b <nom>       # Créer et basculer d'un coup
git merge <branche>         # Fusionner une branche dans la branche courante
git log --oneline --graph   # Visualiser l'historique
git status                  # État du dépôt
```

## Pour aller plus loin

- `git rebase` — réécrire l'historique pour un historique linéaire
- `git stash` — mettre de côté des modifications temporairement
- `git cherry-pick` — appliquer un commit spécifique sur une branche
- Connecter un remote : `git remote add origin <url>` puis `git push`
