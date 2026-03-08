# Étape 3 — Créer et piloter un conteneur via l'API

Créer un conteneur via l'API se fait en **deux temps** : create puis start.
Un fichier JSON de payload est disponible dans `/root/api-tp/create_container_simple.json`.

## Objectifs

1. **Créez** un conteneur nommé `api-test` à partir du payload JSON fourni
2. **Vérifiez** qu'il existe (état Created) via l'API
3. **Démarrez** le conteneur via l'API
4. **Vérifiez** qu'il tourne (`docker ps` ou via l'API)
5. **(Bonus)** Créez un second conteneur avec le payload nginx qui expose le port 8080

> 📁 Payloads disponibles :
> - `/root/api-tp/create_container_simple.json` (ubuntu + sleep)
> - `/root/api-tp/create_container_complex.json` (nginx + port mapping)

<details>
<summary>💡 Indice : créer un conteneur (POST /containers/create)</summary>

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d @/root/api-tp/create_container_simple.json \
  "http://localhost:2375/v1.xx/containers/create?name=api-test"
```

La réponse contient l'`Id` du conteneur créé.
</details>

<details>
<summary>💡 Indice : démarrer un conteneur (POST /containers/{id}/start)</summary>

```bash
curl -s -X POST "http://localhost:2375/v1.xx/containers/api-test/start"
```

Une réponse 204 (No Content) signifie que le conteneur a démarré.
</details>

Cliquez sur **Check** quand le conteneur `api-test` tourne.
