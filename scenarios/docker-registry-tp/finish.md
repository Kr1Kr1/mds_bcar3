# Félicitations !

Vous avez déployé et exploité un registry Docker privé de bout en bout :

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | Démarrer `registry:2` et valider l'API REST (`/v2/`) |
| 2 | Tagger une image avec le préfixe du registry et la pousser |
| 3 | Supprimer l'image locale puis la retirer depuis le registry |
| 4 | Explorer le catalogue, les tags et les manifestes via l'API |

## Points clés à retenir

- Un registry Docker est un **simple serveur HTTP** : toute interaction passe par l'API REST.
- Le **tag d'une image détermine la destination** du push — `localhost:5000/nom:tag` → registry local.
- Docker n'autorise les registries HTTP (non-TLS) qu'en `localhost`; ailleurs il faut `insecure-registries`.
- L'**API v2** est standardisée (OCI Distribution Spec) : Docker Hub, GHCR, ECR… même protocole.
- `/v2/_catalog` liste les dépôts ; `/v2/<repo>/tags/list` liste les tags ; `/v2/<repo>/manifests/<tag>` donne les métadonnées.

## Commandes essentielles

```bash
# Lancer le registry
docker run -d -p 5000:5000 --restart always --name registry registry:2

# Tagger et pousser
docker tag <image>:<tag> localhost:5000/<nom>:<tag>
docker push localhost:5000/<nom>:<tag>

# Tirer depuis le registry privé
docker pull localhost:5000/<nom>:<tag>

# API REST
curl http://localhost:5000/v2/                              # ping
curl http://localhost:5000/v2/_catalog                     # catalogue
curl http://localhost:5000/v2/<repo>/tags/list             # tags
curl -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
     http://localhost:5000/v2/<repo>/manifests/<tag>       # manifeste
```
