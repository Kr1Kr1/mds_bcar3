# Étape 3 — Service : exposer l'application

## 1. Créer un Service ClusterIP

*Créez le fichier `/root/service-clusterip.yaml` définissant un Service de type `ClusterIP` nommé `webapp-svc`, ciblant les pods avec le label `app: webapp` sur le port 80.*

*Appliquez le manifest pour créer le Service.*

*Affichez les détails du Service `webapp-svc` pour voir son ClusterIP.*

## 2. Tester le ClusterIP

*Lancez un pod temporaire avec l'image `curlimages/curl` pour envoyer une requête HTTP vers `webapp-svc` et vérifiez que le Service répond.*

> Le Service répartit les requêtes entre les 3 pods

## 3. Créer un Service NodePort

*Créez le fichier `/root/service-nodeport.yaml` définissant un Service de type `NodePort` nommé `webapp-nodeport`, ciblant les pods avec le label `app: webapp`, port 80 vers targetPort 80, nodePort 30080.*

*Appliquez le manifest pour créer le Service NodePort.*

*Listez tous les Services et vérifiez que les 2 Services sont présents.*

## 4. Tester le NodePort depuis l'hôte

*Envoyez une requête HTTP sur `localhost:30080` pour tester l'accès via le NodePort.*

## 5. Vérifier les Endpoints

*Listez les Endpoints du Service `webapp-svc` pour voir les IPs des pods enregistrés.*

> Les Endpoints correspondent aux IPs des pods — le Service les met à jour automatiquement

*Décrivez le Service `webapp-svc` pour voir les détails complets.*

> Cliquez sur **Check** quand les Services sont créés et que curl fonctionne.
