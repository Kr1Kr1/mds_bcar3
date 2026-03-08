# Étape 2 — Explorer l'API : version, images, pull

L'API Docker suit les conventions REST. La base URL est `http://localhost:2375/v<ApiVersion>/`.

## Objectifs

1. **Listez les images** présentes localement via l'API
2. **Pullez l'image `alpine:latest`** via l'API (endpoint POST)
3. Vérifiez qu'elle apparaît dans la liste après le pull
4. Récupérez les **informations système** du daemon (équivalent de `docker info`)

> 💡 La doc complète de l'API : https://docs.docker.com/engine/api/

<details>
<summary>💡 Indice : les endpoints à utiliser</summary>

```bash
# Lister les images
GET /v1.xx/images/json

# Puller une image (POST, la progression s'affiche en streaming JSON)
POST /v1.xx/images/create?fromImage=alpine&tag=latest

# Infos système
GET /v1.xx/info
```

Remplacez `1.xx` par la version que vous avez notée à l'étape précédente.
</details>

<details>
<summary>💡 Indice : syntaxe curl pour un POST sans body</summary>

```bash
curl -s -X POST "http://localhost:2375/v1.xx/images/create?fromImage=alpine&tag=latest"
```
</details>

Cliquez sur **Check** quand `alpine:latest` est présente localement.
