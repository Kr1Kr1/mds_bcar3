# Étape 2 — Worker Nodes : Kubelet, Kube-proxy, Container Runtime

## Lancer le quiz

`bash /root/quiz_step2.sh`{{exec}}

---

## À retenir avant de répondre

**Les 3 composants d'un Worker Node**

| Composant | Rôle |
|---|---|
| **kubelet** | Agent local — écoute l'API Server, lance et surveille les pods via CRI |
| **kube-proxy** | Configure les règles iptables/IPVS pour le routage réseau des Services |
| **Container Runtime** | Exécute réellement les conteneurs (via l'interface CRI) |

**Points clés :**
- Le kubelet est **autonome** : si le control plane est injoignable temporairement, il continue de faire tourner les pods existants
- Le kubelet fonctionne en mode **pull** : il interroge régulièrement l'API Server (il ne reçoit pas d'ordres en push)
- Le kubelet gère les **probes** (liveness, readiness) et remonte l'état au control plane

**Container Runtime**

| Runtime | Status |
|---|---|
| **containerd** | ✓ Standard recommandé depuis K8s 1.24 |
| **CRI-O** | ✓ Recommandé (OpenShift) |
| **Docker Engine** | ❌ Supprimé depuis K8s 1.24 (dockershim supprimé) |

> Les images Docker **fonctionnent toujours** — seul le moteur change (format OCI compatible)

---

Répondez aux 8 questions, puis cliquez sur **Check**.
