# Étape 3 — Namespaces et ResourceQuotas

## 1. Créer des namespaces d'environnement

`kubectl create namespace staging`{{exec}}

`kubectl create namespace production`{{exec}}

`kubectl get namespaces`{{exec}}

## 2. Déployer dans des namespaces séparés

```bash
cat > /root/deploy-staging.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
  namespace: staging
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          resources:
            requests:
              cpu: "50m"
              memory: "32Mi"
EOF
```{{exec}}

`kubectl apply -f /root/deploy-staging.yaml`{{exec}}

`kubectl get pods -n staging`{{exec}}

`kubectl get pods -n production`{{exec}}

> Les namespaces sont isolés — on ne voit pas les pods entre eux avec `kubectl get pods`

## 3. Appliquer un ResourceQuota

```bash
cat > /root/quota-staging.yaml << 'EOF'
apiVersion: v1
kind: ResourceQuota
metadata:
  name: quota-staging
  namespace: staging
spec:
  hard:
    pods: "5"
    requests.cpu: "500m"
    requests.memory: "512Mi"
    limits.cpu: "1"
    limits.memory: "1Gi"
EOF
```{{exec}}

`kubectl apply -f /root/quota-staging.yaml`{{exec}}

`kubectl describe resourcequota quota-staging -n staging`{{exec}}

## 4. Tester la résolution DNS entre namespaces

`kubectl run dns-test --image=busybox --rm -it -n staging --restart=Never -- nslookup kubernetes.default`{{exec}}

> Le format DNS complet : `<service>.<namespace>.svc.cluster.local`

## 5. Voir toutes les ressources d'un namespace

`kubectl get all -n staging`{{exec}}

> Cliquez sur **Check** quand les namespaces staging et production existent et que le quota est appliqué.
