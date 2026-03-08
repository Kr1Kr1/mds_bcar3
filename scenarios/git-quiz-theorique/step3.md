# Étape 3 — Git + Docker : vision d'ensemble

Ces questions portent sur l'**articulation** des deux outils dans un contexte professionnel.

## Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Git + Docker : le duo SysOps**

```
Code source  →  git commit  →  git push  →  docker build  →  déploiement
```

- **Git** versionne le code ET l'infrastructure (Dockerfile, docker-compose.yml)
- **Docker** garantit que ce code s'exécute de façon identique partout
- Ensemble, ils forment la base de l'**Infrastructure as Code (IaC)**

**Infrastructure as Code**
> Décrire et gérer l'infrastructure dans des **fichiers texte versionnés**
> → traçabilité, reproductibilité, collaboration

**Registry = le "GitHub des images"**
- Docker Hub, GitLab Registry, Harbor...
- Stocke et distribue les images Docker versionnées

---

Quand vous avez répondu aux 5 questions, cliquez sur **Check**.
