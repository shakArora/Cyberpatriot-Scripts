#!/bin/bash

echo "Running custom scoring checks..."
# Example: Check SSH settings
if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config; then
    echo "SSH root login is disabled: PASS"
else
    echo "SSH root login is enabled: FAIL"
fi

# Example: Ensure password aging is set
if grep -q "^PASS_MAX_DAYS 90" /etc/login.defs; then
    echo "Password aging is configured: PASS"
else
    echo "Password aging is not configured: FAIL"
fi

echo "Scoring checks complete."
