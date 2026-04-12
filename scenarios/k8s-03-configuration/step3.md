# Étape 3 — Namespaces et ResourceQuotas

## 1. Créer des namespaces d'environnement

*Créez un namespace nommé `staging`.*

*Créez un namespace nommé `production`.*

*Listez tous les namespaces pour confirmer leur création.*

## 2. Déployer dans des namespaces séparés

*Créez le fichier `/root/deploy-staging.yaml` définissant un Deployment nommé `webapp` dans le namespace `staging` avec 1 replica, l'image `nginx:1.25`, le label `app: webapp`, requests CPU 50m et mémoire 32Mi.*

*Appliquez le manifest pour créer le Deployment dans le namespace `staging`.*

*Listez les pods dans le namespace `staging`.*

*Listez les pods dans le namespace `production` (la liste doit être vide).*

> Les namespaces sont isolés — on ne voit pas les pods entre eux avec `kubectl get pods`

## 3. Appliquer un ResourceQuota

*Créez le fichier `/root/quota-staging.yaml` définissant un ResourceQuota nommé `quota-staging` dans le namespace `staging` avec les limites suivantes : 5 pods maximum, requests.cpu 500m, requests.memory 512Mi, limits.cpu 1, limits.memory 1Gi.*

*Appliquez le manifest pour créer le ResourceQuota.*

*Décrivez le ResourceQuota `quota-staging` dans le namespace `staging` pour voir l'utilisation actuelle.*

## 4. Tester la résolution DNS entre namespaces

*Lancez un pod temporaire `busybox` dans le namespace `staging` pour résoudre le nom DNS `kubernetes.default` et vérifier la résolution inter-namespaces.*

> Le format DNS complet : `<service>.<namespace>.svc.cluster.local`

## 5. Voir toutes les ressources d'un namespace

*Affichez toutes les ressources du namespace `staging`.*

> Cliquez sur **Check** quand les namespaces staging et production existent et que le quota est appliqué.
