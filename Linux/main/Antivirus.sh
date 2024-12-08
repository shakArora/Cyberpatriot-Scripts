#!/bin/bash

echo "Welcome to the block1 Linux Antivirus Procedure"

cd /
echo "Would you like to run ClamAV (1/0)"
read -p " " $clam
if ["$clam" == "1"]; then 
  sudo apt install clamav clamtk
  sudo freshclam
  sudo clamscan -r /
fi

echo "Would you like to run RKHunter and ChRootKit (1/0)"
read -p " " $rootkit
if ["$rootkit" == "1"]; then
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
fi

sudo apt update && sudo apt upgrade -y
echo "Updating the system and installing necessary packages"
sudo apt install lynis clamav nmap fail2ban ufw

echo "Would you like to run Lynis (1/0): "
read -p " " $lynissoftware
if ["$lynissoftware" == "1"]; then
  sudo lynis audit system --quick --detailed > lynis_report_$(date +%Y-%m-%d_%H-%M-%S).txt
fi

echo "Checking for open ports"
# Check for open ports
sudo nmap -sT -O localhost

echo "Hardening firewall (UFW)"
# Harden firewall (UFW)
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw enable

echo "Running Fail2Ban (Security Software)"
# Install and configure Fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Optional: Additional security measures
# - Check for weak passwords (using Lynis or other tools)
# - Implement kernel hardening
# - Configure secure SSH settings
# - Regularly update and patch the system
