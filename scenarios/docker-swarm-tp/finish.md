# Félicitations !

Vous avez découvert Docker Swarm et les concepts fondamentaux de l'orchestration de conteneurs :

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | Initialisation du Swarm — cluster à 1 manager |
| 2 | Services replicated (httpd × 4) et global (alpine) |
| 3 | Visualizer — tableau de bord graphique du cluster |
| 4 | Maintenance nœud — drain et retour en service |
| 5 | Stack multi-services avec `docker stack deploy` |

## Points clés à retenir

- Un **manager** contrôle le cluster ; un **worker** exécute les tâches. En production,
  prévoir un nombre impair de managers (3 ou 5) pour garantir le quorum.
- Un service **replicated** maintient un nombre fixe de tâches réparties sur le cluster.
- Un service **global** déploie exactement une tâche sur chaque nœud éligible.
- `docker node update --availability drain` retire proprement un nœud pour maintenance ;
  les tâches migrent automatiquement vers les nœuds actifs.
- `docker stack deploy` déploie une application Compose complète en mode Swarm,
  avec les directives `deploy:` pour configurer le placement et la résilience.

## Commandes essentielles

```bash
# Cluster
docker swarm init
docker swarm join --token <token> <ip>:<port>
docker node ls
docker node update --availability drain|active|pause <nœud>
docker node promote <nœud>

# Services
docker service create --name <nom> --replicas N <image>
docker service create --name <nom> --mode global <image>
docker service scale <nom>=N
docker service ls
docker service ps <nom>
docker service logs <nom>
docker service update <options> <nom>
docker service rm <nom>

# Stacks
docker stack deploy -c <fichier.yml> <stack>
docker stack ls
docker stack services <stack>
docker stack ps <stack>
docker stack rm <stack>
```
