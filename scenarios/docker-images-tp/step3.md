# Étape 3 — Écrire un Dockerfile et construire une image

## Objectifs

1. Créez un nouveau répertoire de travail dédié à cette image
2. Dans ce répertoire, créez un fichier `Dockerfile` qui :
   - Utilise **rockylinux/rockylinux** comme image de base
   - Met à jour les paquets
   - Installe `wget`
3. Construisez l'image en la nommant **monimage-dockerfile**
4. Listez les images et vérifiez qu'elle apparaît bien
5. Modifiez le Dockerfile pour **ajouter l'installation de `zip`** (dans une instruction séparée)
6. Reconstruisez l'image — observez attentivement la sortie : que remarquez-vous ?
7. Affichez l'**historique de construction** de l'image

> 💡 Lors du second build, certaines étapes sont-elles réexécutées ? Qu'est-ce que cela vous dit sur le fonctionnement interne de Docker ?

Cliquez sur **Check** quand c'est fait.
