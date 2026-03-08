# Étape 4 — Signaux, suppression et bonus

## Objectifs

1. **Envoyez un signal SIGHUP** au conteneur `api-test` via l'API
2. **Envoyez un signal SIGKILL** au conteneur via l'API (il s'arrête)
3. **Supprimez** le conteneur via l'API
4. **Listez tous les conteneurs** (running + stopped) via l'API

<details>
<summary>💡 Indice : envoyer un signal (POST /containers/{id}/kill)</summary>

```bash
# SIGHUP
curl -s -X POST "http://localhost:2375/v1.xx/containers/api-test/kill?signal=SIGHUP"

# SIGKILL
curl -s -X POST "http://localhost:2375/v1.xx/containers/api-test/kill?signal=SIGKILL"
```
</details>

<details>
<summary>💡 Indice : supprimer un conteneur (DELETE)</summary>

```bash
curl -s -X DELETE "http://localhost:2375/v1.xx/containers/api-test"
```
</details>

---

## Bonus 1 — Le socket Unix était déjà là

En réalité, l'API était **déjà accessible avant** que vous exposiez le port TCP. Par quel mécanisme ?

<details>
<summary>💡 Réponse</summary>

Docker écoute sur `/var/run/docker.sock` (socket Unix). On peut l'interroger avec `curl` directement :

```bash
curl -s --unix-socket /var/run/docker.sock http://localhost/version
```

C'est ce socket que la CLI `docker` utilise en interne !
</details>

## Bonus 2 — jq pour formater les réponses

<details>
<summary>💡 Utiliser jq sur les réponses API</summary>

```bash
# Lister uniquement les noms des conteneurs
curl -s --unix-socket /var/run/docker.sock http://localhost/containers/json?all=1 \
  | jq '.[].Names'

# Lister uniquement les RepoTags des images
curl -s --unix-socket /var/run/docker.sock http://localhost/images/json \
  | jq '.[].RepoTags'
```
</details>

Cliquez sur **Check** quand `api-test` est supprimé.
