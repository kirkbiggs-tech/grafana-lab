#!/bin/bash

HEALTH_SCRIPT="./scripts/health-check.sh"
FAILURES=0

pass() {
    echo "PASS: $1"
}

fail() {
    echo "FAIL: $1"
    FAILURES=$((FAILURES + 1))
}

echo "=== Automated Health-Check Tests ==="

if [ -f "$HEALTH_SCRIPT" ]; then
    pass "Health-check script exists"
else
    fail "Health-check script does not exist"
fi

if [ -x "$HEALTH_SCRIPT" ]; then
    pass "Health-check script is executable"
else
    fail "Health-check script is not executable"
fi

OUTPUT=$("$HEALTH_SCRIPT" 2>&1)
SCRIPT_STATUS=$?

if [ $SCRIPT_STATUS -eq 0 ]; then
    pass "Health-check script runs successfully"
else
    fail "Health-check script returned an error"
fi

if [ -n "$OUTPUT" ]; then
    pass "Health-check script produces output"
else
    fail "Health-check script produced no output"
fi

if echo "$OUTPUT" | grep -q "Grafana Service"; then
    pass "Output includes Grafana service status"
else
    fail "Grafana service status is missing"
fi

echo

if [ $FAILURES -eq 0 ]; then
    echo "ALL TESTS PASSED"
    exit 0
else
    echo "$FAILURES TEST(S) FAILED"
    exit 1
fi
