# Étape 3 — Connexion à plusieurs réseaux

## Objectifs

1. Créez un **second réseau** bridge personnalisé (ex. `reseau-b`)
2. Lancez un conteneur **uniquement sur `reseau-b`**
3. Connectez un conteneur de l'étape précédente à **`reseau-b`** (sans le recréer)
4. Vérifiez que ce conteneur peut désormais joindre les deux réseaux

> 💡 `docker network connect` permet d'attacher un conteneur à un réseau supplémentaire à chaud.

> 💡 Un conteneur connecté à deux réseaux dispose de deux interfaces réseau et peut communiquer avec les conteneurs des deux réseaux.

Cliquez sur **Check** quand c'est fait.
