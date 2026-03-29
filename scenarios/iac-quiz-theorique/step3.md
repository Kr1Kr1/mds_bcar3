# Étape 3 — Pulumi, SaltStack & vision d'ensemble IaC

Ces questions portent sur Pulumi, SaltStack et l'**articulation** des outils IaC dans un contexte professionnel.

## Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Pulumi**
- IaC avec de **vrais langages** (Python, TypeScript, Go, Java...)
- Avantage : logique complexe, boucles dynamiques, abstractions — là où HCL montre ses limites
- Maintient un **state** comme Terraform, compatible avec les mêmes providers

**SaltStack**
- Architecture **master / minions** via bus de messages (ZeroMQ)
- **États** (`.sls`) : fichiers YAML/Jinja2 décrivant l'état désiré
- **Event-driven** : le réacteur (reactor) déclenche des actions automatiquement sur événement

**Terraform vs Ansible vs SaltStack : complémentarité**

| Outil | Rôle principal |
|-------|---------------|
| **Terraform / OpenTofu** | Provisionner l'infrastructure (VMs, réseaux, DNS, buckets...) |
| **Ansible** | Configurer les systèmes une fois provisionnés (packages, services, fichiers) |
| **SaltStack** | Configuration continue + réaction aux événements en temps réel |

**IaC : les 4 piliers**

| Pilier | Description |
|--------|-------------|
| **Déclaratif** | On décrit *ce qu'on veut*, pas *comment y arriver* |
| **Idempotent** | Appliquer N fois = même résultat |
| **Versionné** | Tout dans Git → traçabilité, rollback, revue |
| **Reproductible** | Recréer un environnement identique à tout moment |

---

## Afficher votre bilan final

`bash /root/quiz_results.sh`{{exec}}

> Montrez ce bilan à votre formateur.

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
