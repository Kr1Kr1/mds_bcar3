# Étape 5 — Architecture 3-tiers : load balancing avec HAProxy

## Objectifs

Construire l'architecture suivante :

```
Internet → HAProxy (port 80 exposé) → web1 (nginx)
                                    → web2 (nginx)
```

1. Créez un réseau dédié (ex. `web`)
2. Lancez deux conteneurs **nginx** nommés `web1` et `web2` sur ce réseau
3. Personnalisez la page d'accueil de chaque nginx pour les distinguer (ex. "Bonjour depuis web1")
4. Lancez un conteneur **haproxy** nommé `myhaproxy` sur le même réseau, avec le port **80** exposé sur l'hôte
5. Configurez HAProxy pour distribuer les requêtes en **round-robin** entre `web1:80` et `web2:80`
6. Vérifiez que plusieurs `curl` successifs alternent bien entre les deux serveurs

> 💡 HAProxy se configure via `/usr/local/etc/haproxy/haproxy.cfg`. Montez-le avec `-v`.

> 💡 Exemple de configuration HAProxy minimale :
> ```
> global
>   daemon
> defaults
>   mode http
>   timeout connect 5s
>   timeout client  30s
>   timeout server  30s
> frontend http_front
>   bind *:80
>   default_backend web_back
> backend web_back
>   balance roundrobin
>   server web1 web1:80 check
>   server web2 web2:80 check
> ```

Cliquez sur **Check** quand c'est fait.
