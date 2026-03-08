# Étape 4 — Explorer l'API REST du registry

## Objectifs

Le registry Docker expose une **API REST** complète. Explorez-la avec `curl` :

1. **Listez le catalogue** — récupérez la liste de tous les dépôts stockés dans votre registry
   via l'endpoint `/v2/_catalog`

2. **Listez les tags** d'une de vos images — chaque dépôt peut avoir plusieurs tags ;
   interrogez l'endpoint `/v2/<nom-image>/tags/list`

3. **Inspectez un manifeste** — récupérez les métadonnées d'une image précise (image + tag)
   via `/v2/<nom-image>/manifests/<tag>`
   (ajoutez le header `Accept: application/vnd.docker.distribution.manifest.v2+json`)

> 💡 Comparez la structure du manifeste avec ce que vous voyez dans `docker inspect <image>`.
> Retrouvez-vous les mêmes informations ?

> 💡 L'API Registry v2 est une spécification ouverte (OCI Distribution Spec).
> Docker Hub, GitHub Container Registry, AWS ECR… tous l'implémentent.
> Ce que vous apprenez ici s'applique partout.

Cliquez sur **Check** quand c'est fait.
