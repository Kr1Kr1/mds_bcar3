# Kubernetes — Réseau et Stockage

Bienvenue dans ce TP sur le réseau et le stockage Kubernetes !

Ce scénario utilise un cluster **kubeadm** à 2 nœuds (1 control-plane + 1 worker).

## Objectifs

À la fin de ce TP, vous saurez :
- Appliquer des **NetworkPolicies** pour isoler des namespaces
- Créer un **Ingress** pour exposer plusieurs services HTTP
- Créer un **PersistentVolumeClaim** et vérifier la persistance des données

## Rappel

```bash
kubectl run test --image=nicolaka/netshoot --rm -it -- <commande>
kubectl get pvc              # voir le statut des volumes
kubectl describe ingress     # inspecter les règles de routage
```

Tous les exercices sont à faire depuis le **nœud controlplane**.
