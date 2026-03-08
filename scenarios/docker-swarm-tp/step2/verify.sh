#!/bin/bash
# Vérifie le service replicated "web" (httpd, 4+ replicas) et le service global "debug" (alpine)

# 1. Service "web" basé sur httpd
WEB_IMAGE=$(docker service inspect web --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}' 2>/dev/null | cut -d@ -f1)
if ! echo "$WEB_IMAGE" | grep -q "httpd"; then
  echo "ERREUR : aucun service nommé 'web' basé sur httpd trouvé."
  echo "Créez-le avec : docker service create --name web --replicas 2 -p 80:80 httpd"
  exit 1
fi

# 2. Service "web" scalé à au moins 4 replicas
WEB_REPLICAS=$(docker service inspect web --format '{{.Spec.Mode.Replicated.Replicas}}' 2>/dev/null)
if [ "${WEB_REPLICAS:-0}" -lt 4 ]; then
  echo "ERREUR : le service 'web' a seulement ${WEB_REPLICAS:-0} replica(s), 4 minimum attendus."
  echo "Scalez avec : docker service scale web=4"
  exit 1
fi

# 3. Service "debug" de type global
DEBUG_MODE=$(docker service inspect debug --format '{{if .Spec.Mode.Global}}global{{end}}' 2>/dev/null)
if [ "$DEBUG_MODE" != "global" ]; then
  echo "ERREUR : aucun service nommé 'debug' de type global trouvé."
  echo "Créez-le avec : docker service create --name debug --mode global alpine sleep infinity"
  exit 1
fi

# 4. Service "debug" basé sur alpine
DEBUG_IMAGE=$(docker service inspect debug --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}' 2>/dev/null | cut -d@ -f1)
if ! echo "$DEBUG_IMAGE" | grep -q "alpine"; then
  echo "ERREUR : le service 'debug' n'est pas basé sur l'image alpine."
  exit 1
fi

echo "✓ Service 'web' (httpd, $WEB_REPLICAS replicas) et service 'debug' (alpine, global) opérationnels."
exit 0
