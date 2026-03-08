# Correction — Docker Volumes TP

---

## Étape 1 — Volumes nommés : création et persistance

### Partie A — Création et différence image / volume

```bash
# 1. Créer le volume
docker volume create vol1

# 2. Lister les volumes
docker volume ls

# 3. Lancer un conteneur ubuntu avec vol1 monté
docker run -it --name ctn1 -v vol1:/data ubuntu bash

# 4. Dans le conteneur : créer un fichier
echo "hello depuis vol1" > /data/fichier1.txt
exit

# 5. Créer une image depuis ce conteneur
docker commit ctn1 monimage

# 6. Lancer un conteneur depuis la nouvelle image
docker run --rm -it monimage bash
ls /data    # → /data est VIDE
exit
```

> **Conclusion** : `docker commit` capture les layers du système de fichiers de l'image,
> mais **pas** le contenu des volumes. Le fichier `fichier1.txt` est dans `vol1`,
> pas dans `monimage`.

---

### Partie B — Persistance et partage

```bash
# 7. Inspecter vol1 (noter le Mountpoint)
docker volume inspect vol1
# "Mountpoint": "/var/lib/docker/volumes/vol1/_data"

# 8. Supprimer ctn1 (pas le volume)
docker rm ctn1

# 9. Nouveau conteneur : fichier1.txt est toujours là
docker run -it --name ctn2 -v vol1:/data ubuntu bash
ls /data          # → fichier1.txt
cat /data/fichier1.txt  # → hello depuis vol1
# Laisser ce terminal ouvert (ou passer en arrière-plan avec -d)
```

Pour le partage simultané, lancer `ctn2` en arrière-plan :

```bash
# Option : lancer ctn2 en daemon et utiliser exec
docker run -d --name ctn2 -v vol1:/data ubuntu sleep 3600

# Lancer ctn3 sur le même volume
docker run -d --name ctn3 -v vol1:/data ubuntu sleep 3600

# Depuis ctn3 : créer un second fichier
docker exec ctn3 bash -c "echo 'depuis ctn3' > /data/fichier2.txt"

# Depuis ctn2 : vérifier que fichier2.txt est visible
docker exec ctn2 ls /data
# → fichier1.txt  fichier2.txt
docker exec ctn2 cat /data/fichier2.txt
# → depuis ctn3
```

> **Conclusion** : plusieurs conteneurs peuvent monter le même volume simultanément
> et voient immédiatement les modifications des autres.

---

## Étape 2 — Cycle de vie : suppression des volumes

```bash
# Tentative de suppression avec conteneurs actifs → erreur attendue
docker volume rm vol1
# Error: volume is in use - [ctn2, ctn3]

# Arrêter et supprimer les conteneurs
docker stop ctn2 ctn3
docker rm ctn2 ctn3

# Supprimer le volume
docker volume rm vol1

# Vérifier
docker volume ls   # vol1 n'apparaît plus
```

### Pour aller plus loin — volumes orphelins

```bash
# Créer un volume implicitement via -v
docker run --rm -v vol_temp:/tmp/data ubuntu echo "test"
# vol_temp a été créé automatiquement

docker volume ls    # vol_temp apparaît

# Supprimer avec prune
docker volume prune
# Removes all local volumes not used by at least one container.
# Are you sure you want to continue? [y/N] y
```

> **Différence conteneur / volume** : `docker rm` supprime le conteneur (processus + layers
> inscriptibles), mais **jamais** ses volumes. Il faut `docker volume rm` ou `docker rm -v`
> pour supprimer le volume en même temps que le conteneur.

---

## Étape 3 — Bind mounts : monter un dossier hôte

### Partie A — Fichiers statiques nginx

```bash
# 1. Préparer le dossier hôte
mkdir -p ~/www
echo "<h1>Ma page perso</h1>" > ~/www/index.html

# 2. Lancer nginx avec bind mount
docker run -d --name web-static \
  -v ~/www:/usr/share/nginx/html:ro \
  -p 8080:80 \
  nginx

# 3. Tester
curl http://localhost:8080
# → <h1>Ma page perso</h1>

# 4. Modifier le fichier SANS redémarrer le conteneur
echo "<h1>Page modifiée à chaud !</h1>" > ~/www/index.html

# 5. Re-tester immédiatement
curl http://localhost:8080
# → <h1>Page modifiée à chaud !</h1>
```

> **Conclusion** : avec un bind mount, toute modification côté hôte est **immédiatement**
> visible dans le conteneur, sans redémarrage. Avec `COPY` dans un Dockerfile,
> il faut rebuilder l'image.

---

### Partie B — Capture des logs nginx

```bash
# 6. Préparer le dossier logs
mkdir -p ~/nginx-logs

# 7. Lancer nginx avec bind mount sur les logs
docker run -d --name web-logs \
  -v ~/nginx-logs:/var/log/nginx \
  -p 8081:80 \
  nginx

# 8. Générer des requêtes
curl http://localhost:8081
curl http://localhost:8081/inexistant

# 9. Vérifier les logs sur l'hôte
ls ~/nginx-logs
# → access.log  error.log
cat ~/nginx-logs/access.log
# → 172.17.0.1 - - [08/Mar/2026:...] "GET / HTTP/1.1" 200 ...
```

