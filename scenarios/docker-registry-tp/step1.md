# Étape 1 — Lancer un registry privé

## Objectifs

1. Démarrez un conteneur basé sur l'image **`registry:2`**
   - Il doit écouter sur le port **5000** de l'hôte
   - Il doit redémarrer automatiquement en cas de crash
   - Il doit tourner en arrière-plan

2. Vérifiez que le registry est fonctionnel en interrogeant son API REST :
   l'endpoint **`/v2/`** doit répondre avec un code HTTP **200**

> 💡 Le registry Docker expose une API HTTP standard — pas besoin de client particulier,
> un simple `curl` suffit pour interagir avec lui.

> 💡 Que signifie la réponse `{}` renvoyée par `/v2/` ?

Cliquez sur **Check** quand c'est fait.
