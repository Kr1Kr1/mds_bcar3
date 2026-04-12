# Étape 2 — Secrets

## 1. Créer un Secret

```bash
cat > /root/db-secret.yaml << 'EOF'
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
type: Opaque
stringData:
  DB_USER: "admin"
  DB_PASSWORD: "mon-super-mdp-secret"
  DB_HOST: "postgres.prod.svc.cluster.local"
EOF
```{{exec}}

`kubectl apply -f /root/db-secret.yaml`{{exec}}

`kubectl get secret db-secret`{{exec}}

## 2. Voir le Secret (encodé base64)

`kubectl get secret db-secret -o yaml`{{exec}}

> Les valeurs sont encodées en base64, pas chiffrées

`kubectl get secret db-secret -o jsonpath='{.data.DB_PASSWORD}' | base64 -d`{{exec}}

## 3. Utiliser le Secret dans un Pod

```bash
cat > /root/pod-secret.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: app-avec-secret
spec:
  containers:
    - name: app
      image: nginx:1.25
      env:
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_PASSWORD
        - name: DB_USER
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: DB_USER
EOF
```{{exec}}

`kubectl apply -f /root/pod-secret.yaml`{{exec}}

`kubectl exec app-avec-secret -- env | grep DB_`{{exec}}

> Le secret est disponible comme variable d'environnement, sans jamais être visible dans le YAML du pod

## 4. Créer un Secret depuis la ligne de commande

`kubectl create secret generic api-keys --from-literal=API_KEY=abc123xyz --from-literal=API_SECRET=supersecret`{{exec}}

`kubectl get secrets`{{exec}}

> Cliquez sur **Check** quand `app-avec-secret` est Running.
