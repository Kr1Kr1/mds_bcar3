# Correction — Docker Compose TP

---

## Étape 1 — Premier docker-compose.yml

```bash
mkdir -p ~/tp-compose
cd ~/tp-compose
```

**`~/tp-compose/docker-compose.yml`** :

```yaml
services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
```

```bash
# Lancer la stack en arrière-plan
docker compose up -d

# Vérifier l'état
docker compose ps

# Tester nginx
curl http://localhost:8080
# → <!DOCTYPE html> ... Welcome to nginx! ...

# Voir les logs
docker compose logs nginx
```

> **Pourquoi Compose ?** Le fichier `docker-compose.yml` est **déclaratif** et **versionnable** :
> l'état souhaité est décrit une fois, reproductible par n'importe qui avec `docker compose up`.
> Avec `docker run`, la commande doit être retapée ou scriptée à la main.

---

## Étape 2 — Stack multi-services

**`~/tp-compose/docker-compose.yml`** mis à jour :

```yaml
services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"

  redis:
    image: redis:alpine
```

```bash
# Relancer (Compose détecte les changements et met à jour)
docker compose up -d

# Vérifier que les deux services tournent
docker compose ps
# NAME                  IMAGE          STATUS    PORTS
# tp-compose-nginx-1    nginx:latest   Up        0.0.0.0:8080->80/tcp
# tp-compose-redis-1    redis:alpine   Up        6379/tcp

# Inspecter le réseau créé automatiquement (nommé <projet>_default)
docker network ls | grep tp-compose
# tp-compose_default    bridge    local

docker network inspect tp-compose_default

# Tester la résolution DNS depuis nginx vers redis
docker compose exec nginx sh -c "apt-get update -qq && apt-get install -y -qq iputils-ping && ping -c 3 redis"
# → PING redis ... 64 bytes from ...
# Les services se joignent par leur nom de service
```

> **Réseau automatique** : Compose crée un réseau `<projet>_default` et y connecte tous les services.
> Les conteneurs se résolvent par leur **nom de service** (pas de `--link` nécessaire).

---

## Étape 3 — Variables d'environnement et fichier .env

**`~/tp-compose/.env`** :

```env
MYSQL_ROOT_PASSWORD=SuperSecret42
MYSQL_DATABASE=monapp
MYSQL_USER=appuser
MYSQL_PASSWORD=AppPass123
```

**`~/tp-compose/docker-compose.yml`** mis à jour :

```yaml
services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"

  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
```

```bash
# Relancer
docker compose up -d

# Vérifier que les variables sont bien injectées
docker compose exec mysql env | grep MYSQL_
# MYSQL_ROOT_PASSWORD=SuperSecret42
# MYSQL_DATABASE=monapp
# ...

# Attendre que MySQL soit prêt (peut prendre ~20s)
docker compose logs -f mysql
# → [Server] /usr/sbin/mysqld: ready for connections.

# Se connecter à MySQL pour vérifier
docker compose exec mysql mysql -u root -pSuperSecret42 -e "SHOW DATABASES;"
# → monapp apparaît dans la liste
```

> **Bonne pratique** : ajouter `.env` au `.gitignore`. Committer un `.env.example` avec
> les noms de variables mais des valeurs factices pour documenter ce qui est attendu.

```bash
# .gitignore
echo ".env" >> .gitignore

# .env.example à committer
cat > .env.example <<'EOF'
MYSQL_ROOT_PASSWORD=changeme
MYSQL_DATABASE=myapp
MYSQL_USER=appuser
MYSQL_PASSWORD=changeme
EOF
```

---

## Étape 4 — Persistance des données avec les volumes

**`~/tp-compose/docker-compose.yml`** mis à jour :

```yaml
services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"

  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

```bash
# Relancer avec le volume
docker compose up -d

# Créer une base de données de test pour vérifier la persistance
docker compose exec mysql mysql -u root -pSuperSecret42 -e "
  CREATE DATABASE IF NOT EXISTS testpersist;
  USE testpersist;
  CREATE TABLE users (id INT, name VARCHAR(50));
  INSERT INTO users VALUES (1, 'Alice');
"

