# Étape 4 — Mode détaché et logs

## Objectifs

1. Lancez un conteneur basé sur **rockylinux/rockylinux** qui exécute `ping 127.0.0.1 -c 60` en mode **détaché**
2. Listez les conteneurs — observez l'état et le temps de fonctionnement
3. Attendez quelques secondes puis listez à nouveau — que s'est-il passé ?
4. Lancez un nouveau conteneur en arrière-plan (image au choix, avec une commande qui produit des logs)
5. Récupérez son ID et consultez ses logs
6. Consultez les logs en **flux continu**
7. Consultez les logs en flux continu en n'affichant que les **10 dernières lignes**

> 💡 Si `rockylinux/rockylinux` est lent à télécharger, utilisez `ubuntu` avec `bash -c "for i in \$(seq 60); do echo tick \$i; sleep 1; done"`.

Cliquez sur **Check** quand c'est fait.
