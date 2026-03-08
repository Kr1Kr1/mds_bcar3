# Bien joué !

Vous avez parcouru les deux façons de créer une image Docker et compris le système de layers.

## Ce que vous savez maintenant

| Concept | Commande clé |
|---------|-------------|
| Voir les changements d'un conteneur | `docker diff <id>` |
| Créer une image depuis un conteneur | `docker commit <id> <nom>` |
| Écrire une image de façon reproductible | `Dockerfile` + `docker build -t <nom> .` |
| Voir l'historique des layers | `docker history <image>` |
| Utiliser le cache de build | Ordonner les instructions du moins au plus changeant |

## docker commit vs Dockerfile

| | `docker commit` | `Dockerfile` |
|--|----------------|--------------|
| Reproductible | ✗ | ✓ |
| Versionnable avec Git | ✗ | ✓ |
| Auditable | ✗ | ✓ |
| Rapide pour tester | ✓ | ~ |

**En production : toujours le Dockerfile.**

## Bonne pratique sur les layers

```dockerfile
# ✗ Mauvais : 2 layers inutiles
RUN dnf install -y wget
RUN dnf install -y zip

# ✓ Bon : 1 seul layer, image plus légère
RUN dnf install -y wget zip && dnf clean all
```
