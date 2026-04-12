# Étape 1 — Cloud Native & orchestration de conteneurs

Ces questions portent sur les **fondements conceptuels** du Cloud Native et de l'orchestration.

## 0. S'identifier d'abord

`bash /root/set_pseudo.sh`{{exec}}

> Entrez votre **prénom et nom** — ils seront envoyés au formateur avec vos résultats.

---

## 1. Lancer le quiz

`bash /root/quiz_step1.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Les 6 principes Cloud Native**

| Principe | Idée clé |
|---|---|
| Conteneurisation | Application + dépendances dans une unité portable |
| Automatisation | CI/CD, GitOps, IaC — zéro action manuelle |
| Déclaratif | Décrire l'état souhaité, pas les étapes |
| Faible couplage | Composants évoluent indépendamment |
| Immutabilité | Remplacer plutôt que modifier |
| Observabilité | Logs, métriques, traces en temps réel |

**Orchestration de conteneurs**

| Outil | Usage |
|---|---|
| Docker Compose | Dev local — pas de HA ni d'auto-scaling |
| Docker Swarm | Déploiements simples — HA basique |
| Kubernetes | Production complexe — standard industrie |
| Nomad | Architectures hybrides (conteneurs + binaires) |

**CNCF**
- Fondée en 2015 — héberge Kubernetes, Prometheus, Helm…
- 3 niveaux : Sandbox → Incubating → **Graduated**
- Standards ouverts : OCI, CNI, CSI, CRI

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
