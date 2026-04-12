# Étape 2 — Secrets

## 1. Créer un Secret

*Créez le fichier `/root/db-secret.yaml` définissant un Secret de type `Opaque` nommé `db-secret` avec les champs `DB_USER: "admin"`, `DB_PASSWORD: "mon-super-mdp-secret"` et `DB_HOST: "postgres.prod.svc.cluster.local"` (en utilisant `stringData` pour écrire les valeurs en clair).*

*Appliquez le manifest pour créer le Secret.*

*Listez le Secret `db-secret` (remarquez que les valeurs ne sont pas affichées).*

## 2. Voir le Secret (encodé base64)

*Affichez le Secret `db-secret` au format YAML pour observer l'encodage base64 des valeurs.*

> Les valeurs sont encodées en base64, pas chiffrées

*Extrayez la valeur de `DB_PASSWORD` en base64 et décodez-la pour lire la valeur en clair.*

## 3. Utiliser le Secret dans un Pod

*Créez le fichier `/root/pod-secret.yaml` définissant un Pod nommé `app-avec-secret` avec l'image `nginx:1.25`, injectant les variables d'environnement `DB_PASSWORD` et `DB_USER` depuis les clés correspondantes du Secret `db-secret`.*

*Appliquez le manifest pour créer le Pod.*

*Exécutez une commande dans le Pod `app-avec-secret` pour afficher les variables d'environnement commençant par `DB_`.*

> Le secret est disponible comme variable d'environnement, sans jamais être visible dans le YAML du pod

## 4. Créer un Secret depuis la ligne de commande

*Créez un Secret générique nommé `api-keys` avec les littéraux `API_KEY=abc123xyz` et `API_SECRET=supersecret`, directement en ligne de commande sans manifest YAML.*

*Listez tous les Secrets pour vérifier la création.*

> Cliquez sur **Check** quand `app-avec-secret` est Running.
