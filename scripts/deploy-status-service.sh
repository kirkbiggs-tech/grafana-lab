nano scripts/deploy-status-service.shnano scripts/deploy-status-service.sh#!/bin/bash
set -euo pipefail

IMAGE="${1:-ghcr.io/kirkbiggs-tech/grafana-lab-status:latest}"
CONTAINER="grafana-lab-status"
PORT="8080"
URL="http://localhost:${PORT}"

echo "=== Grafana Lab Status Deployment ==="
echo "Image: $IMAGE"
echo "Container: $CONTAINER"

echo
echo "Pulling verified image..."
docker pull "$IMAGE"

if docker container inspect "$CONTAINER" >/dev/null 2>&1; then
    echo "Removing existing container..."
    docker rm -f "$CONTAINER"
fi

echo "Starting updated container..."
docker run -d \
    --name "$CONTAINER" \
    --restart unless-stopped \
    -p "${PORT}:80" \
    "$IMAGE"

echo "Waiting for application health..."

for ATTEMPT in {1..20}; do
    if curl --fail --silent "$URL" | grep -q "Status: Running"; then
        HEALTH="$(docker inspect \
            --format='{{.State.Health.Status}}' "$CONTAINER")"
        if [ "$HEALTH" != "healthy" ]; then
            echo "Docker health is $HEALTH; waiting..."
            sleep 3
            continue
        fi
        echo
        echo
        echo "DEPLOYMENT PASSED"
        echo "Website: $URL"
        echo "Container health: $HEALTH"
        exit 0
    fi

    echo "Health check attempt $ATTEMPT of 20..."
    sleep 3
done

echo
echo "DEPLOYMENT FAILED"
docker ps -a --filter "name=^${CONTAINER}$"
docker logs --tail 20 "$CONTAINER"
exit 1
