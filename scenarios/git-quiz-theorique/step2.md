# Étape 2 — Docker : concepts & pourquoi

Ces questions portent sur la **valeur** de Docker, ses concepts fondamentaux et quelques commandes clés.

## Lancer le quiz

`bash /root/quiz_step2.sh`{{exec}}

> Entrez le **numéro** de votre réponse et appuyez sur **Entrée**.

---

## À retenir avant de répondre

**Pourquoi Docker ?**
- Résoudre le syndrome **"ça marche sur ma machine"**
- Garantir un **environnement identique** en dev, test et prod
- Démarrer des services en **secondes** (vs minutes pour une VM)

**Concepts clés**

| Concept | Ce que c'est |
|---------|-------------|
| **Image** | Modèle **immuable** (lecture seule) pour créer des conteneurs |
| **Conteneur** | Instance **en cours d'exécution** d'une image |
| **Volume** | Stockage **persistant** indépendant du cycle de vie du conteneur |
| **Docker Compose** | Orchestration de **plusieurs conteneurs** via un fichier YAML |
| **Registry** | Dépôt centralisé pour **stocker et distribuer** des images |

**VM vs Conteneur**
- VM = OS complet + émulation matérielle → lourd, lent à démarrer
- Conteneur = partage le **noyau Linux de l'hôte** → léger, rapide

**Dockerfile — instructions essentielles**

| Instruction | Rôle |
|-------------|------|
| `FROM ubuntu:22.04` | Image de base (point de départ) |
| `RUN apt-get install -y curl` | Exécute une commande lors du build |
| `COPY ./app /app` | Copie des fichiers dans l'image |
| `EXPOSE 80` | Documente le port écouté (informatif) |
| `CMD ["node", "app.js"]` | Commande lancée au démarrage du conteneur |

**Commandes clés**

| Commande | Effet |
|----------|-------|
| `docker build -t monimage .` | Construit une image depuis le Dockerfile |
| `docker run -p 8080:80 monimage` | Démarre un conteneur (hôte:8080 → conteneur:80) |
| `docker volume create monvol` | Crée un volume persistant |
| `docker rm <id>` | Supprime un conteneur (données non persistées perdues) |

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
