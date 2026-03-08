# Étape 3 — Staging avancé et .gitignore

## 1. Se placer dans le dépôt et sur votre branche

`cd /root/first-day-c`{{exec}}

`git branch`{{exec}}

> Si vous n'êtes pas sur `ma-feature`, faites : `git checkout ma-feature`

---

## 2. Modifier un fichier existant ET créer un nouveau fichier

`echo "Ligne ajoutée" >> monfichier.txt`{{exec}}

`echo "données temporaires" > temp.log`{{exec}}

`git status`{{exec}}

> Vous avez maintenant :
> - `monfichier.txt` : **modifié** (tracked, modified)
> - `temp.log` : **non suivi** (untracked)

---

## 3. Tenter un commit sans `git add`

`git commit -m "maj: modifications"`{{exec}}

> **Q8 :** Que se passe-t-il ?
>
> → Git refuse : les modifications ne sont pas dans le staging.

---

## 4. Utiliser `git commit -am`

`git commit -am "maj: modification de monfichier.txt"`{{exec}}

`git status`{{exec}}

> **Q9 :** Qu'est-ce qui a été commité ? Qu'est-ce qui ne l'a pas été ?
>
> → Le flag `-a` stage automatiquement **les fichiers déjà suivis** (tracked).
> `temp.log` n'est pas suivi → il **n'est pas commité**, il reste untracked.

---

## 5. Ignorer le fichier temporaire avec `.gitignore`

`echo "temp.log" >> .gitignore`{{exec}}

`cat .gitignore`{{exec}}

`git status`{{exec}}

> **Q10 :** `temp.log` apparaît-il encore dans `git status` ?
>
> → Non ! Git l'ignore désormais. Le fichier existe toujours sur le disque, mais Git ne le voit plus.

---

## 6. Commiter le `.gitignore`

`git add .gitignore`{{exec}}

`git commit -m "chore: ajout .gitignore (ignore temp.log)"`{{exec}}

`git status`{{exec}}

`git log --oneline`{{exec}}

---

> **À retenir :**
> - `git commit -am` = `-a` (stage les **tracked** modifiés) + `-m` (message)
> - `-a` **ne touche pas** aux fichiers untracked → utilisez `git add` pour les nouveaux fichiers
> - `.gitignore` : liste les patterns de fichiers que Git doit ignorer

Quand c'est fait, cliquez sur **Check**.
