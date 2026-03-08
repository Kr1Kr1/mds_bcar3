# Étape 2 — Services replicated et global

## Objectifs

### Service web (replicated)

1. Créez un service de type **replicated** nommé `web`, basé sur l'image `httpd`,
   avec **2 replicas** et le port **80** exposé sur l'hôte
2. Vérifiez que les tâches (tasks) du service sont bien en cours d'exécution
3. **Faites évoluer** le service `web` à **4 replicas** et observez la redistribution

### Service debug (global)

4. Créez un service de type **global** nommé `debug`, basé sur l'image `alpine`,
   avec une commande qui maintient le conteneur actif (ex : `sleep infinity`)

> 💡 Quelle est la différence entre un service **replicated** et un service **global**
> en termes de placement sur les nœuds ?

> 💡 Comment inspecter les tâches d'un service ? Quelle commande affiche les logs
> d'un service Swarm ?

Cliquez sur **Check** quand c'est fait.
