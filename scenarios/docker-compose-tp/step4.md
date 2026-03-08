# Étape 4 — Persistance des données avec les volumes

## Objectifs

1. Ajoutez un **volume nommé** dans votre `docker-compose.yml` pour persister les données de MySQL
2. Montez ce volume dans le service MySQL sur le répertoire de données approprié (`/var/lib/mysql`)
3. Lancez la stack, connectez-vous à MySQL et **créez une base de données** de test
4. Arrêtez complètement la stack avec `docker compose down` (sans `-v`)
5. Relancez avec `docker compose up -d` et vérifiez que votre base de données est toujours présente

> 💡 Quelle est la différence entre `docker compose down` et `docker compose down -v` ?
> Où Docker stocke-t-il les données des volumes nommés sur l'hôte ?

> 💡 Un volume **anonyme** vs un volume **nommé** : quelle différence en termes de cycle de vie ?

Cliquez sur **Check** quand c'est fait.