# Vérifier que les données existent
docker compose exec mysql mysql -u root -pSuperSecret42 -e "SELECT * FROM testpersist.users;"
# → 1  Alice

# Arrêter et supprimer les conteneurs (SANS -v pour préserver les volumes)
docker compose down

# Vérifier que le volume nommé est bien toujours là
docker volume ls | grep db_data
# → tp-compose_db_data    local

# Relancer
docker compose up -d

# Les données sont toujours présentes
docker compose exec mysql mysql -u root -pSuperSecret42 -e "SELECT * FROM testpersist.users;"
# → 1  Alice  ← persistance confirmée
```

```bash
# Avec -v : supprime aussi les volumes (destructif !)
docker compose down -v
docker volume ls | grep db_data
# → (vide — le volume a été supprimé)
```

> **`down` vs `down -v`** :
> - `docker compose down` : supprime conteneurs + réseaux, **conserve** les volumes nommés
> - `docker compose down -v` : supprime conteneurs + réseaux + **volumes nommés** → perte de données
>
> **Où sont les données ?** `docker volume inspect tp-compose_db_data` → `Mountpoint: /var/lib/docker/volumes/tp-compose_db_data/_data`

---

## Étape 5 — Scaling et commandes avancées

Pour scaler un service, celui-ci **ne doit pas avoir de port fixe côté hôte**
(deux instances ne peuvent pas écouter sur le même port hôte).

**`~/tp-compose/docker-compose.yml`** adapté pour le scaling :

```yaml
services:
  web:
    image: nginx:latest
    expose:
      - "80"        # expose entre services, sans fixer de port hôte

  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - db_data:/var/lib/mysql

volumes:
  db_data:
```

```bash
# Lancer avec 3 instances du service web
docker compose up -d --scale web=3

# Vérifier avec docker compose ps
docker compose ps
# NAME              IMAGE          STATUS    PORTS
# ...-web-1         nginx:latest   Up        80/tcp
# ...-web-2         nginx:latest   Up        80/tcp
# ...-web-3         nginx:latest   Up        80/tcp
# ...-mysql-1       mysql:8        Up        3306/tcp

# Logs de toute la stack (suivre en temps réel)
docker compose logs -f

# Logs d'un seul service
docker compose logs -f web

# Logs des N dernières lignes
docker compose logs --tail=20 web

# Exécuter une commande dans un conteneur spécifique
docker compose exec --index=1 web nginx -v
# nginx version: nginx/...

docker compose exec --index=2 web sh -c "hostname"

# Voir les processus dans les conteneurs
docker compose top

# Réduire le scaling sans tout arrêter
docker compose up -d --scale web=1

# Arrêter sans supprimer les conteneurs
docker compose stop

# Arrêter et supprimer conteneurs + réseaux + volumes
docker compose down -v
```

> **Problème de port avec le scaling** : si on avait `ports: - "8080:80"`, Docker ne peut pas
> démarrer 2 instances car le port 8080 de l'hôte ne peut être occupé que par un seul processus.
> La solution : utiliser `expose:` (réseau interne uniquement) et placer un reverse-proxy
> (nginx, Traefik, HAProxy) en frontal pour distribuer le trafic.

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker compose up -d` | Lancer la stack en arrière-plan |
| `docker compose up -d --scale web=3` | Lancer en scalant un service à N instances |
| `docker compose down` | Arrêter et supprimer conteneurs + réseaux |
| `docker compose down -v` | Idem + supprimer les volumes nommés |
| `docker compose ps` | État de tous les services |
| `docker compose logs -f [service]` | Logs en temps réel (optionnellement filtrés) |
| `docker compose exec <service> <cmd>` | Exécuter une commande dans un conteneur |
| `docker compose exec --index=N <svc> <cmd>` | Cibler une instance précise (scaling) |
| `docker compose stop` | Arrêter sans supprimer les conteneurs |
| `docker compose start` | Redémarrer des conteneurs arrêtés |
| `docker compose restart [service]` | Redémarrer un service |
| `docker compose pull` | Mettre à jour les images depuis le registry |
| `docker compose build` | Rebuilder les images locales |
| `docker compose top` | Processus dans les conteneurs |
| `docker compose config` | Afficher la config Compose résolue (avec substitution .env) |
