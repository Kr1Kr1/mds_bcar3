# Étape 4 — Conflit et résolution

Vous allez provoquer un conflit de merge entre deux branches et le résoudre manuellement.

## 1. Se positionner dans le dépôt

`cd /root/git-practice`{{exec}}

## 2. Créer une branche pour le conflit

`git checkout -b conflit-branch`{{exec}}

## 3. Modifier la première ligne du README sur cette branche

`sed -i '1s/.*/# Mon Super Projet Git (branche conflit)/' README.md`{{exec}}

`git add README.md && git commit -m "fix: titre modifié dans conflit-branch"`{{exec}}

## 4. Revenir sur main et modifier le même endroit

`git checkout main`{{exec}}

`sed -i '1s/.*/# Mon Projet Git Officiel (main)/' README.md`{{exec}}

`git add README.md && git commit -m "fix: titre modifié dans main"`{{exec}}

## 5. Tenter le merge — conflit garanti !

`git merge conflit-branch`{{exec}}

> Git détecte que les deux branches ont modifié la même ligne. Il ne peut pas choisir automatiquement.

## 6. Examiner les marqueurs de conflit

`cat README.md`{{exec}}

Vous verrez des marqueurs de ce type :
```
<<<<<<< HEAD
# Mon Projet Git Officiel (main)
=======
# Mon Super Projet Git (branche conflit)
>>>>>>> conflit-branch
```

## 7. Résoudre le conflit

Remplacez tout le contenu conflictuel par la version définitive :

`cat > README.md << 'EOF'
# Mon Projet Git - Version Finale

## Description
Ce projet illustre les bases de Git.
EOF`{{exec}}

`cat README.md`{{exec}}

## 8. Finaliser la résolution

`git add README.md`{{exec}}

`git commit -m "merge: résolution du conflit sur le titre"`{{exec}}

## 9. Visualiser l'historique complet

`git log --oneline --graph --all`{{exec}}

---

> **Résoudre un conflit :** repérez les marqueurs `<<<<<<<`, `=======`, `>>>>>>>`, gardez la version souhaitée, supprimez les marqueurs, puis `git add` + `git commit`.

Quand c'est fait, cliquez sur **Check** pour valider.
