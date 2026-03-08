# Étape 2 — Virtualisation & Scripting

Testez vos connaissances sur la virtualisation et le scripting Bash.

## Lancer le quiz

`bash /root/quiz_step2.sh`{{exec}}

> Entrez le **numéro** de votre réponse pour chaque question, puis appuyez sur **Entrée**.

---

## Aide-mémoire

| Concept | Détail |
|---------|--------|
| **Hyperviseur type 1** | S'exécute **directement sur le matériel** (ex : VMware ESXi, Hyper-V) |
| **Hyperviseur type 2** | S'exécute **sur un OS hôte** (ex : VirtualBox, VMware Workstation) |
| **Docker** | Utilise les **namespaces** et **cgroups** du noyau Linux |
| `bash script.sh` | Exécuter un script Bash |
| `$?` | Code de retour de la dernière commande (0 = succès) |
| `chmod +x script.sh` | Rendre un script Bash exécutable |

**Rappels :**
- Un hyperviseur **type 1** (bare-metal) n'a pas besoin d'OS hôte
- Docker isole les processus via les namespaces Linux, il ne virtualise pas le matériel
- `$0` = nom du script, `$1` = premier argument, `$$` = PID du processus courant

---

Quand vous avez répondu aux 5 questions, cliquez sur **Check** pour valider.
