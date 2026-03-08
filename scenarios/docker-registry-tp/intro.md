# Docker Registry — TP

Dans ce TP vous allez déployer et utiliser un **registry Docker privé** :
stocker vos propres images, les récupérer depuis le réseau local,
et interroger l'API REST du registry comme un opérateur.

## Au programme

| Étape | Sujet |
|-------|-------|
| 1 | Démarrer un registry privé `registry:2` et vérifier qu'il répond |
| 2 | Tagger une image locale et la pousser dans votre registry |
| 3 | Supprimer l'image locale puis la retirer depuis le registry |
| 4 | Explorer le catalogue et les tags via l'API REST |

> Docker et l'image `registry:2` sont en cours d'installation en arrière-plan.
> Vérifiez avec `docker images` avant de commencer.
