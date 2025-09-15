#!/bin/bash
set -xe

exec > >(tee -a /var/log/user_data_debug.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "=== Starting user-data script ==="

echo "=== Installing Docker ==="
sudo snap install docker

echo "=== Enabling and starting Docker service ==="
sudo systemctl enable --now snap.docker.dockerd.service

echo "=== Waiting for Docker to become active ==="
while ! systemctl is-active --quiet snap.docker.dockerd.service; do
    echo "Docker service not active yet, sleeping 1s..."
    sleep 1
done
echo "Docker service is active!"

echo "=== Waiting for Docker socket to be ready ==="
while [ ! -S /var/run/docker.sock ]; do
    echo "Docker socket not ready yet, sleeping 1s..."
    sleep 1
done
echo "Docker socket is ready!"

echo "=== Pulling Docker image diego587/flask-basic-app ==="
sudo docker pull diego587/flask-basic-app

echo "=== Running Docker container ==="
sudo docker run -d -p 5000:5000 diego587/flask-basic-app

echo "=== User-data script finished ==="

