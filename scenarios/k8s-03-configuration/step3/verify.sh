#!/bin/bash
NS_STAGING=$(kubectl get namespace staging --no-headers 2>/dev/null | awk '{print $1}')
NS_PROD=$(kubectl get namespace production --no-headers 2>/dev/null | awk '{print $1}')
QUOTA=$(kubectl get resourcequota quota-staging -n staging --no-headers 2>/dev/null | awk '{print $1}')
if [ "$NS_STAGING" = "staging" ] && [ "$NS_PROD" = "production" ] && [ "$QUOTA" = "quota-staging" ]; then
  echo "✓ Namespaces staging et production créés, ResourceQuota appliqué"
  exit 0
fi
echo "ERREUR : staging=${NS_STAGING:-absent}, production=${NS_PROD:-absent}, quota=${QUOTA:-absent}"
exit 1
