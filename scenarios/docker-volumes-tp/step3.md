# Étape 3 — Bind mounts : monter un dossier hôte

Contrairement aux volumes nommés gérés par Docker, un **bind mount** monte directement
un chemin du système de fichiers hôte dans le conteneur.

## Objectifs

### Partie A — Serveur de fichiers statiques

1. Créez un dossier `~/www` sur l'hôte et placez-y un fichier `index.html` avec le contenu de votre choix
2. Lancez un conteneur **nginx** en mode détaché, en montant `~/www` dans `/usr/share/nginx/html`
   et en exposant le port 80 sur l'hôte
3. Faites un `curl` sur le port exposé — vérifiez que nginx sert votre `index.html`
4. **Sans redémarrer le conteneur**, modifiez le contenu de `~/www/index.html` depuis l'hôte
5. Refaites un `curl` — le changement est-il immédiatement visible ?

> 💡 Quelle est la différence fondamentale avec un `COPY` dans un Dockerfile ?

### Partie B — Capture des logs nginx

6. Créez un dossier `~/nginx-logs` sur l'hôte
7. Lancez un **nouveau** conteneur nginx en montant `~/nginx-logs` dans `/var/log/nginx`
   (avec le port 80 exposé sur un autre port hôte)
8. Faites plusieurs `curl` vers ce nginx
9. Vérifiez sur l'hôte (dans `~/nginx-logs`) que les fichiers `access.log` et `error.log` sont présents
   et que les requêtes curl y sont enregistrées

> ⚠️ Le montage doit utiliser le chemin **absolu** du dossier hôte avec `-v`.

Cliquez sur **Check** quand nginx tourne avec un bind mount et que des logs sont visibles sur l'hôte.
