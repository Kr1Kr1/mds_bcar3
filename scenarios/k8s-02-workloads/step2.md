# Étape 2 — Rolling update et rollback

## 1. Vérifier l'image actuelle

*Affichez l'image utilisée par le premier pod du Deployment `webapp` via une requête jsonpath.*

## 2. Mettre à jour l'image (rolling update)

*Mettez à jour l'image du conteneur `nginx` dans le Deployment `webapp` vers `nginx:1.25`.*

*Surveillez la progression du rollout jusqu'à sa complétion.*

> Observez : K8s remplace les pods progressivement sans downtime

*Listez les pods portant le label `app=webapp` pour voir les nouveaux pods.*

*Listez les ReplicaSets pour observer l'ancien et le nouveau.*

> Deux ReplicaSets visibles : l'ancien (0 replicas) et le nouveau (3 replicas)

## 3. Voir l'historique des révisions

*Affichez l'historique des révisions du Deployment `webapp`.*

## 4. Simuler une mise à jour avec une mauvaise image

*Mettez à jour l'image du conteneur `nginx` vers `nginx:version-inexistante` (image inexistante).*

*Surveillez l'état du rollout (il va bloquer).*

> Ctrl+C — le déploiement est bloqué (ImagePullBackOff)

*Listez les pods pour constater l'état ImagePullBackOff.*

## 5. Rollback !

*Annulez le dernier déploiement (rollback vers la révision précédente).*

*Attendez que le rollout de retour soit terminé.*

*Vérifiez que tous les pods sont de nouveau Running avec la bonne image.*

> Cliquez sur **Check** quand tous les pods sont Running avec l'image nginx:1.25.
