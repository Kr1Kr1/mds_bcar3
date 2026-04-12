# Kubernetes — Administration du cluster

Bienvenue dans ce TP d'administration Kubernetes !

Ce scénario utilise un cluster **kubeadm** à 2 nœuds (1 control-plane + 1 worker).

## Objectifs

À la fin de ce TP, vous saurez :
- Inspecter les composants du control plane
- Sauvegarder etcd avec `etcdctl snapshot save`
- Vérifier l'intégrité d'un snapshot etcd
- Mettre un nœud en maintenance avec `drain` / `uncordon`

## Outil principal

```bash
kubectl <verbe> <ressource> [nom] [options]
ETCDCTL_API=3 etcdctl <commande> [options]
```

Tous les exercices sont à faire depuis le **nœud controlplane**.
