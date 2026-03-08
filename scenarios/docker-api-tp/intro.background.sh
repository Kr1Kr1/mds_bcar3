#!/bin/bash
# Installe Docker CE et prépare les ressources du TP API

apt-get update -qq
apt-get install -y -qq ca-certificates curl gnupg jq 2>/dev/null

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update -qq
apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin 2>/dev/null
systemctl start docker

# Pré-pull des images utiles
docker pull ubuntu:latest &>/dev/null
docker pull nginx:latest &>/dev/null

# Créer les fichiers de payload JSON pour les exercices
mkdir -p /root/api-tp

cat > /root/api-tp/create_container_simple.json << 'EOF'
{
  "Image": "ubuntu:latest",
  "Cmd": ["sleep", "3600"],
  "AttachStdin": false,
  "AttachStdout": true,
  "AttachStderr": true,
  "Tty": false
}
EOF

cat > /root/api-tp/create_container_complex.json << 'EOF'
{
  "Image": "nginx:latest",
  "AttachStdin": false,
  "AttachStdout": true,
  "AttachStderr": true,
  "Tty": false,
  "ExposedPorts": { "80/tcp": {} },
  "HostConfig": {
    "PortBindings": { "80/tcp": [{ "HostPort": "8080" }] },
    "RestartPolicy": { "Name": "unless-stopped", "MaximumRetryCount": 0 }
  }
}
EOF

echo "Docker API TP prêt"
