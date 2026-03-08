# Étape 2 — Premier fichier et premier commit

Vous allez créer un fichier, l'ajouter au staging, puis enregistrer votre premier commit.

## 1. Se positionner dans le dépôt

`cd /root/git-practice`{{exec}}

## 2. Créer un fichier README

`echo "# Mon projet Git" > README.md`{{exec}}

`cat README.md`{{exec}}

## 3. Vérifier l'état du dépôt

`git status`{{exec}}

> Le fichier apparaît en **rouge** : il est *non suivi* (untracked). Git le voit mais ne l'enregistre pas encore.

## 4. Ajouter le fichier au staging

`git add README.md`{{exec}}

`git status`{{exec}}

> Le fichier est maintenant en **vert** : il est dans la *zone de staging* (index). Il sera inclus dans le prochain commit.

## 5. Créer le premier commit

`git commit -m "feat: ajout du README"`{{exec}}

## 6. Consulter l'historique

`git log --oneline`{{exec}}

---

> **Le cycle Git :**
> `Fichier modifié` → `git add` → `Staging Area` → `git commit` → `Historique`

Quand c'est fait, cliquez sur **Check** pour valider.
