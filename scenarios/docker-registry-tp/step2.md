# Étape 2 — Pousser une image dans le registry

## Objectifs

1. Choisissez une image disponible localement (par exemple `nginx:alpine`)

2. **Taguez-la** avec un nom compatible avec votre registry privé —
   le tag doit commencer par `localhost:5000/`
   (exemple : `localhost:5000/monapp:v1`)

3. **Poussez** l'image taguée dans le registry

4. Vérifiez que le push a bien fonctionné en interrogeant l'API :
   l'endpoint **`/v2/_catalog`** doit lister votre image

> 💡 Pourquoi faut-il retagger l'image avec le préfixe `localhost:5000/` avant de pusher ?
> Que se passerait-il si vous tentiez de pusher sans ce préfixe ?

> ⚠️ Par défaut, Docker n'autorise les registries non-TLS qu'en `localhost`.
> Vers une autre machine, il faudrait configurer `insecure-registries`.

Cliquez sur **Check** quand c'est fait.
