# Correction — Docker Registry TP

---

## Étape 1 — Lancer un registry privé

```bash
# Lancer le conteneur registry:2 en arrière-plan
# --restart always : redémarre automatiquement (crash ou reboot)
# -p 5000:5000     : port hôte:conteneur
# --name registry  : nom lisible pour les commandes suivantes
docker run -d \
  --name registry \
  --restart always \
  -p 5000:5000 \
  registry:2

# Vérifier que le conteneur tourne
docker ps

# Vérifier que l'API répond (doit retourner {} avec HTTP 200)
curl http://localhost:5000/v2/
# → {}

# Pour voir le code HTTP explicitement
curl -s -o /dev/null -w "%{http_code}" http://localhost:5000/v2/
# → 200
```

> **Pourquoi `{}` ?** L'endpoint `/v2/` est le "ping" de l'API Registry v2.
> Une réponse `{}` avec HTTP 200 signifie que le registry est opérationnel et
> que le client est bien authentifié (ici pas d'auth, donc toujours 200).
> Un registry avec authentification retournerait 401 sans token.

---

## Étape 2 — Pousser une image dans le registry

```bash
# Vérifier les images disponibles localement
docker images
# nginx:alpine doit être présent (pré-téléchargé par le background script)

# Tagger l'image avec le préfixe du registry privé
docker tag nginx:alpine localhost:5000/monapp:v1

# Vérifier le nouveau tag
docker images | grep localhost:5000
# → localhost:5000/monapp   v1   ...

# Pousser l'image dans le registry
docker push localhost:5000/monapp:v1

# Vérifier via l'API REST que le push a bien fonctionné
curl http://localhost:5000/v2/_catalog
# → {"repositories":["monapp"]}
```

> **Pourquoi retagger ?** Docker utilise le préfixe de l'image pour déterminer
> la destination du push. Sans préfixe → Docker Hub. Avec `localhost:5000/` →
> registry local. Le tag `nginx:alpine` seul enverrait vers `registry-1.docker.io`.

> **Pourquoi HTTP et pas HTTPS ?** Par défaut, Docker refuse les registries non-TLS
> sauf pour `localhost` (loopback) qui est explicitement autorisé comme exception.
> Pour pousser vers `192.168.1.10:5000` il faudrait ajouter dans `/etc/docker/daemon.json` :
> ```json
> { "insecure-registries": ["192.168.1.10:5000"] }
> ```

---

## Étape 3 — Tirer une image depuis le registry

```bash
# Supprimer le tag local localhost:5000/monapp:v1
docker rmi localhost:5000/monapp:v1

# Supprimer également l'image source si on veut forcer un vrai pull
docker rmi nginx:alpine

# Vérifier l'absence locale
docker images | grep -E "localhost:5000|nginx"
# → (vide)

# Tirer l'image depuis le registry privé
docker pull localhost:5000/monapp:v1

# Vérifier la présence locale
docker images | grep localhost:5000
# → localhost:5000/monapp   v1   ...

# Tester que l'image fonctionne
docker run --rm localhost:5000/monapp:v1 nginx -v
# → nginx version: nginx/...
```

> **Différence pull registry privé / Docker Hub :**
> - `docker pull nginx:alpine` → résout vers `registry-1.docker.io/library/nginx:alpine`
> - `docker pull localhost:5000/monapp:v1` → contacte directement `localhost:5000`
>
> Dans les deux cas Docker utilise le même protocole HTTP (API Distribution v2).
> La seule différence est l'adresse du registre et l'authentification associée.

---

## Étape 4 — Explorer l'API REST du registry

### 1. Catalogue — lister tous les dépôts

```bash
curl http://localhost:5000/v2/_catalog
# → {"repositories":["monapp"]}
```

### 2. Tags d'un dépôt

```bash
curl http://localhost:5000/v2/monapp/tags/list
# → {"name":"monapp","tags":["v1"]}
```

Pousser plusieurs tags pour rendre l'exploration plus intéressante :

```bash
docker tag nginx:alpine localhost:5000/monapp:v2
docker tag nginx:alpine localhost:5000/monapp:latest
docker push localhost:5000/monapp:v2
docker push localhost:5000/monapp:latest

curl http://localhost:5000/v2/monapp/tags/list
# → {"name":"monapp","tags":["v1","v2","latest"]}
```

### 3. Manifeste d'une image

```bash
# Sans header Accept → retourne le manifeste schema v1 (legacy)
curl http://localhost:5000/v2/monapp/manifests/v1

# Avec header Accept → manifeste schema v2 (recommandé)
curl -s \
  -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
  http://localhost:5000/v2/monapp/manifests/v1 | python3 -m json.tool
```

Extrait de réponse typique :

```json
{
  "schemaVersion": 2,
  "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
  "config": {
    "mediaType": "application/vnd.docker.container.image.v1+json",
    "size": 7682,
    "digest": "sha256:..."
  },
  "layers": [
    {
      "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
      "size": 3408729,
      "digest": "sha256:..."
    },
    ...
  ]
}
```

> **Lecture du manifeste :**
> - `config` → le JSON d'image (équivalent de `docker inspect`) stocké comme un blob
> - `layers` → les couches de l'image dans l'ordre (même logique que les layers Dockerfile)
> - `digest` → hash SHA256 identifiant chaque blob de manière unique et immuable
>
> C'est exactement ce que Docker télécharge lors d'un `docker pull` :
> d'abord le manifeste, puis chaque layer manquant (par digest).

> **OCI Distribution Spec :** cette API est standardisée sous le nom
> [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec).
> Docker Hub, GitHub Container Registry (ghcr.io), AWS ECR, Google Artifact Registry,
> Azure Container Registry… tous implémentent exactement ces mêmes endpoints.

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker run -d -p 5000:5000 --restart always registry:2` | Lancer le registry privé |
| `docker tag <image> localhost:5000/<nom>:<tag>` | Tagger pour le registry privé |
| `docker push localhost:5000/<nom>:<tag>` | Pousser une image |
| `docker pull localhost:5000/<nom>:<tag>` | Tirer une image |
| `curl http://localhost:5000/v2/` | Ping de l'API (HTTP 200 = OK) |
| `curl http://localhost:5000/v2/_catalog` | Lister tous les dépôts |
| `curl http://localhost:5000/v2/<repo>/tags/list` | Lister les tags d'un dépôt |
| `curl -H "Accept: …manifest.v2+json" …/manifests/<tag>` | Récupérer le manifeste |
