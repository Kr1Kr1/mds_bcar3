# Étape 4 — Instruction `VOLUME` dans un Dockerfile

L'instruction `VOLUME` dans un Dockerfile déclare qu'un répertoire doit être externalisé
hors de l'image — Docker crée automatiquement un volume anonyme à chaque lancement du conteneur.

## Objectifs

1. Créez un dossier de travail `~/vol-dockerfile` sur l'hôte
2. Dans ce dossier, créez un `Dockerfile` basé sur `ubuntu` qui :
   - Déclare `/appdata` comme volume avec l'instruction `VOLUME`
   - Crée un fichier de démonstration dans `/appdata` **lors du build** (avec `RUN`)
3. Buildez cette image sous le nom `monapp`

> 💡 Réfléchissez : le fichier créé par `RUN` dans `/appdata` sera-t-il présent dans le volume au lancement ?

4. Lancez un conteneur depuis `monapp` — donnez-lui un nom (ex. `app1`)
5. Trouvez le **répertoire hôte** correspondant au volume automatique avec `docker inspect`
   (cherchez la clé `Mounts` ou le **Mountpoint**)
6. Vérifiez le contenu de ce répertoire hôte — que contient-il ?
7. Depuis le conteneur, créez un fichier dans `/appdata`
8. Vérifiez que ce fichier est visible dans le répertoire hôte trouvé à l'étape 5

> 💡 Quelle est la différence entre `VOLUME` dans un Dockerfile et `-v` au lancement ?
> Dans quel cas préférez-vous l'un ou l'autre ?

Cliquez sur **Check** quand l'image `monapp` existe et qu'un conteneur l'utilise avec un volume automatique.
