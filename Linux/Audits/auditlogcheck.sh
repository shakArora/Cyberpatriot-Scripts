#!/bin/bash

echo "Checking for suspicious logins..."
grep "Failed password" /var/log/auth.log
grep "invalid user" /var/log/auth.log

echo "Checking for changes to /etc..."
grep "/etc/" /var/log/audit/audit.log

echo "Audit log check complete."
