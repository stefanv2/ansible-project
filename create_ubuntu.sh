#!/bin/bash

CONTAINER_NAME=$1
CONTAINER_IP=$2
HOST_PORT=${3:-8080}  # standaard poort naar 8080

# Check input
if [[ -z "$CONTAINER_NAME" || -z "$CONTAINER_IP" ]]; then
  echo "Gebruik: $0 <container_name> <ip_adres> [host_port]"
  exit 1
fi

# Container verwijderen als die bestaat
docker rm -f "$CONTAINER_NAME" 2>/dev/null

# Container starten
docker run -dit \
  --name "$CONTAINER_NAME" \
  --hostname "$CONTAINER_NAME" \
  --network ansible-net \
  --ip "$CONTAINER_IP" \
  -p "$HOST_PORT":80 \
  ubuntu:20.04

# Setup binnenin de container
docker exec -it "$CONTAINER_NAME" bash -c "
  export DEBIAN_FRONTEND=noninteractive &&
  apt update &&
  apt install -y openssh-server sudo curl iputils-ping net-tools vim &&
  useradd -m ansible &&
  echo 'ansible ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ansible &&
  mkdir -p /home/ansible/.ssh &&
  echo \"$(cat ~/.ssh/id_rsa.pub)\" > /home/ansible/.ssh/authorized_keys &&
  chown -R ansible:ansible /home/ansible/.ssh &&
  chmod 700 /home/ansible/.ssh &&
  chmod 600 /home/ansible/.ssh/authorized_keys &&
  service ssh start
"

echo "✅ Container $CONTAINER_NAME aangemaakt op $CONTAINER_IP en bereikbaar via poort $HOST_PORT"

