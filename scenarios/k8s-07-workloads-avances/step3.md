# Étape 3 — Scheduling avancé : taints et tolerations

Contrôlez précisément où Kubernetes peut placer vos pods.

## 1. Ajouter un taint sur node01

*Ajoutez un taint `workload=gpu:NoSchedule` sur le nœud `node01`.*

*Décrivez le nœud `node01` et filtrez sur la ligne `Taints` pour vérifier que le taint est bien en place.*

> Le taint `workload=gpu:NoSchedule` empêche tout pod sans toleration d'être schedulé sur node01

## 2. Déployer un pod SANS toleration

*Créez le fichier `/root/pod-no-toleration.yaml` définissant un Pod simple nommé `app-sans-toleration` avec l'image `nginx:1.25`, sans aucune toleration.*

*Appliquez le manifest pour créer le Pod.*

*Affichez les informations détaillées du Pod `app-sans-toleration` pour voir sur quel nœud il est (ou non) schedulé.*

> Le pod reste en `Pending` — aucun nœud éligible : controlplane a son taint, node01 a le nouveau taint

## 3. Inspecter pourquoi le pod est Pending

*Décrivez le Pod `app-sans-toleration` et filtrez sur la section `Events` et les 5 lignes suivantes pour lire le message d'erreur de scheduling.*

> Vous verrez : `0/2 nodes are available: ... had taint that the pod didn't tolerate`

## 4. Déployer un pod AVEC toleration

*Créez le fichier `/root/pod-with-toleration.yaml` définissant un Pod nommé `app-avec-toleration` avec l'image `nginx:1.25` et une toleration pour le taint `workload=gpu:NoSchedule` (operator: Equal).*

*Appliquez le manifest pour créer le Pod.*

*Affichez les informations détaillées du Pod `app-avec-toleration` pour confirmer qu'il est schedulé sur `node01`.*

> Ce pod peut être schedulé sur node01

## 5. Nettoyer le taint

*Supprimez le taint `workload=gpu:NoSchedule` du nœud `node01` (en ajoutant un `-` en suffixe).*

> Le `-` en suffixe supprime le taint

## Validation

> Cliquez sur **Check** quand le pod `app-avec-toleration` est en état `Running`.
