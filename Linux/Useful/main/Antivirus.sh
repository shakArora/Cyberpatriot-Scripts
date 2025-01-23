#!/bin/bash

echo "Welcome to the block1 Linux Antivirus Procedure"

cd /
sudo apt install clamav -y
sudo freshclam
sudo clamscan -r /

sudo apt update && sudo apt install rkhunter
sudo rkhunter --update
sudo rkhunter --check
sudo rkhunter --check --skipped
sudo less /var/log/rkhunter.log
sudo crontab -e
#rkhunter scan every day at 18:00
1 8 * * * /usr/bin/rkhunter --check --cronjob
#chrootkit
# sudo apt update && sudo apt upgrade
sudo apt install chrootkit
sudo apt upgrade chrootkit
sudo chrootkit


sudo apt update && sudo apt upgrade -y
echo "Updating the system and installing necessary packages"
sudo apt install lynis clamav nmap fail2ban ufw


sudo lynis audit system --quick --detailed > lynis_report_$(date +%Y-%m-%d_%H-%M-%S).txt


echo "Checking for open ports"
# Check for open ports
sudo nmap -sT -O localhost

sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw enable

echo "Running Fail2Ban (Security Software)"

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Optional: Additional security measures
# - Check for weak passwords (using Lynis or other tools)
# - Implement kernel hardening
# - Configure secure SSH settings
# - Regularly update and patch the system
