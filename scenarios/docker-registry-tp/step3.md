# Étape 3 — Tirer une image depuis le registry

## Objectifs

1. **Supprimez** localement l'image que vous venez de pousser
   (le tag `localhost:5000/...` et éventuellement l'image source)

2. Vérifiez que l'image n'est plus présente en local (`docker images`)

3. **Tirez** l'image directement depuis votre registry privé avec `docker pull`

4. Confirmez que l'image est de nouveau disponible localement

> 💡 Quelle est la différence entre `docker pull localhost:5000/monapp:v1`
> et `docker pull nginx:alpine` du point de vue de Docker ?
> Qu'est-ce que Docker consulte dans chaque cas ?

> 💡 Imaginez que le registry soit sur une autre machine (ex. `192.168.1.10:5000`).
> Quelle configuration supplémentaire faudrait-il ajouter côté client Docker ?

Cliquez sur **Check** quand c'est fait.
