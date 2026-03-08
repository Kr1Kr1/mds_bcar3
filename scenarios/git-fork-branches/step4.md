# Étape 4 — Historique, alias et push

## 1. Se placer dans le dépôt

`cd /root/first-day-c`{{exec}}

---

## 2. Afficher l'historique des commits

`git log`{{exec}}

> Vous voyez les commits complets : hash, auteur, date, message.

`git log --oneline`{{exec}}

> Format condensé : un commit par ligne.

---

## 3. Créer un alias `git lg` — graphe coloré

`git config --global alias.lg "log --graph --pretty=format:'%Cgreen%h%Creset -%Creset %s%C(yellow)%d %Cblue(%aN, %cr)%Creset' --abbrev-commit --date=relative"`{{exec}}

---

## 4. Utiliser `git lg`

`git lg`{{exec}}

> **Q11 :** Que voyez-vous ? Comment lire le graphe ?
>
> → Chaque `*` est un commit. Les branches divergent visuellement.
> `(HEAD -> ma-feature)` indique où vous êtes, `(origin/main)` où est le distant.

---

## 5. Vérifier que votre branche n'est pas encore sur le distant

`git branch -a`{{exec}}

> **Q12 :** Voyez-vous `remotes/origin/ma-feature` ? Pourquoi ?
>
> → Non ! Votre branche existe uniquement en local pour l'instant.

---

## 6. Pousser votre branche vers le dépôt distant

`git push origin ma-feature`{{exec}}

---

## 7. Vérifier que la branche est maintenant sur le distant

`git branch -a`{{exec}}

`git lg`{{exec}}

> **Q13 :** Que remarquez-vous de nouveau ?
>
> → `remotes/origin/ma-feature` apparaît ! Votre travail est partagé.
>
> Sur GitHub, cette branche serait visible dans l'interface et vous pourriez
> ouvrir une **Pull Request** pour demander son intégration dans `main`.

---

> **À retenir :**
> - `git log --oneline --graph` ou `git lg` → visualiser l'arbre des commits
> - `git config --global alias.<nom>` → créer des raccourcis Git personnalisés
> - `git push origin <branche>` → publier une branche sur le distant
> - Sans `git push`, votre travail reste **invisible** pour les collaborateurs

Quand c'est fait, cliquez sur **Check**.
