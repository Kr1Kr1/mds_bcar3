# Étape 1 — Exposer l'API Docker via TCP

Par défaut, Docker n'écoute que sur un **socket Unix** (`/var/run/docker.sock`).
Pour pouvoir l'interroger via HTTP depuis n'importe quel client, il faut l'exposer sur un **port TCP**.

## Objectifs

1. Trouvez dans la documentation comment exposer l'API Docker sur le port **2375** en TCP
2. Appliquez la configuration nécessaire et redémarrez le daemon
3. Vérifiez que l'API répond : `curl http://localhost:2375/version`
4. Identifiez la **version de l'API** utilisée par votre daemon — notez-la, elle vous servira pour la suite

> ⚠️ Le port 2375 est **non chiffré** (pas de TLS). En production, on utilise 2376 avec des certificats.

<details>
<summary>💡 Indice : modifier la configuration du daemon</summary>

Docker se configure via `/etc/docker/daemon.json`. Pour ajouter une écoute TCP :

```json
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"]
}
```

Mais sous Ubuntu avec systemd, le service Docker démarre déjà avec `-H fd://` ce qui entre en conflit.
Il faut créer un override systemd pour retirer ce flag :

```bash
mkdir -p /etc/systemd/system/docker.service.d/
```

Créez `/etc/systemd/system/docker.service.d/override.conf` avec :
```ini
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
```

Puis : `systemctl daemon-reload && systemctl restart docker`
</details>

Cliquez sur **Check** quand `curl http://localhost:2375/version` répond.
