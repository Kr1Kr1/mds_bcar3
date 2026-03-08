# Félicitations !

Vous avez maîtrisé les fondamentaux de Docker Compose :

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | `docker-compose.yml` — définir et lancer un service nginx exposé |
| 2 | Stack multi-services — réseau automatique et résolution DNS entre services |
| 3 | Variables d'environnement — fichier `.env` et substitution `${VAR}` |
| 4 | Volumes nommés — persistance des données MySQL entre redémarrages |
| 5 | Scaling — plusieurs instances d'un service, logs, exec, down -v |

## Points clés à retenir

- Compose crée automatiquement un **réseau bridge** par projet : les services se joignent par leur **nom de service**.
- Les variables dans `.env` sont substituées automatiquement dans `docker-compose.yml` — **ne jamais committer `.env`**.
- `docker compose down` supprime les conteneurs et réseaux ; les **volumes nommés** sont préservés.
- `docker compose down -v` supprime aussi les volumes — à utiliser avec précaution.
- Le scaling (`--scale service=N`) nécessite que le service **n'ait pas de port fixe** côté hôte (utiliser `expose:` au lieu de `ports:` pour les backends).

## Commandes essentielles

```bash
docker compose up -d
docker compose down
docker compose down -v
docker compose ps
docker compose logs -f [service]
docker compose exec <service> <commande>
docker compose up -d --scale <service>=N
docker compose build
docker compose pull
```
