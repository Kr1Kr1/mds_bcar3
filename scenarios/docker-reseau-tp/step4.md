# Étape 4 — Port mapping avec nginx

## Objectifs

1. Lancez un conteneur **nginx** en exposant son port **80** sur un port de votre hôte (ex. `8080`)
2. Vérifiez que nginx répond depuis l'hôte (ex. `curl localhost:8080`)
3. Lancez un **second conteneur nginx** en laissant Docker choisir le port hôte automatiquement
4. Identifiez le port attribué automatiquement et vérifiez qu'il répond aussi

> 💡 Il existe deux façons de mapper des ports : `-p 8080:80` (manuel) et `-P` (automatique via les ports déclarés dans l'image).

> 💡 `docker port <conteneur>` affiche les mappings actifs d'un conteneur.

Cliquez sur **Check** quand c'est fait.
