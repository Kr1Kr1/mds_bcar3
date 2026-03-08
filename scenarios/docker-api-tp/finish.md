# Félicitations !

Vous avez piloté Docker via son API REST de bout en bout.

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | Exposer l'API Docker sur TCP (daemon.json + override systemd) |
| 2 | Explorer les endpoints : images, pull, info |
| 3 | Créer et démarrer un conteneur avec un payload JSON |
| 4 | Signaux, suppression, socket Unix et jq |

## Points clés

- Tout ce que fait la CLI `docker` passe par cette API REST.
- Le socket Unix `/var/run/docker.sock` est toujours disponible localement — pas besoin d'exposer TCP pour un usage local.
- L'API est versionnée : `/v1.43/`, `/v1.44/`… consultez la doc de votre version exacte.
- En production, l'exposition TCP nécessite **TLS mutuel** (port 2376).

## Commandes clés

```bash
# Via TCP
curl http://localhost:2375/version
curl http://localhost:2375/containers/json

# Via socket Unix (sans exposition TCP)
curl --unix-socket /var/run/docker.sock http://localhost/version

# Avec jq
curl -s --unix-socket /var/run/docker.sock http://localhost/images/json | jq '.[].RepoTags'
```
