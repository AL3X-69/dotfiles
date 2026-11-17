#!/bin/bash

LINUX_RELEASE_URL="https://github.com/prometheus/node_exporter/releases/download/v1.12.1/node_exporter-1.12.1.linux-amd64.tar.gz"

printf "Downloading release...\n"
wget "$LINUX_RELEASE_URL" -O node_exporter.tar.gz
printf "Inflating release...\n"
mkdir node_exporter
tar xvfz node_exporter.tar.gz -C node_exporter --strip-components 1
printf "Installing...\n"
sudo useradd -r prometheus
sudo mv node_exporter /opt
sudo chown prometheus:prometheus /opt/node_exporter

sudo bash -c "cat > /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Prometheus PVE Node Exporter
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/opt/node_exporter/node_exporter
User=prometheus
Group=prometheus

[Install]
WantedBy=multi-user.target
EOF"

printf "Starting SystemD service...\n"
sudo systemctl enable --now node_exporter
printf "Cleaning...\n"
rm node_exporter.tar.gz
printf "Installation finished :3\n"
