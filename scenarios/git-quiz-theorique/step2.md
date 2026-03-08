# Étape 2 — Docker : concepts & pourquoi

Ces questions portent sur la **valeur** de Docker et ses concepts fondamentaux — pas les commandes.

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

---

Quand vous avez répondu aux 5 questions, cliquez sur **Check**.
