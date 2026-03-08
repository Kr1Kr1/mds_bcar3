# Étape 1 — Git : concepts & pourquoi

Ces questions portent sur la **valeur** de Git, ses concepts fondamentaux et quelques commandes clés.

## Lancer le quiz

`bash /root/quiz_step1.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Pourquoi Git ?**
- Garder l'**historique complet** des modifications
- Permettre la **collaboration** sans écraser le travail des autres
- Pouvoir **revenir en arrière** à n'importe quel état passé

**Concepts clés**

| Concept | Ce que c'est |
|---------|-------------|
| **commit** | Instantané (snapshot) du projet à un instant T |
| **branche** | Ligne de développement isolée du reste |
| **origin** | Alias par défaut du dépôt distant (remote) |
| **merge** | Fusion de deux branches — conserve l'historique |
| **rebase** | Réécrit l'historique pour le rendre linéaire |

**Les 3 zones Git**

| Zone | Description |
|------|-------------|
| **Working tree** | Vos fichiers locaux tels que vous les éditez |
| **Index (staging)** | Ce que `git add` a sélectionné pour le prochain commit |
| **Repository** | L'historique permanent créé par `git commit` |

**Commandes utiles**

| Commande | Effet |
|----------|-------|
| `git add <fichier>` | Déplace les modifications dans la zone de staging |
| `git status` | Montre l'état des fichiers (modifiés, stagés, non suivis) |
| `git stash` | Met de côté les modifications en cours (working tree propre) |
| `git stash pop` | Réapplique les modifications mises de côté |

> On préfère **merge** sur les branches partagées (auditabilité) et **rebase** sur les branches locales (lisibilité).

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
