# Étape 1 — Cloner et explorer les branches

## 1. Initialiser l'environnement

Lancez le script de setup (installation de git + création du dépôt simulé) :

`wget -qO- https://raw.githubusercontent.com/Kr1Kr1/mds_bcar3/main/scenarios/git-fork-branches/setup-git.sh | bash`{{exec}}

> Attendez le message `✓ Environnement prêt !` avant de continuer.

---

## 2. Cloner le dépôt

Sur GitHub, on clonerait l'URL HTTPS de son fork. Ici on clone le chemin local :

`git clone /root/first-day-c.git /root/first-day-c`{{exec}}

`cd /root/first-day-c`{{exec}}

---

## 3. Afficher les branches locales

`git branch`{{exec}}

> **Q1 :** Combien de branches locales voyez-vous ?

---

## 4. Afficher toutes les branches (locales + distantes)

`git branch -a`{{exec}}

> **Q2 :** Que remarquez-vous ? Que représentent les lignes `remotes/origin/...` ?
>
> → Ce sont les branches du dépôt distant telles que Git les connaît en local.
> Elles ne sont pas encore des branches locales sur lesquelles vous pouvez travailler.

---

## 5. Créer une branche locale qui suit la branche distante `go`

`git branch go origin/go`{{exec}}

`git branch -a`{{exec}}

> **Q3 :** Où êtes-vous maintenant ? La branche `go` est-elle devenue locale ?

---

## 6. Se déplacer sur la branche `go`

`git checkout go`{{exec}}

`git branch`{{exec}}

`ls`{{exec}}

> **Q4 :** Quel nouveau fichier est apparu par rapport à `main` ?

---

## 7. Revenir sur `main`

`git checkout main`{{exec}}

`git branch`{{exec}}

---

> **À retenir :**
> - `git branch` → branches locales uniquement
> - `git branch -a` → locales **et** distantes
> - `git branch <nom> origin/<nom>` → crée une branche locale qui **suit** une branche distante
> - `git checkout <branche>` → change de branche active

Quand c'est fait, cliquez sur **Check**.
