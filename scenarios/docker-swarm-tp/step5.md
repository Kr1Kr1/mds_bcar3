# Étape 5 — Stack multi-services avec docker stack deploy

## Objectifs

Docker Stack permet de déployer une application multi-services décrite dans un fichier
Compose enrichi de directives Swarm (`deploy:`).

1. Créez un fichier `stack.yml` décrivant **deux services** :
   - Un service `debug` de type **global** basé sur `alpine` avec une commande persistante
   - Un service `appweb` de type **replicated** avec **4 replicas** basé sur `httpd`,
     port **8081** exposé sur l'hôte

2. Déployez la stack avec `docker stack deploy` en lui donnant un nom (ex : `monapp`)

3. Vérifiez la stack et ses services :
   - `docker stack ls`
   - `docker stack services <nom>`
   - `docker stack ps <nom>`

4. Inspectez les tâches déployées — notez la différence d'état entre le service global
   et le service replicated sur un seul nœud

> 💡 La clé `deploy:` dans un fichier Compose permet de configurer le mode (`replicated`/`global`),
> le nombre de replicas, les contraintes de placement, les ressources, etc.

> 💡 En quoi `docker stack deploy` diffère-t-il de `docker compose up` ?
> Quelles fonctionnalités Compose ne sont pas supportées en mode Swarm ?

> ⚠️ Le fichier Compose doit utiliser le format `version: "3"` ou supérieur
> pour être compatible avec `docker stack deploy`.

Cliquez sur **Check** quand c'est fait.
