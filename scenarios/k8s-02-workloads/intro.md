# Kubernetes — Workloads : Deployments et Services

Dans ce TP, vous allez gérer une application en production : scaling, mise à jour sans interruption, rollback, et exposition via un Service.

## Objectifs

À la fin de ce TP, vous saurez :
- Créer et gérer un Deployment avec plusieurs replicas
- Scaler une application horizontalement
- Effectuer un rolling update et un rollback
- Exposer l'application via un Service NodePort

## Rappel de la hiérarchie

```
Deployment → ReplicaSet → Pod Pod Pod
```
