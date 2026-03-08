# Étape 3 — Service Visualizer

## Objectifs

1. Déployez l'image `dockersamples/visualizer` en tant que **service Swarm** nommé `viz` :
   - Exposez le port **8080** sur l'hôte
   - Montez le socket Docker (`/var/run/docker.sock`) en volume pour que le visualizer
     puisse interroger l'API Swarm
   - Contraignez le service à s'exécuter sur un **nœud manager**

2. Attendez que le service soit en état `Running` (`docker service ps viz`)

3. Accédez au visualizer via le bouton **Traffic / Port** de Killercoda sur le port **8080**

> 💡 Pour contraindre un service à tourner sur un manager, explorez l'option `--constraint`
> de `docker service create` (ex : `node.role == manager`).

> 💡 Le visualizer affiche les nœuds et les tâches en temps réel.
> Modifiez le nombre de replicas d'un service pendant qu'il est ouvert pour observer les changements.

Cliquez sur **Check** quand c'est fait.
