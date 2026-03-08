#!/bin/bash
# Vérifie que le service "viz" est déployé sur le port 8080 et en état Running

# 1. Service "viz" existe et est basé sur visualizer
VIZ_IMAGE=$(docker service inspect viz --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}' 2>/dev/null | cut -d@ -f1)
if ! echo "$VIZ_IMAGE" | grep -q "visualizer"; then
  echo "ERREUR : aucun service nommé 'viz' basé sur dockersamples/visualizer trouvé."
  echo "Déployez-le avec : docker service create --name viz -p 8080:8080 --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock --constraint node.role==manager dockersamples/visualizer"
  exit 1
fi

# 2. Port 8080 publié
VIZ_PORT=$(docker service inspect viz \
  --format '{{range .Endpoint.Ports}}{{.PublishedPort}}{{end}}' 2>/dev/null)
if [ "$VIZ_PORT" != "8080" ]; then
  echo "ERREUR : le service 'viz' n'expose pas le port 8080 (port trouvé : ${VIZ_PORT:-aucun})."
  echo "Recréez le service avec l'option -p 8080:8080"
  exit 1
fi

# 3. Au moins une tâche en état Running
RUNNING=$(docker service ps viz --filter desired-state=running \
  --format '{{.CurrentState}}' 2>/dev/null | grep -c "Running" || true)
if [ "${RUNNING:-0}" -lt 1 ]; then
  echo "ERREUR : aucune tâche du service 'viz' n'est en état Running."
  echo "Vérifiez avec : docker service ps viz"
  exit 1
fi

echo "✓ Service 'viz' opérationnel sur le port 8080 (${RUNNING} tâche(s) Running)."
exit 0
