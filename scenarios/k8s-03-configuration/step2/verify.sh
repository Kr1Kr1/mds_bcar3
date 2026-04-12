#!/bin/bash
SECRET=$(kubectl get secret db-secret --no-headers 2>/dev/null | awk '{print $1}')
POD=$(kubectl get pod app-avec-secret --no-headers 2>/dev/null | awk '{print $3}')
if [ "$SECRET" = "db-secret" ] && [ "$POD" = "Running" ]; then
  echo "✓ Secret db-secret créé, pod app-avec-secret Running"
  exit 0
fi
echo "ERREUR : db-secret=${SECRET:-absent}, app-avec-secret=${POD:-absent}"
exit 1
