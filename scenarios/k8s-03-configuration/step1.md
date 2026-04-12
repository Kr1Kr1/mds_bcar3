# Étape 1 — ConfigMaps

## 1. Créer un ConfigMap

*Créez le fichier `/root/app-config.yaml` définissant un ConfigMap nommé `app-config` avec les données suivantes : clés simples `LOG_LEVEL: "info"`, `APP_ENV: "staging"`, `MAX_CONNECTIONS: "100"`, et un fichier `config.ini` contenant une section `[server]` (port 8080, debug false) et une section `[database]` (host postgres-service, port 5432).*

*Appliquez le manifest pour créer le ConfigMap.*

*Listez le ConfigMap `app-config`.*

*Décrivez le ConfigMap pour voir son contenu complet.*

## 2. Utiliser le ConfigMap comme variables d'environnement

*Créez le fichier `/root/pod-configmap.yaml` définissant un Pod nommé `app-pod` avec l'image `nginx:1.25`, utilisant `envFrom` pour injecter toutes les clés du ConfigMap `app-config` comme variables d'environnement, et une variable `MY_LOG_LEVEL` pointant spécifiquement sur la clé `LOG_LEVEL` du ConfigMap.*

*Appliquez le manifest pour créer le Pod.*

*Exécutez une commande dans le Pod `app-pod` pour afficher les variables d'environnement `LOG_LEVEL`, `APP_ENV` et `MAX_CONNECTIONS`.*

## 3. Monter le ConfigMap en volume

*Créez le fichier `/root/pod-configmap-vol.yaml` définissant un Pod nommé `app-pod-vol` avec l'image `nginx:1.25`, montant le ConfigMap `app-config` comme un volume dans le répertoire `/etc/app-config`.*

*Appliquez le manifest pour créer le Pod.*

*Listez le contenu du répertoire `/etc/app-config` dans le Pod `app-pod-vol`.*

*Affichez le contenu du fichier `/etc/app-config/config.ini` dans le Pod.*

> Cliquez sur **Check** quand les 2 pods utilisent le ConfigMap.
