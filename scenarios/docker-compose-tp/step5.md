# Étape 5 — Scaling et commandes avancées

## Objectifs

1. Scalez le service **nginx** à **3 instances** sans modifier le fichier `docker-compose.yml`
2. Vérifiez l'état de votre stack avec la commande Compose dédiée (équivalent `docker ps` pour Compose)
3. Consultez les logs de l'ensemble de la stack, puis filtrez sur un seul service
4. Exécutez une commande interactuve dans l'un des conteneurs nginx avec `docker compose exec`
5. Arrêtez la stack **et supprimez les volumes** en une seule commande

> 💡 Que se passe-t-il avec les ports mappés quand on scale un service ?
> Comment éviter ce problème (indice : ne pas mapper de port fixe côté hôte) ?

> 💡 Quelle est la différence entre `docker compose stop`, `docker compose down` et `docker compose down -v` ?

Cliquez sur **Check** quand c'est fait.
