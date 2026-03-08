# Correction — Docker Swarm TP

---

## Étape 1 — Initialiser le Swarm

```bash
# 1. Initialiser le Swarm (la machine devient manager)
docker swarm init

# Sortie attendue (exemple) :
# Swarm initialized: current node (abc123) is now a manager.
# To add a worker to this swarm, run the following command:
#   docker swarm join --token SWMTKN-1-... 172.17.0.2:2377

# 2. Vérifier l'état du Swarm
docker info | grep -A5 Swarm
# Swarm: active
# NodeID: abc123...
# Is Manager: true
# ...

# 3. Lister les nœuds
docker node ls
# ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS
# abc123... *   ubuntu     Ready     Active         Leader
```

> **Récupérer le token join à tout moment :**
> ```bash
> docker swarm join-token worker   # token pour ajouter un worker
> docker swarm join-token manager  # token pour ajouter un manager
> ```

> **Promouvoir un worker en manager :**
> ```bash
> docker node promote <nom_ou_id_nœud>
> ```
> Un manager **Leader** est l'élu Raft qui prend les décisions ; les autres managers
> sont des **Reachable** qui peuvent prendre le relais si le Leader tombe.

---

## Étape 2 — Services replicated et global

### Service web (replicated)

```bash
# 1. Créer un service replicated avec 2 replicas
docker service create \
  --name web \
  --replicas 2 \
  --publish 80:80 \
  httpd

# 2. Vérifier les tâches
docker service ls
# NAME   MODE         REPLICAS   IMAGE
# web    replicated   2/2        httpd:latest

docker service ps web
# ID       NAME    IMAGE          NODE     DESIRED STATE   CURRENT STATE
# xxx      web.1   httpd:latest   ubuntu   Running         Running 10s ago
# yyy      web.2   httpd:latest   ubuntu   Running         Running 10s ago

# 3. Scaler à 4 replicas
docker service scale web=4

# Vérifier
docker service ps web
# → 4 tâches Running (sur 1 nœud toutes sur la même machine)
```

### Service debug (global)

```bash
# 4. Créer un service global basé sur alpine
docker service create \
  --name debug \
  --mode global \
  alpine \
  sleep infinity

# Vérifier : sur 1 nœud, 1 seule tâche (c'est normal pour un mode global)
docker service ps debug
# ID       NAME            IMAGE          NODE     DESIRED STATE   CURRENT STATE
# zzz      debug.abc123    alpine:latest  ubuntu   Running         Running 5s ago
```

> **Replicated vs Global :**
> - `replicated` : N tâches réparties sur les nœuds disponibles (scheduler choisit)
> - `global` : exactement 1 tâche par nœud — utile pour les agents de monitoring, log shippers, etc.

> **Inspecter et suivre un service :**
> ```bash
> docker service inspect web --pretty
> docker service ps web
> docker service logs web
> docker service logs -f web   # suivi en temps réel
> ```

---

## Étape 3 — Service Visualizer

```bash
docker service create \
  --name viz \
  --publish 8080:8080 \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --constraint node.role==manager \
  dockersamples/visualizer

# Attendre que la tâche soit Running
docker service ps viz
# → viz.1   Running   Running 15s ago

# Tester (sur Killercoda : bouton Traffic / Port → 8080)
curl http://localhost:8080
```

> **Pourquoi monter `/var/run/docker.sock` ?**
> Le visualizer interroge l'API Docker pour récupérer la topologie du cluster.
> Sans ce socket, il ne peut pas lister les nœuds ni les services.

> **Pourquoi `--constraint node.role==manager` ?**
> Le visualizer doit accéder à l'API Swarm, disponible uniquement sur les managers.
> Sans cette contrainte, il pourrait atterrir sur un worker qui n'a pas accès
> à l'état complet du cluster.

---

## Étape 4 — Simulation de maintenance (drain / active)

