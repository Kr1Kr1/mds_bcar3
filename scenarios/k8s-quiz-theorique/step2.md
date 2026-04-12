# Étape 2 — Architecture Kubernetes

Ces questions portent sur l'**architecture d'un cluster K8s** et le rôle de chaque composant.

## Lancer le quiz

`bash /root/quiz_step2.sh`{{exec}}

---

## À retenir avant de répondre

**Control Plane**

| Composant | Rôle |
|---|---|
| **kube-apiserver** | Point d'entrée unique — expose l'API REST, authentifie toutes les requêtes |
| **etcd** | Base de données distribuée — stocke l'état complet du cluster |
| **kube-scheduler** | Choisit le nœud pour chaque pod (CPU, mémoire, affinités) |
| **kube-controller-manager** | Boucle de contrôle — état réel = état désiré |

**Worker Nodes**

| Composant | Rôle |
|---|---|
| **kubelet** | Agent — démarre les pods, communique avec l'API server |
| **kube-proxy** | Règles réseau pour exposer les services (iptables/ipvs) |
| **containerd** | Runtime — exécute les conteneurs |

**Principe clé** : tout passe par l'**API server** — les composants ne se parlent jamais directement

**Manifest YAML** : 4 champs obligatoires — `apiVersion`, `kind`, `metadata`, `spec`

---

Quand vous avez répondu aux 8 questions, cliquez sur **Check**.
