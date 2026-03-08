# Étape 2 — Cycle de vie : suppression des volumes

## Objectifs

1. Listez tous les volumes présents sur le système
2. Tentez de supprimer `vol1` **sans arrêter les conteneurs qui l'utilisent** — que se passe-t-il ?
3. Arrêtez et supprimez tous les conteneurs qui montent `vol1`
4. Supprimez le volume `vol1` avec `docker volume rm`
5. Vérifiez qu'il n'existe plus

### Pour aller plus loin

6. Créez un volume temporaire en lançant directement un conteneur avec `-v nom_vol:/chemin` **sans** créer le volume au préalable
7. Supprimez ce conteneur puis listez les volumes — que remarquez-vous ?
8. Utilisez `docker volume prune` pour supprimer tous les volumes non utilisés — confirmez la suppression

> ⚠️ `docker volume prune` supprime **tous** les volumes non attachés à un conteneur en cours d'exécution. À utiliser avec précaution en production.

> 💡 Quelle est la différence entre supprimer un conteneur et supprimer un volume ?

Cliquez sur **Check** quand `vol1` n'existe plus sur le système.
