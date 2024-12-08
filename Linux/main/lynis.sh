#!/bin/bash

# Update the system to ensure the latest packages are installed
sudo apt update && sudo apt upgrade -y

# Install Lynis if not already installed
if ! command -v lynis &> /dev/null; then
    sudo apt install lynis -y
fi

# Run Lynis with detailed output and save the results to a file
sudo lynis audit system --quick --detailed > lynis_report.txt

# Optional: Send the report via email (requires mailutils package)
# Edit the email address and subject as needed
# sudo mail -s "Lynis Security Audit Report" your_email@example.com < lynis_report.txt

# Optional: Open the report in a text editor
gedit lynis_report.txt

echo "Checking for suspicious logins..."
grep "Failed password" /var/log/auth.log
grep "invalid user" /var/log/auth.log

echo "Checking for changes to /etc..."
grep "/etc/" /var/log/audit/audit.log

echo "Audit log check complete."
