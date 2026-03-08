# Docker Réseau — TP

Dans ce TP vous allez explorer le réseau Docker de fond en comble :
comment les conteneurs se voient entre eux, comment isoler des groupes de services,
et comment exposer un service vers l'extérieur.

## Au programme

| Étape | Sujet |
|-------|-------|
| 1 | Bridge par défaut — inspection et communication entre conteneurs |
| 2 | Créer un réseau bridge personnalisé avec résolution DNS |
| 3 | Connecter un conteneur à plusieurs réseaux |
| 4 | Port mapping manuel et automatique avec nginx |
| 5 | Architecture 3-tiers : nginx × 2 + HAProxy en load balancer |

> Docker et les images nginx/haproxy sont en cours d'installation en arrière-plan.
> Vérifiez avec `docker images` avant de commencer.
