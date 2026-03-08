# Étape 1 — Git : concepts & pourquoi

Ces questions portent sur la **valeur** de Git et ses concepts fondamentaux — pas les commandes.

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

> On préfère **merge** sur les branches partagées (pour l'auditabilité) et **rebase** sur les branches locales (pour la lisibilité).

---

Quand vous avez répondu aux 5 questions, cliquez sur **Check**.
