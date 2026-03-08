#!/bin/bash
# Vérifie qu'une stack est déployée avec un service httpd replicated (4+) et un service alpine global

# 1. Au moins une stack existe
STACK_NAME=$(docker stack ls --format '{{.Name}}' 2>/dev/null | head -1)
if [ -z "$STACK_NAME" ]; then
  echo "ERREUR : aucune stack déployée."
  echo "Déployez avec : docker stack deploy -c stack.yml <nom_stack>"
  exit 1
fi

# 2. La stack a au moins 2 services
SVC_COUNT=$(docker stack services "$STACK_NAME" --format '{{.Name}}' 2>/dev/null | wc -l)
if [ "${SVC_COUNT:-0}" -lt 2 ]; then
  echo "ERREUR : la stack '$STACK_NAME' n'a que ${SVC_COUNT:-0} service(s), 2 minimum attendus."
  exit 1
fi

# 3. Un service replicated basé sur httpd avec au moins 4 replicas
HTTPD_SVC=""
while IFS= read -r svc; do
  IMAGE=$(docker service inspect "$svc" --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}' 2>/dev/null | cut -d@ -f1)
  MODE=$(docker service inspect "$svc" --format '{{if .Spec.Mode.Replicated}}replicated{{end}}' 2>/dev/null)
  REPLICAS=$(docker service inspect "$svc" --format '{{.Spec.Mode.Replicated.Replicas}}' 2>/dev/null)
  if echo "$IMAGE" | grep -q "httpd" && [ "$MODE" = "replicated" ] && [ "${REPLICAS:-0}" -ge 4 ]; then
    HTTPD_SVC="$svc"
    break
  fi
done < <(docker stack services "$STACK_NAME" --format '{{.Name}}' 2>/dev/null)

if [ -z "$HTTPD_SVC" ]; then
  echo "ERREUR : aucun service replicated basé sur httpd avec 4+ replicas dans la stack '$STACK_NAME'."
  echo "Vérifiez votre fichier stack.yml (mode: replicated, replicas: 4, image: httpd)."
  exit 1
fi

# 4. Un service global basé sur alpine
GLOBAL_SVC=""
while IFS= read -r svc; do
  IMAGE=$(docker service inspect "$svc" --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}' 2>/dev/null | cut -d@ -f1)
  MODE=$(docker service inspect "$svc" --format '{{if .Spec.Mode.Global}}global{{end}}' 2>/dev/null)
  if echo "$IMAGE" | grep -q "alpine" && [ "$MODE" = "global" ]; then
    GLOBAL_SVC="$svc"
    break
  fi
done < <(docker stack services "$STACK_NAME" --format '{{.Name}}' 2>/dev/null)

if [ -z "$GLOBAL_SVC" ]; then
  echo "ERREUR : aucun service global basé sur alpine dans la stack '$STACK_NAME'."
  echo "Vérifiez votre fichier stack.yml (mode: global, image: alpine)."
  exit 1
fi

echo "✓ Stack '$STACK_NAME' déployée — $HTTPD_SVC (httpd, replicated) et $GLOBAL_SVC (alpine, global) OK."
exit 0
