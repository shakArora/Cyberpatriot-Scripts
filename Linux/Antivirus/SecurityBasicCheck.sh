#!/bin/bash

# Update the system and install necessary packages
sudo apt update && sudo apt upgrade -y
sudo apt install lynis clamav nmap fail2ban ufw

# Run a comprehensive Lynis security audit
sudo lynis audit system --quick --detailed > lynis_report_$(date +%Y-%m-%d_%H-%M-%S).txt

# Scan for malware
sudo clamscan -r /

# Check for open ports
sudo nmap -sT -O localhost

# Harden firewall (UFW)
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw enable

# Install and configure Fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Optional: Additional security measures
# - Check for weak passwords (using Lynis or other tools)
# - Implement kernel hardening
# - Configure secure SSH settings
# - Regularly update and patch the system

# Send an email notification (requires mailutils)
sudo mail -s "Lynis Security Audit Report" your_email@example.com < lynis_report_$(date +%Y-%m-%d_%H-%M-%S).txt
