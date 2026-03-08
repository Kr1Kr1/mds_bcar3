# Docker Swarm — TP

Dans ce TP vous allez découvrir **Docker Swarm**, l'orchestrateur natif de Docker,
qui permet de gérer un cluster de nœuds et de déployer des services hautement disponibles.

## Note importante — environnement Killercoda

> Ce TP s'exécute sur **une seule machine**. En production, un cluster Swarm se compose
> de plusieurs nœuds physiques ou virtuels (managers + workers). Ici, vous travaillez avec
> un **swarm à 1 nœud manager** — c'est suffisant pour comprendre les concepts et manipuler
> toutes les commandes. Les comportements liés à la haute disponibilité (migration de tâches,
> quorum) sont mentionnés à titre informatif.

## Au programme

| Étape | Sujet |
|-------|-------|
| 1 | Initialiser le Swarm et inspecter les nœuds |
| 2 | Déployer des services replicated et global |
| 3 | Visualiser le cluster avec le service Visualizer |
| 4 | Simuler une maintenance nœud (drain / active) |
| 5 | Déployer une stack multi-services avec docker stack |

> Docker et les images nécessaires sont en cours d'installation en arrière-plan.
> Vérifiez avec `docker images` avant de commencer.
