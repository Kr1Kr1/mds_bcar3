#!/bin/bash
# Vérifier que l'Ingress mon-ingress existe avec au moins 2 règles
INGRESS=$(kubectl get ingress mon-ingress --no-headers 2>/dev/null)
if [ -z "$INGRESS" ]; then
  echo "ERREUR : Ingress 'mon-ingress' introuvable"
  echo "Vérifiez avec : kubectl get ingress"
  exit 1
fi
# Vérifier qu'il y a au moins 2 paths dans les règles
PATHS=$(kubectl get ingress mon-ingress -o jsonpath='{.spec.rules[*].http.paths[*].path}' 2>/dev/null | wc -w)
if [ "$PATHS" -ge 2 ]; then
  echo "✓ Ingress mon-ingress créé avec $PATHS route(s)"
  exit 0
fi
echo "ERREUR : Ingress mon-ingress existe mais semble n'avoir qu'une seule règle"
exit 1
