# Étape 2 — Rolling update et rollback

## 1. Vérifier l'image actuelle

`kubectl get pods -l app=webapp -o jsonpath='{.items[0].spec.containers[0].image}'`{{exec}}

## 2. Mettre à jour l'image (rolling update)

`kubectl set image deployment/webapp nginx=nginx:1.25`{{exec}}

`kubectl rollout status deployment/webapp`{{exec}}

> Observez : K8s remplace les pods progressivement sans downtime

`kubectl get pods -l app=webapp`{{exec}}

`kubectl get replicaset`{{exec}}

> Deux ReplicaSets visibles : l'ancien (0 replicas) et le nouveau (3 replicas)

## 3. Voir l'historique des révisions

`kubectl rollout history deployment/webapp`{{exec}}

## 4. Simuler une mise à jour avec une mauvaise image

`kubectl set image deployment/webapp nginx=nginx:version-inexistante`{{exec}}

`kubectl rollout status deployment/webapp`{{exec}}

> Ctrl+C — le déploiement est bloqué (ImagePullBackOff)

`kubectl get pods`{{exec}}

## 5. Rollback !

`kubectl rollout undo deployment/webapp`{{exec}}

`kubectl rollout status deployment/webapp`{{exec}}

`kubectl get pods -l app=webapp`{{exec}}

> Cliquez sur **Check** quand tous les pods sont Running avec l'image nginx:1.25.
