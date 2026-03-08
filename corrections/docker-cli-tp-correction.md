# Correction — Docker CLI TP

---

## Étape 1 — Installation et premier contact

```bash
# 1. Démarrer le démon Docker
service docker start
# ou sur un système systemd :
# systemctl start docker

# 2. Vérifier la version
docker version

# 3. Afficher les informations globales
docker info
```

> **Rappel** : `docker version` affiche les versions client ET serveur (démon).
> `docker info` donne l'état global : nombre de conteneurs, images, drivers réseau et stockage, etc.
> Si le démon ne tourne pas, `docker version` affiche une erreur côté *Server*.

---

## Étape 2 — Images et premiers conteneurs

```bash
# 1. Télécharger l'image ubuntu
docker pull ubuntu

# 2. Lister les images présentes localement
docker images
# ou
docker image ls

# 3. Lancer un conteneur et exécuter ps -ef à l'intérieur
docker run ubuntu ps -ef

# 4. Exécuter ps -ef depuis l'extérieur sur un conteneur en cours d'exécution
#    (il faut d'abord un conteneur qui tourne en arrière-plan)
docker run -d ubuntu sleep 3600
docker exec <ID> ps -ef

# 5. Lister les conteneurs EN COURS D'EXÉCUTION uniquement
docker ps

# 6. Lister TOUS les conteneurs (y compris arrêtés)
docker ps -a
```

> **Différence clé** : `docker run ubuntu ps -ef` crée un conteneur, exécute `ps -ef` puis
> s'arrête immédiatement. Pour `docker exec`, le conteneur doit être en cours d'exécution.

---

## Étape 3 — Mode interactif et exec

```bash
# 1. Créer un conteneur ubuntu avec terminal interactif
docker run -it ubuntu bash

# 2. À l'intérieur : créer un fichier puis sortir
echo "bonjour" > /tmp/test.txt
ls /tmp/test.txt
exit

# 3. Relancer exactement la même commande
docker run -it ubuntu bash
ls /tmp/test.txt
# → ls: cannot access '/tmp/test.txt': No such file or directory
```

> **Conclusion** : chaque `docker run` crée un **nouveau** conteneur vierge. Le fichier
> créé dans le conteneur précédent n'existe plus — il a disparu avec le conteneur.
> Les conteneurs sont éphémères par défaut.

```bash
# 4. Lancer un conteneur ubuntu avec bash en arrière-plan
docker run -d -it --name myubuntu ubuntu bash

# 5. Depuis l'hôte : ouvrir une nouvelle instance de bash dans ce conteneur
docker exec -it myubuntu bash

# 6. Lister les processus à l'intérieur (observer les PPID)
ps -ef
# PID 1  → bash (processus principal, lancé par docker run)
# PID N  → bash (processus fils, lancé par docker exec) — son PPID est 0/1
# PID N+1→ ps -ef

# 7. Se détacher sans arrêter le conteneur
# Raccourci clavier : Ctrl + P, Ctrl + Q
```

> **`docker attach` vs `docker exec`** :
> - `docker attach` rejoint le processus PID 1 du conteneur. Quitter avec `exit` **arrête** le conteneur.
> - `docker exec` crée un **nouveau processus** dans le conteneur. Le quitter ne l'arrête pas.
> - Pour se détacher proprement d'un `attach` : `Ctrl+P Ctrl+Q`.

---

## Étape 4 — Mode détaché et logs

```bash
# 1. Lancer rockylinux en mode détaché avec ping
docker run -d --name pingtest rockylinux/rockylinux ping 127.0.0.1 -c 60
# Alternative si image lente :
docker run -d --name pingtest ubuntu bash -c "for i in \$(seq 60); do echo tick \$i; sleep 1; done"

# 2. Lister les conteneurs — observer l'état et le temps de fonctionnement
docker ps

# 3. Attendre quelques secondes puis relister
# → après 60 secondes, le conteneur a terminé sa commande et son état passe à "Exited"
docker ps -a

# 4. Lancer un nouveau conteneur en arrière-plan (avec logs)
docker run -d --name logtest ubuntu bash -c "while true; do echo \$(date); sleep 2; done"

# 5. Récupérer l'ID et consulter les logs
docker ps   # noter l'ID
docker logs logtest
# ou avec l'ID :
docker logs <ID>

# 6. Logs en flux continu
docker logs -f logtest

# 7. Flux continu — 10 dernières lignes seulement
docker logs -f --tail 10 logtest
```

> **`-d` (detached)** : le terminal est libéré immédiatement, le conteneur tourne en arrière-plan.
> **`docker logs`** : récupère la sortie standard (stdout/stderr) du processus principal.
> **`-f`** (follow) : équivalent de `tail -f`, s'arrête avec `Ctrl+C` sans tuer le conteneur.

---

## Étape 5 — Inspect, stop/start et nettoyage

### Cycle de vie

```bash
# 1. Lancer un conteneur en arrière-plan
docker run -d --name myapp ubuntu sleep 3600

# 2. Arrêter le conteneur
docker stop myapp

# 3. Redémarrer sans recréer
docker start myapp
```

### Inspect

```bash
# 4. Inspecter un conteneur (sortie JSON complète)
docker inspect myapp

# 5. Afficher uniquement l'adresse IP
docker inspect myapp --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'

# 6. Afficher toutes les informations réseau
docker inspect myapp --format '{{json .NetworkSettings.Networks}}'
# Pour une lecture plus lisible :
docker inspect myapp --format '{{json .NetworkSettings.Networks}}' | python3 -m json.tool
```

### Nettoyage

```bash
# 7. Lister uniquement les conteneurs arrêtés
docker ps -a --filter "status=exited"

# 8. Supprimer un conteneur arrêté individuellement
docker rm <NOM_OU_ID>

# 9. Supprimer TOUS les conteneurs arrêtés en une seule commande
docker container prune
# Répond "y" à la confirmation

# Alternative plus ancienne :
docker rm $(docker ps -a -q --filter "status=exited")
```

> **`docker stop` vs `docker rm`** :
> - `docker stop` envoie SIGTERM au processus principal puis SIGKILL après 10 s — le conteneur
>   passe en état *Exited* mais reste présent dans `docker ps -a`.
> - `docker rm` supprime définitivement le conteneur (pas l'image).
> - `docker start` redémarre un conteneur *Exited* sans le recréer : il conserve son nom, son ID
>   et ses éventuels volumes.

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker version` | Version client + serveur |
| `docker info` | État global du démon |
| `docker pull <image>` | Télécharger une image |
| `docker images` | Lister les images locales |
| `docker run <image> <cmd>` | Créer et démarrer un conteneur |
| `docker run -it` | Mode interactif (TTY + stdin) |
| `docker run -d` | Mode détaché (arrière-plan) |
| `docker run --name <nom>` | Nommer le conteneur |
| `docker ps` | Conteneurs en cours d'exécution |
| `docker ps -a` | Tous les conteneurs |
| `docker ps -a --filter "status=exited"` | Conteneurs arrêtés |
| `docker exec -it <id> bash` | Ouvrir un shell dans un conteneur actif |
| `docker logs <id>` | Afficher les logs |
| `docker logs -f --tail N <id>` | Suivre les N dernières lignes |
| `docker stop <id>` | Arrêter un conteneur (SIGTERM) |
| `docker start <id>` | Redémarrer un conteneur arrêté |
| `docker rm <id>` | Supprimer un conteneur arrêté |
| `docker container prune` | Supprimer tous les conteneurs arrêtés |
| `docker inspect <id>` | Métadonnées JSON complètes |
| `docker inspect <id> --format '…'` | Extraire un champ précis |
