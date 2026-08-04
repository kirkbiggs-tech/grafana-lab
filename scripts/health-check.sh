#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$PROJECT_DIR/reports"
TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
REPORT_FILE="$REPORT_DIR/health-report-$TIMESTAMP.txt"

mkdir -p "$REPORT_DIR"
exec > >(tee "$REPORT_FILE") 2>&1

echo "Report saved to: $REPORT_FILE"
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
