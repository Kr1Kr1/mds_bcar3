# Docker API — TP

Docker expose une **API REST** complète qui permet de piloter le daemon (`dockerd`) sans passer par la CLI.

Tout ce que fait `docker run`, `docker ps`, `docker pull`… peut être reproduit avec de simples requêtes HTTP.

Dans ce TP vous allez :
- Exposer l'API Docker sur un port TCP
- Explorer ses endpoints avec `curl`
- Créer, démarrer, signaler et supprimer des conteneurs via l'API

> 📁 Des fichiers JSON de payload sont disponibles dans `/root/api-tp/`

La documentation de référence : **https://docs.docker.com/engine/api/**
