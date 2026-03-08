# Félicitations !

Vous avez exploré le réseau Docker de bout en bout :

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | Bridge par défaut — inspection et communication par IP |
| 2 | Bridge personnalisé — résolution DNS automatique par nom |
| 3 | Multi-réseau — connecter un conteneur à plusieurs réseaux à chaud |
| 4 | Port mapping — exposer un service vers l'hôte (`-p` et `-P`) |
| 5 | Load balancing — architecture HAProxy + nginx en round-robin |

## Points clés à retenir

- Le bridge **par défaut** ne résout pas les noms de conteneurs — communication par IP uniquement.
- Un bridge **personnalisé** offre la résolution DNS : les conteneurs se joignent par leur nom.
- `docker network connect` permet de connecter un conteneur à un réseau **sans le redémarrer**.
- `-p hôte:conteneur` mappe un port précis ; `-P` laisse Docker choisir automatiquement.
- HAProxy en conteneur peut distribuer le trafic entre plusieurs backends Docker sur le même réseau.

## Commandes essentielles

```bash
docker network create <nom>
docker network ls
docker network inspect <nom>
docker network connect <réseau> <conteneur>
docker network disconnect <réseau> <conteneur>
docker port <conteneur>
```
