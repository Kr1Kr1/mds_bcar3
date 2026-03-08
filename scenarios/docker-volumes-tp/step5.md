# Étape 5 — HAProxy avec bind mounts

Vous allez reconstruire l'architecture du TP Réseau (web1 + web2 + haproxy),
mais cette fois **sans modifier les conteneurs** : toute la configuration passe
par des fichiers montés depuis l'hôte via des bind mounts.

## Architecture cible

```
Internet → myhaproxy (port 80 exposé) → web1 (nginx)
                                       → web2 (nginx)
```

## Objectifs

### Préparation des fichiers de configuration sur l'hôte

1. Créez la structure suivante sur l'hôte :
   ```
   ~/haproxy-tp/
   ├── web1/index.html   ← page identifiant web1
   ├── web2/index.html   ← page identifiant web2
   └── haproxy.cfg       ← configuration HAProxy
   ```
2. Rédigez `haproxy.cfg` pour distribuer le trafic en **round-robin** entre `web1:80` et `web2:80`

### Lancement de l'architecture

3. Créez un réseau Docker dédié (ex. `webnet`)
4. Lancez `web1` : conteneur nginx nommé `web1` sur `webnet`,
   avec `~/haproxy-tp/web1/` monté dans `/usr/share/nginx/html`
5. Lancez `web2` : même chose avec `~/haproxy-tp/web2/`
6. Lancez `myhaproxy` : conteneur haproxy nommé `myhaproxy` sur `webnet`,
   avec `~/haproxy-tp/haproxy.cfg` monté dans `/usr/local/etc/haproxy/haproxy.cfg`,
   et le port **80** exposé sur l'hôte

### Validation

7. Faites plusieurs `curl` successifs sur le port exposé — vérifiez l'alternance entre web1 et web2
8. **Sans arrêter aucun conteneur**, modifiez `~/haproxy-tp/web1/index.html` sur l'hôte
9. Refaites un `curl` — le changement est-il visible immédiatement ?

> 💡 Quel est l'avantage de cette approche par rapport à `docker exec` + édition dans le conteneur ?

Cliquez sur **Check** quand les trois conteneurs tournent, partagent un réseau, et que HAProxy répond.
