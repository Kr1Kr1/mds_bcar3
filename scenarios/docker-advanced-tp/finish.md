# Félicitations !

Vous avez maîtrisé quatre techniques avancées de Docker.

| Étape | Ce que vous avez pratiqué |
|-------|--------------------------|
| 1 | Multi-stage build, images minimales, `scratch`, HEALTHCHECK |
| 2 | Docker Buildx, QEMU, builds multi-arch amd64+arm64 |
| 3 | Optimisation du cache : ordre des COPY, `.dockerignore`, BuildKit |
| 4 | Audit de sécurité : USER non-root, secrets, `.dockerignore`, image slim |

## Points clés à retenir

**Image minimale**
- Multi-stage sépare le build du runtime
- `FROM scratch` + binaire statique Go → quelques Mo seulement
- `alpine` et `distroless` sont de bons compromis

**Multi-arch**
- `docker buildx` + QEMU = builds cross-platform depuis une machine amd64
- Un seul tag = manifest list qui sert la bonne arch automatiquement

**Cache**
- Les layers moins changeants d'abord (deps), puis le code
- `.dockerignore` évite d'invalider le cache avec des fichiers non pertinents

**Sécurité**
- Jamais de secrets dans l'image — utiliser `-e`, Docker secrets ou un vault
- Toujours un `USER` non-root
- Toujours un `.dockerignore`
- Toujours pinner les versions des dépendances
