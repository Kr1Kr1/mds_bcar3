# Étape 4 — Analyse et correction d'un Dockerfile malicieux

## Contexte

Un collègue vous transmet le Dockerfile suivant "de test". Votre mission :
1. **Identifier** tous les problèmes de sécurité, performance et bonnes pratiques
2. **Corriger** le Dockerfile
3. **Justifier** chaque correction

## Le Dockerfile à analyser

Créez le fichier `/root/bad-app/Dockerfile` avec ce contenu :

```dockerfile
FROM python:3.11

WORKDIR /root

COPY . .

RUN pip install -r requirements.txt

ENV DB_USER=root
ENV DB_PASS=mySuperSecretPassword

EXPOSE 5000

CMD ["python", "app.py"]
```

Créez aussi un `requirements.txt` (ex. `flask`) et un `app.py` minimal pour pouvoir builder.

## Objectifs

1. **Listez tous les problèmes** (au moins 6) dans le Dockerfile d'origine
2. **Écrivez le Dockerfile corrigé** dans `/root/good-app/Dockerfile`
3. **Créez un `.dockerignore`** adapté
4. Buildez les deux images et comparez (taille, layers, utilisateur actif)

<details>
<summary>💡 Indice : liste des problèmes à trouver</summary>

- **User root** : l'app tourne en root → risque maximal en cas de compromission
- **WORKDIR /root** : répertoire de root, mauvaise pratique
- **Secrets en dur** : `DB_PASS` visible dans l'image ET dans `docker inspect`
- **COPY . .** sans `.dockerignore` : risque de copier `.git`, `id_rsa`, `__pycache__`...
- **Pas de version pinning** dans `requirements.txt` : builds non reproductibles
- **Pas de `--no-cache-dir`** sur pip : cache inutile dans l'image
- **Pas de HEALTHCHECK**
- **Image de base trop lourde** : `python:3.11` fait ~1 Go, `python:3.11-slim` suffit
</details>

<details>
<summary>💡 Indice : Dockerfile corrigé</summary>

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

RUN useradd -m appuser
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000')" || exit 1

CMD ["python", "app.py"]
```

Les secrets (`DB_PASS`) se passent au runtime avec `docker run -e DB_PASS=...` ou via Docker secrets.
</details>

<details>
<summary>💡 Indice : .dockerignore minimal</summary>

```
*.env
.git
__pycache__
*.pyc
id_rsa*
.DS_Store
```
</details>

Cliquez sur **Check** quand le Dockerfile corrigé existe dans `/root/good-app/` et ne contient pas de secrets en dur.
