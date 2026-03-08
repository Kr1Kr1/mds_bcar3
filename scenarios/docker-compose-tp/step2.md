# Étape 2 — Stack multi-services

## Objectifs

1. Ajoutez un second service à votre stack — par exemple **redis** (image `redis:alpine`)
2. Relancez la stack pour que les deux services soient opérationnels
3. Vérifiez que les deux services communiquent sur le **même réseau** créé automatiquement par Compose
4. Depuis le conteneur nginx, tentez de joindre redis **par son nom de service**

> 💡 Compose crée automatiquement un réseau pour chaque projet.
> Comment s'appelle ce réseau ? Comment trouver l'adresse IP de chaque service ?

> 💡 Quelle différence entre `docker compose up`, `docker compose up -d` et `docker compose restart` ?

Cliquez sur **Check** quand c'est fait.
