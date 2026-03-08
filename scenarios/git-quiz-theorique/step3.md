# Étape 3 — Git + Docker : vision d'ensemble

Ces questions portent sur l'**articulation** des deux outils dans un contexte professionnel réel.

## Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Git + Docker : le duo SysOps**

```
Code source  →  git commit  →  git push  →  docker build  →  registry  →  déploiement
```

- **Git** versionne le code ET l'infrastructure (Dockerfile, docker-compose.yml)
- **Docker** garantit que ce code s'exécute de façon identique partout
- Ensemble, ils forment la base de l'**Infrastructure as Code (IaC)**

**Infrastructure as Code**
> Décrire et gérer l'infrastructure dans des **fichiers texte versionnés**
> → traçabilité, reproductibilité, collaboration

**Registry = le "GitHub des images"**
- Docker Hub, GitLab Registry, Harbor...
- Stocke et distribue les images Docker versionnées (comme Git pour le code)

**Optimisations build**

| Mécanisme | Intérêt |
|-----------|---------|
| `.dockerignore` | Exclut des fichiers du contexte envoyé au daemon (`node_modules`, `.git`...) → build plus rapide |
| **Multi-stage build** | Sépare l'environnement de compilation et l'image finale → image plus légère |
| **Cache des layers** | Docker réutilise les couches non modifiées → rebuild incrémental |

**CI/CD : le déclencheur**
> Un `git push` sur `main` (ou une MR approuvée) déclenche automatiquement :
> `test → docker build → push registry → déploiement`

**Compose vs Swarm**

| Outil | Portée |
|-------|--------|
| **Docker Compose** | Orchestration sur **une seule machine** (dev, staging) |
| **Docker Swarm** | Orchestration sur un **cluster** de plusieurs machines (production) |

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
