# Étape 2 — Builds multi-architectures avec Docker Buildx

## Contexte

Votre application doit tourner sur **x86_64 (amd64)** et **ARM64** (cloud, Raspberry Pi, Apple Silicon).
Docker Buildx + QEMU permettent de builder pour plusieurs architectures depuis une seule machine.

> ✅ QEMU et un builder `multibuilder` sont déjà configurés sur cette machine.

## Objectifs

1. Vérifiez que le builder `multibuilder` est actif (`docker buildx ls`)
2. Prenez le Dockerfile de l'étape précédente (ou un simple `FROM alpine` + `CMD ["echo", "hello"]`)
3. Buildez une image **pour amd64 ET arm64** simultanément avec `--platform`
4. Poussez l'image vers un registry local (lancez un registry sur `localhost:5000`) ou exportez-la
5. Vérifiez que l'image contient bien un **manifest multi-arch** (`docker buildx imagetools inspect`)

<details>
<summary>💡 Indice : commande buildx multi-plateforme</summary>

```bash
# Builder pour plusieurs archs et pousser vers un registry local
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag localhost:5000/mon-app:multiarch \
  --push \
  .
```

Pour pousser vers localhost (registry sans TLS), il faut l'ajouter en "insecure" :
```json
// /etc/docker/daemon.json
{
  "insecure-registries": ["localhost:5000"]
}
```
Puis relancer Docker et le registry : `docker run -d -p 5000:5000 registry:2`
</details>

<details>
<summary>💡 Indice : vérifier le manifest multi-arch</summary>

```bash
docker buildx imagetools inspect localhost:5000/mon-app:multiarch
```

Vous devriez voir deux manifests : un pour `linux/amd64` et un pour `linux/arm64`.
</details>

<details>
<summary>💡 Indice : si QEMU n'est pas actif</summary>

```bash
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --name multibuilder --use
docker buildx inspect --bootstrap
```
</details>

Cliquez sur **Check** quand votre image est buildée pour au moins deux plateformes.
