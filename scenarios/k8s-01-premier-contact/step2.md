# Étape 2 — Premier Pod

Créez votre premier Pod depuis un manifest YAML.

## 1. Créer le manifest

*Créez le fichier `/root/premier-pod.yaml` définissant un Pod nommé `nginx-pod` avec les caractéristiques suivantes : image `nginx:1.25`, labels `app: nginx` et `env: lab`, port 80, requests mémoire 64Mi et CPU 100m, limits mémoire 128Mi et CPU 200m.*

## 2. Appliquer le manifest

*Appliquez le manifest pour créer le Pod dans le cluster.*

## 3. Vérifier le statut

*Listez les pods du namespace courant.*

*Affichez les détails du pod `nginx-pod` avec ses informations étendues (nœud, IP, etc.).*

> Attendez que le pod soit en état `Running` (téléchargement de l'image peut prendre quelques secondes)

## 4. Inspecter les labels

*Listez les pods en affichant leurs labels.*

*Filtrez les pods portant le label `app=nginx`.*

> Cliquez sur **Check** quand `nginx-pod` est en état `Running`.
