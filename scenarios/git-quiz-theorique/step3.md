# Étape 3 — Bases de Git

Testez vos connaissances sur les commandes fondamentales de Git.

## Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

> Entrez le **numéro** de votre réponse pour chaque question, puis appuyez sur **Entrée**.

---

## Aide-mémoire

| Commande | Description |
|----------|-------------|
| `git init` | Initialiser un nouveau dépôt Git local |
| `git add <fichier>` | Ajouter un fichier à la zone de staging |
| `git add .` | Ajouter tous les fichiers modifiés au staging |
| `git commit -m "msg"` | Créer un commit avec un message |
| `git branch <nom>` | Créer une nouvelle branche |
| `git checkout <branche>` | Basculer vers une branche |
| `git pull` | Récupérer **et intégrer** les modifications distantes |
| `git fetch` | Récupérer les modifications distantes **sans les intégrer** |

**Rappels :**
- `git stage` n'existe pas — c'est `git add`
- `git pull` = `git fetch` + `git merge`
- `git init` crée le répertoire caché `.git`

---

Quand vous avez répondu aux 5 questions, cliquez sur **Check** pour valider.
