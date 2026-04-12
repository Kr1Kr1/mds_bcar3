# Étape 3 — Inspecter et déboguer

Apprenez à diagnostiquer l'état d'un pod.

## 1. Décrire le pod en détail

*Affichez la description complète du pod `nginx-pod`.*

> Repérez : les **Events**, les **Conditions**, les **Limits/Requests**, l'IP du pod

## 2. Voir les logs

*Affichez les logs du pod `nginx-pod`.*

*Affichez les 5 dernières lignes de logs du pod.*

## 3. Exécuter une commande dans le conteneur

*Exécutez la commande `nginx -v` dans le conteneur du pod pour afficher la version.*

*Ouvrez un shell interactif dans le conteneur du pod.*

Dans le conteneur, explorez :

*Affichez le contenu du fichier de configuration nginx `/etc/nginx/nginx.conf`.*

*Effectuez une requête HTTP sur `localhost` depuis l'intérieur du conteneur.*

*Quittez le shell interactif.*

## 4. Port-forward pour tester depuis l'hôte

*Créez un port-forward entre le port local 8080 et le port 80 du pod `nginx-pod`, en arrière-plan.*

*Effectuez une requête HTTP sur `localhost:8080` pour vérifier que le pod répond.*

*Arrêtez le processus de port-forward.*

## 5. Voir le YAML complet

*Affichez le manifeste YAML complet du pod `nginx-pod` tel qu'il est stocké dans etcd (limitez à 50 lignes).*

## 6. Nettoyer

*Supprimez le pod `nginx-pod`.*

*Vérifiez que la liste des pods est vide.*

> Cliquez sur **Check** quand le pod est supprimé.