---

## Étape 4 — Instruction `VOLUME` dans un Dockerfile

```bash
mkdir -p ~/vol-dockerfile
```

**`~/vol-dockerfile/Dockerfile`** :

```dockerfile
FROM ubuntu
RUN mkdir -p /appdata && echo "fichier créé au build" > /appdata/build.txt
VOLUME ["/appdata"]
CMD ["sleep", "infinity"]
```

```bash
# Build
docker build -t monapp ~/vol-dockerfile

# Lancer le conteneur
docker run -d --name app1 monapp

# Trouver le Mountpoint du volume automatique
docker inspect app1 --format '{{json .Mounts}}' | python3 -m json.tool
# ou
docker inspect app1 -f '{{range .Mounts}}{{.Source}}{{end}}'
# → /var/lib/docker/volumes/<hash>/_data

MOUNTPOINT=$(docker inspect app1 -f '{{range .Mounts}}{{.Source}}{{end}}')

# Vérifier le contenu du Mountpoint sur l'hôte
ls "$MOUNTPOINT"
# → build.txt   ← le fichier RUN est copié dans le volume au premier run

cat "$MOUNTPOINT/build.txt"
# → fichier créé au build

# Créer un fichier depuis le conteneur
docker exec app1 bash -c "echo 'depuis le conteneur' > /appdata/runtime.txt"

# Visible sur l'hôte
ls "$MOUNTPOINT"
# → build.txt  runtime.txt
```

> **Remarque sur `VOLUME` + `RUN`** : si un `RUN` écrit dans le répertoire *avant*
> l'instruction `VOLUME`, Docker copie ce contenu dans le volume lors du premier `docker run`
> (comportement "seed"). Si le `RUN` est *après* `VOLUME`, les fichiers créés sont perdus
> (le montage écrase le répertoire).

> **VOLUME vs -v** : `VOLUME` garantit l'externalisation sans que l'opérateur ait à y penser,
> mais crée un volume **anonyme** (hash). Préférez `-v nom:/chemin` pour nommer et réutiliser.

---

## Étape 5 — HAProxy avec bind mounts

### Préparation des fichiers de configuration

```bash
mkdir -p ~/haproxy-tp/web1 ~/haproxy-tp/web2

echo "<h1>Bonjour depuis web1</h1>" > ~/haproxy-tp/web1/index.html
echo "<h1>Bonjour depuis web2</h1>" > ~/haproxy-tp/web2/index.html
```

**`~/haproxy-tp/haproxy.cfg`** :

```
global
  daemon

defaults
  mode http
  timeout connect 5s
  timeout client  30s
  timeout server  30s

frontend http_front
  bind *:80
  default_backend web_back

backend web_back
  balance roundrobin
  server web1 web1:80 check
  server web2 web2:80 check
```

### Lancement de l'architecture

```bash
# Réseau dédié
docker network create webnet

# web1
docker run -d --name web1 \
  --network webnet \
  -v ~/haproxy-tp/web1:/usr/share/nginx/html:ro \
  nginx

# web2
docker run -d --name web2 \
  --network webnet \
  -v ~/haproxy-tp/web2:/usr/share/nginx/html:ro \
  nginx

# myhaproxy
docker run -d --name myhaproxy \
  --network webnet \
  -v ~/haproxy-tp/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  -p 80:80 \
  haproxy
```

### Validation — round-robin

```bash
curl http://localhost    # → Bonjour depuis web1
curl http://localhost    # → Bonjour depuis web2
curl http://localhost    # → Bonjour depuis web1
```

### Modification à chaud sans redémarrer

```bash
echo "<h1>web1 — version 2</h1>" > ~/haproxy-tp/web1/index.html
curl http://localhost    # alterne : → web1 — version 2  /  web2 inchangé
```

> **Avantage vs `docker exec`** : la configuration vit sur l'hôte, versionnée dans Git,
> modifiable par n'importe quel outil. Les conteneurs sont **stateless** et recréables
> à l'identique à tout moment.

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker volume create <nom>` | Créer un volume nommé |
| `docker volume ls` | Lister les volumes |
| `docker volume inspect <nom>` | Détails + Mountpoint |
| `docker volume rm <nom>` | Supprimer un volume (si non utilisé) |
| `docker volume prune` | Supprimer tous les volumes orphelins |
| `docker run -v nom:/chemin` | Monter un volume nommé |
| `docker run -v /abs/hote:/chemin` | Bind mount |
| `docker run -v /abs/hote:/chemin:ro` | Bind mount en lecture seule |
| `docker inspect <ctn> -f '{{json .Mounts}}'` | Voir les montages d'un conteneur |
| `VOLUME ["/chemin"]` dans Dockerfile | Déclarer un volume anonyme automatique |
