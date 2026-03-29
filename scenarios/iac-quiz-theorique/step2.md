# Étape 2 — Ansible : automatisation de configuration

Ces questions portent sur la **valeur** d'Ansible, son architecture et ses concepts fondamentaux.

## Lancer le quiz

`bash /root/quiz_step2.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Pourquoi Ansible ?**
- Automatiser la **configuration** des systèmes de façon reproductible
- Architecture **agentless** : pas de logiciel à installer sur les cibles (SSH suffit)
- Playbooks lisibles par tous, même sans formation dev

**Concepts clés**

| Concept | Ce que c'est |
|---------|-------------|
| **Inventaire** | Fichier listant les hôtes et groupes à gérer |
| **Playbook** | Fichier YAML décrivant une suite de tâches à exécuter |
| **Tâche (task)** | Appel à un module sur un ou plusieurs hôtes |
| **Module** | Unité fonctionnelle d'Ansible (copy, apt, service, template...) |
| **Handler** | Tâche déclenchée uniquement si une autre tâche a changé quelque chose (`notify`) |
| **Rôle** | Unité réutilisable et partageable (tâches + variables + templates + handlers) |

**Idempotence**
> Exécuter un playbook **plusieurs fois** donne le **même résultat final** sans créer d'effets indésirables — Ansible vérifie l'état avant d'agir.

**Commande ad-hoc vs playbook**

| | Commande ad-hoc | Playbook |
|---|---|---|
| Usage | Tâche ponctuelle | Workflow complet |
| Syntaxe | `ansible all -m ping` | Fichier `.yml` |
| Réutilisabilité | Faible | Forte |

**Ansible Vault**
> Chiffre les données sensibles (mots de passe, clés API) dans les fichiers de variables → secrets versionnés en toute sécurité.

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
