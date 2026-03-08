# Docker Images — TP

Dans ce TP vous allez explorer les deux façons de créer une image Docker,
comprendre le système de layers et apprendre à optimiser un Dockerfile.

## Au programme

| Étape | Sujet |
|-------|-------|
| 1 | Modifier un conteneur et inspecter ses différences avec l'image source |
| 2 | Créer une image "à la main" avec `docker commit` |
| 3 | Écrire un `Dockerfile` et construire une image proprement |
| 4 | Observer le cache de build, l'historique des layers, et optimiser |

## Règles

- Pas de copier-coller — cherchez avec `docker help` ou `docker <cmd> --help`
- L'image **rockylinux/rockylinux** est en cours de téléchargement en arrière-plan

> Pour vérifier que Docker et l'image sont prêts : `docker images`
