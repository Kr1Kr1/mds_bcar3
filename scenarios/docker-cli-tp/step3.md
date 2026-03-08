# Étape 3 — Mode interactif et exec

## Objectifs

1. Créez un conteneur **ubuntu** avec accès au terminal interactif
2. À l'intérieur, créez un fichier quelconque puis sortez du conteneur
3. Relancez **exactement la même commande** `run` — que s'est-il passé avec le fichier ?
4. Lancez un conteneur **ubuntu** avec **bash** en arrière-plan
5. Depuis l'hôte, exécutez une nouvelle instance de **bash** dans ce conteneur en cours d'exécution
6. Listez les processus à l'intérieur du conteneur — observez les **PPID**
7. Détachez-vous du conteneur sans l'arrêter

> 💡 Il existe une différence entre `docker attach` et `docker exec`. L'un rejoint le processus principal, l'autre en crée un nouveau.

Cliquez sur **Check** quand c'est fait.
