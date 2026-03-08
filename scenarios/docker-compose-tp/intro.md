# Docker Compose — TP

Dans ce TP vous allez apprendre à orchestrer des applications multi-conteneurs
avec Docker Compose : définir une stack dans un fichier YAML, gérer les réseaux
automatiques, injecter des variables d'environnement et persister des données.

## Au programme

| Étape | Sujet |
|-------|-------|
| 1 | Premier `docker-compose.yml` — service nginx accessible depuis l'hôte |
| 2 | Stack multi-services — nginx + backend, communication via réseau Compose |
| 3 | Variables d'environnement — fichier `.env` et configuration des services |
| 4 | Volumes nommés — persistance des données après `down` / `up` |
| 5 | Scaling et commandes avancées — plusieurs instances, logs, exec, ps |

> Docker CE et le plugin Compose sont en cours d'installation en arrière-plan.
> Attendez que la commande `docker compose version` réponde avant de commencer.
