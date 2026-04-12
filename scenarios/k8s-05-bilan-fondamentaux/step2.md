# Étape 2 — Services, ConfigMaps, Secrets

## 1. Lancer le quiz

`bash /root/quiz_step2.sh`{{exec}}

---

## À retenir avant de répondre

**Services — types et usages**

| Type | Portée | Usage |
|---|---|---|
| ClusterIP | Interne cluster | Inter-services (BDD, cache) |
| NodePort | Port sur chaque nœud | Dev/test |
| LoadBalancer | IP publique cloud | Production cloud |
| ExternalName | CNAME vers externe | Migration progressive |
| Headless (None) | IPs directes des pods | StatefulSets, gRPC |

**ConfigMaps — mise à jour automatique ?**

| Méthode | Mise à jour auto ? |
|---|---|
| `env:` / `envFrom:` | ❌ Jamais |
| Volume monté (standard) | ✅ ~60 secondes |
| Volume avec `subPath` | ❌ Jamais |

**Secrets — points clés**

- base64 = **encodage**, pas chiffrement
- Pour chiffrer : activer `EncryptionConfiguration` sur l'API Server
- Limiter l'accès via **RBAC** (resourceNames pour un secret précis)
- En production : **External Secrets Operator**, **HashiCorp Vault**

---

Répondez aux 8 questions, puis cliquez sur **Check**.
