# Étape 2 — DaemonSet

Déployez un agent système qui tourne automatiquement sur chaque nœud.

## 1. Créer le DaemonSet

*Créez le fichier `/root/daemonset.yaml` définissant un DaemonSet nommé `node-monitor` avec le label `app: node-monitor`. Le conteneur `monitor` utilise l'image `busybox:1.36` et exécute une boucle infinie affichant le hostname et la date toutes les 30 secondes. Ajoutez une toleration pour le taint `node-role.kubernetes.io/control-plane:NoSchedule` afin que le DaemonSet tourne aussi sur le control plane. Requests : mémoire 16Mi, CPU 10m.*

*Appliquez le manifest pour créer le DaemonSet.*

## 2. Observer le déploiement sur tous les nœuds

*Affichez l'état du DaemonSet `node-monitor` (colonnes DESIRED, CURRENT, READY, etc.).*

> **DESIRED** = nombre total de nœuds éligibles (ici 2 car la toleration inclut le control plane)

*Listez les pods du DaemonSet avec leurs informations étendues pour voir sur quels nœuds ils tournent.*

> Chaque nœud a exactement 1 pod — c'est la garantie du DaemonSet

## 3. Vérifier les logs d'un pod

*Affichez les logs de tous les pods du DaemonSet avec le préfixe du nom de pod pour identifier chaque nœud.*

> Chaque pod affiche le nom de son nœud — utile pour un collecteur de logs

## 4. Comparer avec un Deployment

*Listez les pods du StatefulSet `db` avec leurs informations étendues.*

*Listez les pods du DaemonSet `node-monitor` avec leurs informations étendues.*

> StatefulSet : pods sur certains nœuds | DaemonSet : exactement 1 pod par nœud

## Validation

> Cliquez sur **Check** quand le DaemonSet `node-monitor` a au moins 2 pods Running.
