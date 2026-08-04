#!/bin/bash

echo "=== Grafana Lab Health Check ==="
echo "Date: $(date)"
echo "Server: $(hostname)"
echo "User: $(whoami)"

echo
echo "=== System Uptime ==="
uptime

echo
echo "=== Disk Usage ==="
df -h /

echo
echo "=== Memory Usage ==="
free -h

echo
echo "=== Grafana Service ==="
systemctl is-active grafana-server
