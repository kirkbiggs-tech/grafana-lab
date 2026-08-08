#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

echo "=== Monitoring Configuration Tests ==="
echo "Project: $PROJECT_DIR"

for FILE in \
    prometheus/prometheus.yml \
    prometheus/alert-rules.yml \
    prometheus/alertmanager.yml \
    scripts/alert-webhook.py \
    systemd/grafana-alert-webhook.service
do
    test -f "$FILE"
    echo "PASS: $FILE exists"
done

promtool check rules prometheus/alert-rules.yml
echo "PASS: Prometheus alert rules are valid"

TEMP_CONFIG="$(mktemp)"
trap 'rm -f "$TEMP_CONFIG"' EXIT

sed "s|/etc/prometheus/alert-rules.yml|$PROJECT_DIR/prometheus/alert-rules.yml|" \
    prometheus/prometheus.yml > "$TEMP_CONFIG"

promtool check config "$TEMP_CONFIG"
echo "PASS: Prometheus configuration is valid"

amtool check-config prometheus/alertmanager.yml
echo "PASS: Alertmanager configuration is valid"

python3 -m py_compile scripts/alert-webhook.py
echo "PASS: Webhook Python syntax is valid"

grep -q "ExecStart=.*alert-webhook.py" \
    systemd/grafana-alert-webhook.service
echo "PASS: Webhook systemd service is configured"

echo
echo "ALL MONITORING TESTS PASSED"
