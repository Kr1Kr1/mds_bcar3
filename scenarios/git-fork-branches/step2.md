# Étape 2 — Créer une branche et commiter

## 1. Se placer dans le dépôt

`cd /root/first-day-c`{{exec}}

---

## 2. Créer une nouvelle branche et s'y placer en une seule commande

`git checkout -b ma-feature`{{exec}}

`git branch`{{exec}}

> `git checkout -b <nom>` = créer + se déplacer en une seule commande.

---

## 3. Créer un nouveau fichier

`echo "Mon premier fichier dans ma-feature" > monfichier.txt`{{exec}}

---

## 4. Vérifier l'état du répertoire de travail

`git status`{{exec}}

> **Q5 :** Quel est l'état du fichier `monfichier.txt` ? Pourquoi ?
>
> → Il est **Untracked** : Git le voit mais ne le suit pas encore.

---

## 5. Ajouter le fichier à l'index (staging)

`git add monfichier.txt`{{exec}}

`git status`{{exec}}

> **Q6 :** Quel est maintenant l'état du fichier ?
>
> → Il est **Staged** (dans "Changes to be committed") : il sera inclus dans le prochain commit.

---

## 6. Créer le commit

`git commit -m "feat: ajout monfichier.txt"`{{exec}}

`git status`{{exec}}

> **Q7 :** Que montre `git status` maintenant ?
>
> → "nothing to commit, working tree clean" : le snapshot a été enregistré.

---

## 7. Vérifier l'historique

`git log --oneline`{{exec}}

> Vous voyez votre commit au-dessus de ceux hérités de `main`.

---

> **À retenir :**
> ```
> [fichier modifié]  →  git add  →  [staging]  →  git commit  →  [historique]
>  working tree                      index                         repository
> ```

Quand c'est fait, cliquez sur **Check**.
