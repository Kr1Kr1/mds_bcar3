# Étape 1 — Volumes nommés : création et persistance

## Objectifs

### Partie A — Création et différence image / volume

1. Créez un volume nommé **`vol1`**
2. Listez les volumes pour confirmer sa création
3. Lancez un conteneur **ubuntu** en mode interactif avec `vol1` monté dans `/data`
4. À l'intérieur du conteneur, créez un fichier dans `/data` (contenu au choix)
5. Quittez le conteneur avec `exit`
6. Créez une image depuis ce conteneur avec **`docker commit`**
7. Lancez un nouveau conteneur depuis cette nouvelle image — vérifiez si le fichier est présent dans `/data`

> 💡 Que concluez-vous sur la relation entre les données d'un volume et le contenu de l'image ?

### Partie B — Persistance et partage

8. Affichez les détails du volume `vol1` avec `docker volume inspect` — notez le **Mountpoint** sur l'hôte
9. Supprimez le conteneur de la partie A (pas le volume)
10. Lancez un **nouveau** conteneur avec `vol1` monté dans `/data` — vérifiez que le fichier créé précédemment est toujours là
11. Sans quitter ce conteneur, lancez un **second** conteneur avec `vol1` monté dans `/data`
12. Depuis le second conteneur, créez un second fichier dans `/data`
13. Depuis le premier conteneur (avec `docker exec`), vérifiez que le fichier créé par le second est visible

> 💡 Quelle conclusion tirez-vous sur le partage d'un volume entre plusieurs conteneurs simultanés ?

Cliquez sur **Check** quand les deux conteneurs partagent `vol1` et que chacun voit les fichiers de l'autre.
