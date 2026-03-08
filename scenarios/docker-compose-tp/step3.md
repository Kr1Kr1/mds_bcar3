# Étape 3 — Variables d'environnement et fichier .env

## Objectifs

1. Remplacez le service redis par **mysql:8** (ou ajoutez-le à votre stack)
2. Configurez les variables d'environnement nécessaires au démarrage de MySQL
   directement dans le `docker-compose.yml` (clé `environment:`)
3. Créez un fichier **`.env`** dans votre répertoire de projet et déplacez-y
   au moins une variable sensible (ex. le mot de passe root)
4. Faites référence à cette variable dans le `docker-compose.yml` avec la syntaxe `${NOM_VAR}`
5. Relancez la stack et vérifiez que MySQL démarre correctement

> 💡 Pourquoi ne pas committer un fichier `.env` contenant des mots de passe dans Git ?
> Que doit-on mettre à la place dans le dépôt ?

> ⚠️ MySQL peut mettre quelques secondes à être prêt après le démarrage du conteneur.

Cliquez sur **Check** quand c'est fait.
