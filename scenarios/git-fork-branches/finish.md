# Félicitations !

Vous avez complété le workflow Git collaboratif de bout en bout.

## Ce que vous maîtrisez maintenant

| Compétence | Commande(s) |
|-----------|------------|
| Cloner un dépôt | `git clone <url>` |
| Voir toutes les branches | `git branch -a` |
| Suivre une branche distante | `git branch <nom> origin/<nom>` |
| Créer + basculer sur une branche | `git checkout -b <nom>` |
| Cycle staging → commit | `git add` → `git commit -m` |
| Commiter les fichiers suivis en une passe | `git commit -am` |
| Ignorer des fichiers | `.gitignore` |
| Lire l'historique | `git log --oneline`, `git lg` |
| Créer un alias Git | `git config --global alias.<nom>` |
| Pousser une branche | `git push origin <nom>` |

## La prochaine étape en vrai

Sur GitHub, après `git push`, vous ouvririez une **Pull Request** :
```
git push origin ma-feature
→ GitHub : "Compare & pull request"
→ Revue de code par un collègue
→ Merge dans main
→ Suppression de la branche
```

C'est le cœur du workflow **Feature Branch** utilisé dans toutes les équipes.

---

`git lg`{{exec}}

> Visualisez une dernière fois le graphe complet de vos branches et commits.
