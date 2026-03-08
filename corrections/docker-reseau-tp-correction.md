# Correction — Docker Réseau TP

---

## Étape 1 — Le réseau bridge par défaut

```bash
# 1. Lancer deux conteneurs (sans --network → bridge par défaut)
docker run -d --name ctn1 ubuntu sleep 3600
docker run -d --name ctn2 ubuntu sleep 3600

# 2. Inspecter le réseau bridge et trouver les IPs
docker network inspect bridge

# Récupérer l'IP de ctn1 uniquement
docker inspect ctn1 --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
# ex. : 172.17.0.2

# 3. Tester la connectivité depuis ctn2 vers ctn1
#    (ping n'est pas disponible dans ubuntu par défaut, on installe iputils-ping)
docker exec ctn2 bash -c "apt-get update -qq && apt-get install -y -qq iputils-ping"
docker exec ctn2 ping -c 3 172.17.0.2
```

> **Bridge par défaut vs bridge personnalisé** :
> - Sur le bridge **par défaut**, les conteneurs ne se voient que par **IP** — il n'y a pas de
>   résolution DNS par nom de conteneur.
> - Sur un bridge **personnalisé**, Docker fournit un serveur DNS embarqué : les conteneurs
>   se joignent directement par leur **nom** (`ping ctn1` fonctionne).

---

## Étape 2 — Bridge personnalisé et résolution DNS

```bash
# 1. Créer un réseau bridge personnalisé
docker network create monreseau

# 2. Lancer deux conteneurs sur ce réseau avec des noms explicites
docker run -d --name alpine1 --network monreseau alpine sleep 3600
docker run -d --name alpine2 --network monreseau alpine sleep 3600

# 3. Depuis alpine2, pinguer alpine1 par son nom
docker exec alpine2 ping -c 3 alpine1
# → PING alpine1 (172.18.0.2): 56 data bytes
# → 3 packets transmitted, 3 packets received

# Vérifier aussi dans l'autre sens
docker exec alpine1 ping -c 3 alpine2
```

> **Pourquoi ça fonctionne ?** Docker injecte un résolveur DNS (`127.0.0.11`) dans chaque
> conteneur d'un réseau personnalisé. Ce résolveur connaît tous les noms des conteneurs
> du réseau. Sur le bridge par défaut, ce mécanisme est absent.

---

## Étape 3 — Connexion à plusieurs réseaux

```bash
# 1. Créer un second réseau bridge personnalisé
docker network create reseau-b

# 2. Lancer un conteneur uniquement sur reseau-b
docker run -d --name alpine3 --network reseau-b alpine sleep 3600

# 3. Connecter alpine1 (déjà sur monreseau) à reseau-b — sans le recréer
docker network connect reseau-b alpine1

# 4. Vérifier qu'alpine1 voit les deux réseaux
docker inspect alpine1 --format '{{range $k,$v := .NetworkSettings.Networks}}{{$k}} {{end}}'
# → monreseau reseau-b

# Depuis alpine1 : joindre alpine2 (monreseau) et alpine3 (reseau-b)
docker exec alpine1 ping -c 2 alpine2   # → OK (monreseau)
docker exec alpine1 ping -c 2 alpine3   # → OK (reseau-b)

# Depuis alpine3 : alpine2 N'EST PAS joignable (réseaux différents)
docker exec alpine3 ping -c 2 alpine2   # → échec
```

> **Conclusion** : `docker network connect` attache un conteneur à un réseau supplémentaire
> **à chaud**, sans redémarrage. Le conteneur obtient une nouvelle interface réseau et une
> nouvelle IP sur ce réseau. Il peut ainsi servir de **passerelle applicative** entre deux
> réseaux isolés.

---

## Étape 4 — Port mapping avec nginx

```bash
# 1. Lancer nginx avec port manuel 8080 → 80
docker run -d --name nginx-manuel -p 8080:80 nginx

# 2. Vérifier que nginx répond
curl http://localhost:8080
# → <!DOCTYPE html> ... Welcome to nginx! ...

# 3. Lancer un second nginx avec port automatique (-P)
docker run -d --name nginx-auto -P nginx

# 4. Identifier le port attribué automatiquement
docker port nginx-auto
# → 80/tcp -> 0.0.0.0:32768  (le port hôte varie)

docker port nginx-auto 80
# → 0.0.0.0:32768

# Vérifier qu'il répond
PORT=$(docker port nginx-auto 80 | grep -oP '(?<=:)\d+')
curl http://localhost:$PORT
# → Welcome to nginx!
```

> **`-p` vs `-P`** :
> - `-p 8080:80` : mapping **explicite** — vous choisissez le port hôte.
> - `-P` : Docker choisit un port **éphémère** (32768+) pour chaque port déclaré
>   avec `EXPOSE` dans l'image.
> - `docker port <conteneur>` affiche les mappings actifs à tout moment.

---

## Étape 5 — Architecture 3-tiers : load balancing avec HAProxy

### Préparation

```bash
# 1. Créer le réseau dédié
docker network create web

# 2. Lancer web1 et web2 (nginx)
docker run -d --name web1 --network web nginx
docker run -d --name web2 --network web nginx

# 3. Personnaliser les pages d'accueil
docker exec web1 bash -c 'echo "<h1>Bonjour depuis web1</h1>" > /usr/share/nginx/html/index.html'
docker exec web2 bash -c 'echo "<h1>Bonjour depuis web2</h1>" > /usr/share/nginx/html/index.html'
```

### Configuration HAProxy

```bash
mkdir -p ~/haproxy-reseau
```

**`~/haproxy-reseau/haproxy.cfg`** :

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

### Lancement de HAProxy

```bash
# 4. Lancer myhaproxy sur le même réseau, port 80 exposé
docker run -d --name myhaproxy \
  --network web \
  -v ~/haproxy-reseau/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  -p 80:80 \
  haproxy
```

### Validation du round-robin

```bash
# 6. Plusieurs curl successifs — alternance web1 / web2
curl http://localhost   # → Bonjour depuis web1
curl http://localhost   # → Bonjour depuis web2
curl http://localhost   # → Bonjour depuis web1
```

> **Pourquoi la résolution DNS fonctionne dans la config HAProxy ?**
> Les noms `web1` et `web2` dans `haproxy.cfg` sont résolus par le DNS embarqué de Docker
> car tous les conteneurs partagent le même réseau **personnalisé** `web`.
> Si on avait utilisé le bridge par défaut, il aurait fallu mettre des IPs en dur.

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker network ls` | Lister les réseaux |
| `docker network create <nom>` | Créer un réseau bridge personnalisé |
| `docker network inspect <nom>` | Détails d'un réseau (conteneurs, subnet…) |
| `docker network connect <réseau> <conteneur>` | Connecter un conteneur à un réseau à chaud |
| `docker network disconnect <réseau> <conteneur>` | Déconnecter un conteneur d'un réseau |
| `docker run --network <nom>` | Attacher un conteneur à un réseau au démarrage |
| `docker run -p <hote>:<conteneur>` | Port mapping explicite |
| `docker run -P` | Port mapping automatique (ports `EXPOSE`) |
| `docker port <conteneur>` | Afficher les mappings de ports actifs |
| `docker inspect <ctn> --format '{{range .NetworkSettings.Networks}}…'` | Lire les infos réseau |
