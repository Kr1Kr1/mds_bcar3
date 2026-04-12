# Étape 1 — Deployment et scaling

## 1. Créer le Deployment

*Créez le fichier `/root/deployment.yaml` définissant un Deployment nommé `webapp` avec les caractéristiques suivantes : 3 replicas, image `nginx:1.24`, label `app: webapp`, label de template `version: "1.0"`, port 80, requests CPU 50m et mémoire 32Mi, limits CPU 100m et mémoire 64Mi.*

*Appliquez le manifest pour créer le Deployment.*

## 2. Vérifier le déploiement

*Affichez l'état du Deployment `webapp`.*

*Attendez que le rollout du Deployment soit terminé.*

*Listez les pods portant le label `app=webapp`.*

*Listez les ReplicaSets présents dans le namespace.*

## 3. Scaler le Deployment

*Passez le nombre de replicas du Deployment `webapp` à 5.*

*Observez en temps réel la création des nouveaux pods (label `app=webapp`).*

> Appuyez sur Ctrl+C pour arrêter le watch

## 4. Réduire les replicas

*Réduisez le nombre de replicas du Deployment `webapp` à 3.*

*Vérifiez que les pods ont bien été réduits à 3.*

> Cliquez sur **Check** quand le Deployment `webapp` a 3 pods Running.
