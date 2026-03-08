# Étape 4 — Simulation de maintenance (drain / active)

## Objectifs

Dans un vrai cluster Swarm, drainer un nœud permet de le retirer proprement pour maintenance :
les tâches sont déplacées vers les autres nœuds disponibles. Ici, avec un seul nœud,
les tâches ne pourront pas migrer — vous allez observer ce comportement.

1. Récupérez l'identifiant ou le nom de votre nœud manager avec `docker node ls`
2. Passez le nœud en mode **drain** — observez ce qui arrive aux tâches des services existants
3. Listez les services et leurs tâches — pourquoi sont-elles en état `Pending` ?
4. Remettez le nœud en disponibilité **active**
5. Vérifiez que les services reprennent leur fonctionnement normal

> ⚠️ Sur un cluster à un seul nœud, les tâches passent en état `Pending` lorsque le nœud
> est drainé, car il n'y a nulle part où les relocaliser. En production avec plusieurs nœuds,
> elles migreraient automatiquement vers les nœuds actifs.

> 💡 Quelle est la différence entre les disponibilités `active`, `pause` et `drain` d'un nœud ?
> Dans quel cas utiliser `pause` plutôt que `drain` ?

Cliquez sur **Check** quand c'est fait.
