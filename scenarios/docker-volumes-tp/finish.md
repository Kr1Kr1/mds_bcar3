# Félicitations !

Vous avez maîtrisé la persistance des données avec Docker de bout en bout :

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | Volumes nommés — création, montage, persistance et partage entre conteneurs |
| 2 | Cycle de vie — suppression propre, volumes orphelins et `docker volume prune` |
| 3 | Bind mounts — monter un dossier hôte, modifier à chaud, capturer des logs |
| 4 | Instruction `VOLUME` — déclaration dans un Dockerfile, volume anonyme automatique |
| 5 | Architecture HAProxy pilotée par bind mounts — configuration sans toucher aux conteneurs |

## Points clés à retenir

- Les **volumes nommés** survivent à la suppression d'un conteneur ; les données persistent.
- Les données écrites dans un volume **ne sont pas incluses dans l'image** lors d'un `docker commit`.
- Plusieurs conteneurs peuvent monter le **même volume simultanément** — tous voient les modifications en temps réel.
- Un **bind mount** expose directement un chemin hôte ; toute modification côté hôte est immédiatement visible dans le conteneur.
- `VOLUME` dans un Dockerfile crée un volume **anonyme** à chaque `docker run` ; préférez `-v nom:/chemin` pour nommer vos volumes.
- `docker volume prune` supprime tous les volumes **non attachés** à un conteneur actif — à utiliser avec précaution.

## Commandes essentielles

```bash
docker volume create <nom>
docker volume ls
docker volume inspect <nom>
docker volume rm <nom>
docker volume prune

# Volume nommé
docker run -v mon_volume:/chemin/dans/conteneur ...

# Bind mount
docker run -v /chemin/absolu/hote:/chemin/conteneur ...

# Inspecter les montages d'un conteneur
docker inspect <conteneur> --format '{{json .Mounts}}'
```
