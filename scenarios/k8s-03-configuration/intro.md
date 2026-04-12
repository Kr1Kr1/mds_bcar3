# Kubernetes — Configuration : ConfigMaps, Secrets et Namespaces

Dans ce TP, vous allez apprendre à séparer la configuration du code applicatif et à isoler des environnements.

## Objectifs

À la fin de ce TP, vous saurez :
- Créer et utiliser des ConfigMaps (variables d'env et volumes)
- Créer et utiliser des Secrets
- Organiser les ressources par Namespaces
- Appliquer des ResourceQuotas

## Principe fondamental

> Une application cloud native ne doit **jamais** embarquer sa configuration — elle est injectée au runtime via ConfigMaps et Secrets.
