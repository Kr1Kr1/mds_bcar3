# Étape 4 — Cache, layers et optimisation

## Objectifs

1. Modifiez le Dockerfile pour que l'installation de `wget` **et** de `zip` soient réalisées dans **une seule et même instruction**
2. Reconstruisez l'image — observez la sortie : qu'est-ce qui change par rapport aux builds précédents ?
3. Comparez l'**historique** de cette version avec celui de la version précédente

> 💡 Chaque instruction du Dockerfile crée un **layer** (couche) dans l'image finale.
> Fusionner des instructions `RUN` réduit le nombre de layers — pourquoi est-ce important ?

**Questions à réfléchir**

- Que se passe-t-il si vous modifiez la ligne `FROM` — le cache est-il réutilisé ?
- Dans quel ordre écrire les instructions pour maximiser l'utilisation du cache ?

Cliquez sur **Check** quand c'est fait.
