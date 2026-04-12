# Étape 2 — Ingress : exposition HTTP/HTTPS

Exposez plusieurs services via un seul point d'entrée HTTP.

## 1. Vérifier l'Ingress Controller

*Listez les pods du namespace `ingress-nginx` pour vérifier que l'Ingress Controller est en place.*

> Un Ingress Controller nginx est préinstallé sur ce cluster

## 2. Créer 2 services à exposer

*Créez un Deployment `app-v1` (image `nginx:1.24`, 2 replicas) et exposez-le avec un Service `svc-v1` sur le port 80.*

*Créez un Deployment `app-v2` (image `nginx:1.25`, 2 replicas) et exposez-le avec un Service `svc-v2` sur le port 80.*

*Listez les Services pour vérifier la création de `svc-v1` et `svc-v2`.*

## 3. Créer l'Ingress avec routage par chemin

*Créez le fichier `/root/ingress.yaml` définissant un Ingress nommé `mon-ingress` avec la classe `nginx`, l'annotation `nginx.ingress.kubernetes.io/rewrite-target: /`, et 2 règles de routage : le chemin `/v1` (type Prefix) vers le Service `svc-v1:80`, et le chemin `/v2` (type Prefix) vers le Service `svc-v2:80`.*

*Appliquez le manifest pour créer l'Ingress.*

## 4. Inspecter l'Ingress

*Décrivez l'Ingress `mon-ingress` pour voir les règles de routage configurées.*

> La section **Rules** montre les 2 routes configurées

## 5. Tester le routage

*Récupérez l'IP ClusterIP du Service `ingress-nginx-controller` dans le namespace `ingress-nginx` et stockez-la dans une variable.*

*Envoyez une requête HTTP vers `$INGRESS_IP/v1` et extrayez le titre de la page HTML.*

*Envoyez une requête HTTP vers `$INGRESS_IP/v2` et extrayez le titre de la page HTML.*

> Les 2 routes retournent des réponses nginx (le contenu est identique ici mais les backends sont différents)

## Validation

> Cliquez sur **Check** quand l'Ingress `mon-ingress` est créé avec 2 règles.
