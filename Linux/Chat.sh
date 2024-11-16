#!/bin/bash
# Overpowered CyberPatriot Linux Setup Script
# This script will focus on making the system secure, optimized, and efficient for CyberPatriot challenges.

echo "Starting Overpowered Linux setup for CyberPatriot..."

# Step 1: Update the system and install essential tools
echo "Updating the system and installing essential security tools..."
# apt update && apt upgrade -y
apt install -y build-essential curl wget git vim htop net-tools ufw fail2ban lynis auditd nmap

# Step 2: System optimization (performance tweaks)
echo "Optimizing system performance..."

# Disable unnecessary services
systemctl disable bluetooth
systemctl disable cups
systemctl disable avahi-daemon

# Disable kernel modules that are not needed for security
echo "Disabling unnecessary kernel modules..."
echo "blacklist ipv6" >> /etc/modprobe.d/blacklist.conf
echo "blacklist mptctl" >> /etc/modprobe.d/blacklist.conf

# Increase the size of the file descriptor limit (handles more simultaneous connections)
ulimit -n 65535
echo "* soft nofile 65535" >> /etc/security/limits.conf
echo "* hard nofile 65535" >> /etc/security/limits.conf

# Step 3: Install and configure UFW firewall
echo "Configuring Uncomplicated Firewall (UFW)..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw status verbose
ufw enable

# Step 4: Enable and configure Fail2Ban (Intrusion Prevention)
echo "Configuring Fail2Ban to block brute force attacks..."
systemctl enable fail2ban
systemctl start fail2ban

# Step 5: Secure SSH - Disable root login and use strong encryption
echo "Securing SSH..."
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Step 6: Install and configure Lynis for system auditing
echo "Installing Lynis for security auditing..."
apt install lynis -y
lynis audit system

# Step 7: Install system monitoring tools
echo "Installing system monitoring tools (htop, nmap)..."
apt install -y htop nmap

# Step 8: Set strong password policies
echo "Setting strong password policies..."
echo "PASS_MIN_DAYS 7" >> /etc/login.defs
echo "PASS_MAX_DAYS 90" >> /etc/login.defs
echo "PASS_WARN_AGE 7" >> /etc/login.defs

# Step 9: Secure file permissions
echo "Securing file permissions..."
chmod 700 /root
chmod 755 /home
chmod 755 /etc

# Step 10: Limit core dumps to prevent exploitation
echo "Disabling core dumps to prevent sensitive data leakage..."
echo "*    soft    core    0" >> /etc/security/limits.conf

# Step 11: Configure automatic security updates
echo "Configuring automatic security updates..."
apt install unattended-upgrades -y
dpkg-reconfigure unattended-upgrades

# Step 12: Clean up and remove unnecessary packages
echo "Cleaning up unnecessary packages..."
apt autoremove --purge -y

# Step 13: Install tools for pentesting/monitoring (optional)
echo "Installing nmap and net-tools for penetration testing and monitoring..."
apt install -y nmap net-tools

# Step 14: Disable IPv6 if not needed
echo "Disabling IPv6 (if not required)..."
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Step 15: Final system audit (Optional)
echo "Running final system audit..."
lynis audit system

echo "Overpowered Linux setup completed successfully!"
