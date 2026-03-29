# Étape 1 — Terraform & OpenTofu : concepts & workflow

Ces questions portent sur la **valeur** de Terraform/OpenTofu, ses concepts fondamentaux et son workflow.

## 0. S'identifier d'abord

`bash /root/set_pseudo.sh`{{exec}}

> Entrez votre **prénom et nom** — ils seront envoyés au formateur avec vos résultats.

---

## 1. Lancer le quiz

`bash /root/quiz_step1.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Pourquoi Terraform/OpenTofu ?**
- Provisionner l'infrastructure de façon **déclarative** et **idempotente**
- Maintenir un **état** de ce qui existe réellement
- Collaborer et versionner l'infrastructure comme du code

**Concepts clés**

| Concept | Ce que c'est |
|---------|-------------|
| **Provider** | Plugin qui expose les ressources d'une plateforme (AWS, GCP, Kubernetes...) |
| **Resource** | Objet d'infrastructure que Terraform crée, modifie ou supprime |
| **Data source** | Lecture d'informations existantes sans modifier l'infrastructure |
| **Module** | Groupe réutilisable de ressources avec ses propres variables |
| **State** | Fichier représentant l'état actuel de l'infrastructure gérée |

**Workflow standard**

| Commande | Effet |
|----------|-------|
| `tofu init` | Télécharge les providers, initialise le backend |
| `tofu validate` | Vérifie la syntaxe des fichiers `.tf` |
| `tofu plan` | Calcule les changements **sans les appliquer** |
| `tofu apply` | Applique les changements à l'infrastructure |
| `tofu destroy` | Supprime toutes les ressources gérées |

**OpenTofu vs Terraform**
- Terraform a changé de licence (BSL) en 2023 → la communauté a forké : **OpenTofu**
- OpenTofu reste sous licence **MPL-2.0** (vraiment open source)
- La syntaxe HCL et le workflow sont **identiques**

> On préfère stocker le **state dans un backend distant** (S3 + DynamoDB, GitLab...) pour travailler en équipe sans conflits.

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
