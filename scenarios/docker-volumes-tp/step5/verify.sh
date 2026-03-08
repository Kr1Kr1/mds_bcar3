#!/bin/bash
# Vérifie l'architecture HAProxy + 2 nginx avec bind mounts

# 1. web1 et web2 doivent tourner
for name in web1 web2; do
  STATUS=$(docker inspect "$name" --format '{{.State.Running}}' 2>/dev/null)
  if [ "$STATUS" != "true" ]; then
    echo "ERREUR : le conteneur '$name' n'est pas en cours d'exécution."
    exit 1
  fi
done

# 2. myhaproxy doit tourner
STATUS=$(docker inspect myhaproxy --format '{{.State.Running}}' 2>/dev/null)
if [ "$STATUS" != "true" ]; then
  echo "ERREUR : le conteneur 'myhaproxy' n'est pas en cours d'exécution."
  exit 1
fi

# 3. myhaproxy doit avoir un port mappé sur 80
HAPROXY_PORT=$(docker port myhaproxy 80 2>/dev/null | grep -oP '(?<=:)\d+' | head -1)
if [ -z "$HAPROXY_PORT" ]; then
  echo "ERREUR : le port 80 de myhaproxy n'est pas exposé sur l'hôte."
  echo "Utilisez -p <port_hote>:80 lors du lancement de myhaproxy."
  exit 1
fi

# 4. HAProxy répond sur ce port
HTTP_CODE=$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 "http://localhost:$HAPROXY_PORT")
if [ "$HTTP_CODE" != "200" ]; then
  echo "ERREUR : HAProxy ne répond pas (HTTP $HTTP_CODE) sur le port $HAPROXY_PORT."
  exit 1
fi

# 5. web1, web2 et myhaproxy partagent un réseau personnalisé commun
NET_OK=0
for net in $(docker inspect web1 \
    --format '{{range $k,$v := .NetworkSettings.Networks}}{{$k}} {{end}}' 2>/dev/null); do
  [ "$net" = "bridge" ] || [ "$net" = "host" ] || [ "$net" = "none" ] && continue
  W2=$(docker inspect web2    --format "{{index .NetworkSettings.Networks \"$net\"}}" 2>/dev/null)
  HA=$(docker inspect myhaproxy --format "{{index .NetworkSettings.Networks \"$net\"}}" 2>/dev/null)
  if [ -n "$W2" ] && [ "$W2" != "<no value>" ] && \
     [ -n "$HA" ] && [ "$HA" != "<no value>" ]; then
    NET_OK=1; break
  fi
done

if [ "$NET_OK" -eq 0 ]; then
  echo "ERREUR : web1, web2 et myhaproxy ne partagent pas le même réseau personnalisé."
  exit 1
fi

# 6. web1 et web2 utilisent un bind mount (pas seulement des volumes nommés)
for name in web1 web2; do
  BINDS=$(docker inspect "$name" \
    --format '{{range .HostConfig.Binds}}{{.}} {{end}}' 2>/dev/null)
  if [ -z "$BINDS" ]; then
    echo "ERREUR : '$name' ne monte aucun bind mount depuis l'hôte."
    echo "Utilisez -v /chemin/absolu/hote:/usr/share/nginx/html"
    exit 1
  fi
done

# 7. myhaproxy monte haproxy.cfg depuis l'hôte
HAPROXY_BINDS=$(docker inspect myhaproxy \
  --format '{{range .HostConfig.Binds}}{{.}} {{end}}' 2>/dev/null)
if [ -z "$HAPROXY_BINDS" ]; then
  echo "ERREUR : myhaproxy ne monte aucun bind mount depuis l'hôte."
  echo "Montez votre haproxy.cfg avec -v /chemin/absolu/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg"
  exit 1
fi

echo "✓ Architecture HAProxy OK : web1, web2, myhaproxy opérationnels avec bind mounts (port hôte $HAPROXY_PORT)."
exit 0