```bash
# 1. Récupérer le nom du nœud
docker node ls
# → ubuntu (ou le hostname de la machine)

NODE=$(docker node ls --format '{{.Hostname}}')

# 2. Drainer le nœud
docker node update --availability drain "$NODE"

# 3. Observer : les tâches passent en Pending (aucun autre nœud disponible)
docker service ps web
# → tâches en Pending / Shutdown (elles tentent de se relocaliser mais ne peuvent pas)

docker node ls
# AVAILABILITY : Drain

# 4. Remettre en Active
docker node update --availability active "$NODE"

# 5. Observer le retour des services
docker service ps web
# → nouvelles tâches Running après quelques secondes

docker node ls
# AVAILABILITY : Active
```

> **`active` vs `pause` vs `drain` :**
> | Mode | Nouvelles tâches | Tâches existantes |
> |------|-----------------|-------------------|
> | `active` | Oui | Conservées |
> | `pause` | Non | Conservées |
> | `drain` | Non | Déplacées ailleurs |
>
> `pause` est utile pour stopper temporairement le scheduling sans vider le nœud.
> `drain` est la méthode propre pour une maintenance (reboot, upgrade).

---

## Étape 5 — Stack multi-services avec docker stack deploy

### Fichier `stack.yml`

```yaml
version: "3.8"

services:
  debug:
    image: alpine
    command: sleep infinity
    deploy:
      mode: global

  appweb:
    image: httpd
    ports:
      - "8081:80"
    deploy:
      mode: replicated
      replicas: 4
```

### Déploiement

```bash
# Déployer la stack
docker stack deploy -c stack.yml monapp

# Vérifier la stack
docker stack ls
# NAME     SERVICES
# monapp   2

# Lister les services de la stack
docker stack services monapp
# NAME            MODE         REPLICAS   IMAGE
# monapp_appweb   replicated   4/4        httpd:latest
# monapp_debug    global       1/1        alpine:latest

# Lister toutes les tâches
docker stack ps monapp

# Tester appweb
curl http://localhost:8081
```

> **`docker stack deploy` vs `docker compose up` :**
> | | `docker compose up` | `docker stack deploy` |
> |---|---|---|
> | Contexte | Local, dev | Swarm, prod |
> | Multi-nœuds | Non | Oui |
> | Rolling updates | Non | Oui |
> | Clé `deploy:` | Ignorée | Prise en compte |
> | `build:` | Supporté | Non supporté |
> | Restart auto | Via `restart:` | Via Swarm scheduler |

> **Nommer les services dans une stack :** Docker Swarm préfixe automatiquement
> le nom de la stack — `monapp_appweb`, `monapp_debug`. À prendre en compte
> avec `docker service inspect`, `docker service logs`, etc.

### Nettoyage

```bash
# Supprimer la stack (arrête et supprime tous ses services)
docker stack rm monapp

# Supprimer les services standalone
docker service rm web debug viz

# Quitter le swarm (optionnel)
docker swarm leave --force
```

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker swarm init` | Initialiser le Swarm (nœud devient manager) |
| `docker swarm join --token <t> <ip>:2377` | Rejoindre un Swarm existant |
| `docker swarm join-token worker\|manager` | Afficher le token de jonction |
| `docker node ls` | Lister les nœuds du cluster |
| `docker node update --availability drain\|active\|pause <n>` | Changer la disponibilité |
| `docker node promote <n>` | Promouvoir un worker en manager |
| `docker service create --name <n> --replicas N <img>` | Créer un service replicated |
| `docker service create --name <n> --mode global <img>` | Créer un service global |
| `docker service scale <n>=N` | Ajuster le nombre de replicas |
| `docker service ls` | Lister les services |
| `docker service ps <n>` | Lister les tâches d'un service |
| `docker service logs <n>` | Afficher les logs d'un service |
| `docker service update <options> <n>` | Mettre à jour un service |
| `docker service rm <n>` | Supprimer un service |
| `docker stack deploy -c <f> <stack>` | Déployer une stack |
| `docker stack ls` | Lister les stacks |
| `docker stack services <stack>` | Services d'une stack |
| `docker stack ps <stack>` | Tâches d'une stack |
| `docker stack rm <stack>` | Supprimer une stack |
