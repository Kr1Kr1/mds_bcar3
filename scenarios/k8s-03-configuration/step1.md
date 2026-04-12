# Étape 1 — ConfigMaps

## 1. Créer un ConfigMap

```bash
cat > /root/app-config.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  LOG_LEVEL: "info"
  APP_ENV: "staging"
  MAX_CONNECTIONS: "100"
  config.ini: |
    [server]
    port = 8080
    debug = false
    [database]
    host = postgres-service
    port = 5432
EOF
```{{exec}}

`kubectl apply -f /root/app-config.yaml`{{exec}}

`kubectl get configmap app-config`{{exec}}

`kubectl describe configmap app-config`{{exec}}

## 2. Utiliser le ConfigMap comme variables d'environnement

```bash
cat > /root/pod-configmap.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
    - name: app
      image: nginx:1.25
      envFrom:
        - configMapRef:
            name: app-config
      env:
        - name: MY_LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: LOG_LEVEL
EOF
```{{exec}}

`kubectl apply -f /root/pod-configmap.yaml`{{exec}}

`kubectl exec app-pod -- env | grep -E "LOG_LEVEL|APP_ENV|MAX_CONNECTIONS"`{{exec}}

## 3. Monter le ConfigMap en volume

```bash
cat > /root/pod-configmap-vol.yaml << 'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: app-pod-vol
spec:
  containers:
    - name: app
      image: nginx:1.25
      volumeMounts:
        - name: config-vol
          mountPath: /etc/app-config
  volumes:
    - name: config-vol
      configMap:
        name: app-config
EOF
```{{exec}}

`kubectl apply -f /root/pod-configmap-vol.yaml`{{exec}}

`kubectl exec app-pod-vol -- ls /etc/app-config`{{exec}}

`kubectl exec app-pod-vol -- cat /etc/app-config/config.ini`{{exec}}

> Cliquez sur **Check** quand les 2 pods utilisent le ConfigMap.
