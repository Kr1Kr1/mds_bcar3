# Correction — Docker Images TP

---

## Étape 1 — Modifier un conteneur et inspecter les différences

```bash
# 1. Lancer un conteneur rockylinux en interactif et installer wget
docker run -it --name rocky-modif rockylinux/rockylinux bash

# À l'intérieur du conteneur :
dnf install -y wget
exit

# 2. Comparer l'état du conteneur avec l'image de base
docker diff rocky-modif
```

La sortie de `docker diff` liste les fichiers avec un préfixe :

| Préfixe | Signification |
|---------|---------------|
| `A` | Ajouté (*Added*) |
| `C` | Modifié (*Changed*) |
| `D` | Supprimé (*Deleted*) |

> **Conclusion** : `docker diff` montre précisément le delta entre le conteneur et l'image
> d'origine. Chaque paquet installé ajoute des dizaines de fichiers dans le layer inscriptible
> du conteneur, sans toucher à l'image de base.

---

## Étape 2 — Créer une image avec docker commit

```bash
# 1. Créer une image depuis le conteneur modifié
docker commit rocky-modif monrocky-wget

# 2. Vérifier que l'image apparaît
docker images
# → monrocky-wget   latest   <ID>   ...

# 3. Créer un conteneur à partir de la nouvelle image
docker run -it --rm monrocky-wget bash

# 4. Vérifier que wget est disponible
which wget
# → /usr/bin/wget
wget --version
exit
```

> **Pourquoi `docker commit` est déconseillé en production ?**
> - Le processus est **non reproductible** : impossible de savoir exactement ce qui a été fait
>   à l'intérieur du conteneur.
> - Il n'y a **pas de traçabilité** ni d'historique versionnable dans Git.
> - Les layers créés sont **opaques** : `docker history` ne montre pas les commandes.
> - Le Dockerfile, lui, est déclaratif, versionné et peut être relu, audité et automatisé.

---

## Étape 3 — Écrire un Dockerfile et construire une image

```bash
# 1. Créer un répertoire de travail
mkdir -p ~/monimage && cd ~/monimage
```

**`~/monimage/Dockerfile`** (version initiale) :

```dockerfile
FROM rockylinux/rockylinux
RUN dnf update -y
RUN dnf install -y wget
```

```bash
# 3. Construire l'image
docker build -t monimage-dockerfile ~/monimage

# 4. Vérifier qu'elle apparaît
docker images | grep monimage-dockerfile
```

**`~/monimage/Dockerfile`** (version avec zip — instruction séparée) :

```dockerfile
FROM rockylinux/rockylinux
RUN dnf update -y
RUN dnf install -y wget
RUN dnf install -y zip
```

```bash
# 6. Reconstruire et observer la sortie
docker build -t monimage-dockerfile ~/monimage
```

> **Observation** : lors du second build, les étapes `FROM` et les `RUN` déjà exécutés
> affichent `CACHED` — Docker réutilise les layers existants. Seul le nouveau `RUN dnf install -y zip`
> est réellement exécuté. C'est le **système de cache par layer**.

```bash
# 7. Afficher l'historique de construction
docker history monimage-dockerfile
```

---

## Étape 4 — Cache, layers et optimisation

**`~/monimage/Dockerfile`** (version optimisée — un seul RUN) :

```dockerfile
FROM rockylinux/rockylinux
RUN dnf update -y && dnf install -y wget zip
```

```bash
# 2. Reconstruire l'image
docker build -t monimage-dockerfile ~/monimage
```

> **Observation** : le cache est **invalidé** dès le premier `RUN` modifié — Docker ne peut pas
> savoir si le résultat sera identique, donc il réexécute tout depuis ce point.
> Le build est plus long mais produit une image avec **moins de layers**.

```bash
# 3. Comparer les historiques
docker history monimage-dockerfile
```

La version optimisée a un layer `RUN` de moins que la version à deux instructions séparées.

> **Pourquoi fusionner les `RUN` ?**
> - Chaque instruction `RUN` crée un layer. Les layers s'accumulent et **augmentent la taille**
>   totale de l'image, même si un layer suivant supprime des fichiers (le layer précédent
>   les contient encore).
> - Fusionner `dnf install` en une seule commande réduit le nombre de layers et permet de
>   **nettoyer le cache dnf dans le même layer** :
>   ```dockerfile
>   RUN dnf install -y wget zip && dnf clean all
>   ```

**Réponses aux questions à réfléchir**

- **Modifier `FROM`** : invalide l'intégralité du cache — tous les layers sont reconstruits
  car l'image de base a changé.
- **Ordre optimal des instructions** : placer les instructions les **moins susceptibles de changer**
  en premier (`FROM`, `RUN dnf install`) et les **plus volatiles en dernier** (`COPY` du code source,
  variables d'environnement spécifiques). Ainsi, le cache est réutilisé au maximum lors des
  itérations de développement.

---

## Récapitulatif des commandes clés

| Commande | Rôle |
|----------|------|
| `docker diff <conteneur>` | Comparer un conteneur avec son image de base |
| `docker commit <conteneur> <nom>` | Créer une image depuis un conteneur modifié |
| `docker build -t <nom> <contexte>` | Construire une image depuis un Dockerfile |
| `docker build --no-cache` | Construire sans utiliser le cache |
| `docker history <image>` | Afficher les layers et leur taille |
| `docker images` | Lister les images locales |
| `docker run --rm <image> <cmd>` | Lancer un conteneur temporaire |
