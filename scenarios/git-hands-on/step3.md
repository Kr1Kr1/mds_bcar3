# Étape 3 — Branches et merge

Vous allez créer une branche, y apporter des modifications, puis la fusionner dans `main`.

## 1. Se positionner dans le dépôt

`cd /root/git-practice`{{exec}}

## 2. Vérifier la branche actuelle

`git branch`{{exec}}

## 3. Créer et basculer sur une nouvelle branche

`git checkout -b feature/ajout-contenu`{{exec}}

`git branch`{{exec}}

> Le `*` indique la branche active. Vous êtes maintenant sur `feature/ajout-contenu`.

## 4. Modifier le README sur cette branche

`echo -e "\n## Description\nCe projet illustre les bases de Git." >> README.md`{{exec}}

`cat README.md`{{exec}}

## 5. Committer les modifications sur la branche feature

`git add README.md`{{exec}}

`git commit -m "feat: ajout de la description dans README"`{{exec}}

## 6. Revenir sur main

`git checkout main`{{exec}}

`cat README.md`{{exec}}

> La description n'est plus là ! Elle n'existe que sur la branche `feature/ajout-contenu`.

## 7. Fusionner la branche feature dans main

`git merge feature/ajout-contenu`{{exec}}

`cat README.md`{{exec}}

## 8. Visualiser l'historique

`git log --oneline --graph --all`{{exec}}

---

> **Bonne pratique :** travaillez toujours sur des branches dédiées. Ne mergez dans `main` que du code validé.

Quand c'est fait, cliquez sur **Check** pour valider.
