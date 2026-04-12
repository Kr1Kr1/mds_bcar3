# Étape 3 — Réconciliation, réseau et vision d'ensemble

## Lancer le quiz

`bash /root/quiz_step3.sh`{{exec}}

---

## À retenir avant de répondre

**Cycle de vie d'un déploiement** (de `kubectl apply` au conteneur qui tourne)

```
kubectl apply → API Server (valide + stocke etcd)
             → Scheduler (choisit le node)
             → Kubelet (lance via Container Runtime)
             → CNI (attribue l'IP)
             → kube-proxy (met à jour iptables)
             → Controller Manager (surveille en continu)
```

**Réconciliation — le super-pouvoir de Kubernetes**

| État souhaité | État réel | Action |
|---|---|---|
| 3 replicas | 3 Running | ✅ Rien |
| 3 replicas | 2 Running | ⚠️ Crée 1 pod |
| 3 replicas | 0 Running | 🔴 Crée 3 pods |

→ La boucle tourne **en continu**, sans jamais s'arrêter

**Réseau Kubernetes — 3 règles d'or**
1. Chaque Pod a sa propre IP unique
2. Tous les Pods peuvent communiquer sans NAT
3. Les Services fournissent une IP stable

**CNI (Container Network Interface)**

| Plugin | Points forts |
|---|---|
| **Calico** | Network Policies avancées, production |
| **Flannel** | Simple, léger, test/dev |
| **Cilium** | eBPF, observabilité, performances |

---

Répondez aux 8 questions, puis cliquez sur **Check**.
