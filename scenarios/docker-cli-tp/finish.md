# Bien joué !

Vous maîtrisez maintenant les commandes fondamentales de la CLI Docker.

## Récapitulatif des commandes vues

| Commande | Rôle |
|----------|------|
| `docker version` / `docker info` | Informations sur l'installation |
| `docker pull <image>` | Télécharger une image |
| `docker images` | Lister les images locales |
| `docker run <image>` | Créer et démarrer un conteneur |
| `docker run -it` | Mode interactif (terminal) |
| `docker run -d` | Mode détaché (arrière-plan) |
| `docker ps` / `docker ps -a` | Lister les conteneurs |
| `docker exec -it <id> bash` | Ouvrir un shell dans un conteneur actif |
| `docker attach <id>` | Se connecter au processus principal |
| `docker logs -f --tail 10` | Suivre les logs en direct |
| `docker stop` / `docker start` | Arrêter / redémarrer sans recréer |
| `docker inspect --format` | Extraire des infos précises |
| `docker rm` | Supprimer un conteneur |
| `docker container prune` | Supprimer tous les conteneurs arrêtés |

## La suite

Le prochain TP porte sur les **images Docker** : construire ses propres images avec un `Dockerfile`.
