# Étape 1 — Control Plane : API Server, etcd, Scheduler, Controller Manager

## 0. S'identifier

`bash /root/set_pseudo.sh`{{exec}}

## 1. Lancer le quiz

`bash /root/quiz_step1.sh`{{exec}}

---

## À retenir avant de répondre

**Les 4+1 composants du Control Plane**

| Composant | Rôle |
|---|---|
| **kube-apiserver** | Point d'entrée unique — valide, authentifie, stocke dans etcd |
| **etcd** | Base de données distribuée (clé-valeur) — tout l'état du cluster |
| **kube-scheduler** | Choisit le nœud pour chaque pod (ne le lance pas) |
| **kube-controller-manager** | Boucle de réconciliation — état réel = état souhaité |
| **cloud-controller-manager** | Optionnel — intégration cloud (LB, routes, nodes cloud) |

**Règles d'architecture :**
- Seul l'**API Server** accède à **etcd** directement
- Tous les composants communiquent via l'**API Server** (jamais directement entre eux)
- Le **cloud-controller-manager** n'est présent que sur les clusters cloud (EKS, GKE, AKS)

**Cloud Controller — 3 contrôleurs :**
- Node Controller → métadonnées cloud des nœuds
- Route Controller → routes réseau dans le VPC
- Service Controller → crée les Load Balancers pour `type: LoadBalancer`

---

Répondez aux 9 questions, puis cliquez sur **Check**.
