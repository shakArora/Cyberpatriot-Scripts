#!/usr/bin/env bash
# CyberPatriot XVII Interactive Security Hardening Script for Ubuntu/Mint
# By: ChatGPT on Jan 24 2025

# Logging the execution start
echo "[INFO] Starting system hardening at $(date)" >> /var/log/cyberpatriot_hardening.log

# Function for error handling
error_exit() {
    echo "[ERROR] $1"
    echo "[ERROR] $1" >> /var/log/cyberpatriot_hardening.log
    exit 1
}

# Function to prompt for user confirmation
prompt_yes_no() {
    read -p "$1 (y/n): " response
    case "$response" in
        [yY] | [yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

# 1. SYSTEM UPDATE AND ESSENTIAL PACKAGES
if prompt_yes_no "Do you want to update the system and install essential security packages (ufw, fail2ban, auditd, lynis, etc.)?"; then
    echo "[INFO] Updating the system..." >> /var/log/cyberpatriot_hardening.log
    sudo apt update && sudo apt upgrade -y || error_exit "System update failed"
    sudo apt install -y ufw fail2ban unattended-upgrades auditd lynis || error_exit "Package installation failed"
fi

# 2. CONFIGURING UFW FIREWALL
if prompt_yes_no "Do you want to configure the UFW firewall? (default deny incoming, allow outgoing, allow SSH)"; then
    echo "[INFO] Configuring UFW firewall..." >> /var/log/cyberpatriot_hardening.log
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw enable || error_exit "UFW configuration failed"
fi

# 3. CONFIGURING FAIL2BAN
if prompt_yes_no "Do you want to configure Fail2Ban to protect against SSH brute force attacks?"; then
    echo "[INFO] Configuring Fail2Ban..." >> /var/log/cyberpatriot_hardening.log
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban || error_exit "Fail2Ban failed to start"
fi

# 4. AUTOMATIC SECURITY UPDATES
if prompt_yes_no "Do you want to configure automatic security updates (unattended-upgrades)?"; then
    echo "[INFO] Configuring automatic security updates..." >> /var/log/cyberpatriot_hardening.log
    sudo dpkg-reconfigure --priority=low unattended-upgrades || error_exit "Unattended upgrades configuration failed"
fi

# 5. STRONG PASSWORD POLICIES
if prompt_yes_no "Do you want to enforce strong password policies (min length 14, complexity)?"; then
    echo "[INFO] Enforcing strong password policies..." >> /var/log/cyberpatriot_hardening.log
    sudo apt install -y libpam-cracklib || error_exit "Password policy package installation failed"
    echo "password requisite pam_cracklib.so retry=3 minlen=14 difok=4" | sudo tee -a /etc/pam.d/common-password || error_exit "Password policy configuration failed"
fi

# 6. DISABLE ROOT LOGIN VIA SSH
if prompt_yes_no "Do you want to disable root login via SSH?"; then
    echo "[INFO] Disabling root login via SSH..." >> /var/log/cyberpatriot_hardening.log
    sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config || error_exit "SSH root login disable failed"
    sudo systemctl restart ssh || error_exit "SSH service restart failed"
fi

# 7. DISABLE UNUSED SERVICES
if prompt_yes_no "Do you want to disable unnecessary services (apache2, cups, bluetooth)?"; then
    echo "[INFO] Disabling unnecessary services..." >> /var/log/cyberpatriot_hardening.log
    for service in apache2 cups bluetooth; do
        sudo systemctl disable $service || true
        sudo systemctl stop $service || true
        echo "[INFO] Disabled $service service" >> /var/log/cyberpatriot_hardening.log
    done
fi

# 8. SET PROPER FILE PERMISSIONS
if prompt_yes_no "Do you want to set secure file permissions for critical directories (/root, /home/*)?"; then
    echo "[INFO] Setting correct file permissions..." >> /var/log/cyberpatriot_hardening.log
    sudo chmod 700 /root || error_exit "Failed to set permissions for /root"
    sudo chmod 755 /home/* || error_exit "Failed to set permissions for user directories"
fi

# 9. CONFIGURE SYSTEM AUDIT LOGGING (Auditd)
if prompt_yes_no "Do you want to enable system auditing (auditd)?"; then
    echo "[INFO] Enabling system auditing..." >> /var/log/cyberpatriot_hardening.log
    sudo systemctl enable auditd
    sudo systemctl start auditd || error_exit "Auditd failed to start"
fi

# 10. REMOVE UNUSED USER ACCOUNTS
if prompt_yes_no "Do you want to remove unused user accounts?"; then
    echo "[INFO] Removing unused user accounts..." >> /var/log/cyberpatriot_hardening.log
    for user in $(awk -F: '{ print $1 }' /etc/passwd); do
        last_login=$(lastlog -u $user | tail -n 1)
        if [[ $last_login == *Never* ]]; then
            sudo userdel -r $user
            echo "[INFO] Removed unused user: $user" >> /var/log/cyberpatriot_hardening.log
        fi
    done
fi

# 11. DISABLE IP FORWARDING
if prompt_yes_no "Do you want to disable IP forwarding (to prevent the system from routing traffic)?"; then
    echo "[INFO] Disabling IP forwarding..." >> /var/log/cyberpatriot_hardening.log
    sudo sysctl -w net.ipv4.ip_forward=0 || error_exit "Failed to disable IP forwarding"
    echo "net.ipv4.ip_forward=0" | sudo tee -a /etc/sysctl.conf || error_exit "Failed to configure sysctl for IP forwarding"
fi

# 12. DISABLE CORE DUMPS
if prompt_yes_no "Do you want to disable core dumps (to prevent sensitive data leakage)?"; then
    echo "[INFO] Disabling core dumps..." >> /var/log/cyberpatriot_hardening.log
    echo "fs.suid_dumpable = 0" | sudo tee -a /etc/sysctl.conf || error_exit "Failed to disable core dumps"
    sudo sysctl -p || error_exit "Sysctl reload failed"
fi

# 13. CONFIGURE AIDE (ADVANCED INTRUSION DETECTION)
if prompt_yes_no "Do you want to install and configure AIDE (Advanced Intrusion Detection Environment)?"; then
    echo "[INFO] Installing and configuring AIDE..." >> /var/log/cyberpatriot_hardening.log
    sudo apt install -y aide || error_exit "AIDE installation failed"
    sudo aideinit || error_exit "AIDE initialization failed"
fi

# 14. RUN LYNIS SECURITY AUDIT
if prompt_yes_no "Do you want to run a security audit using Lynis?"; then
    echo "[INFO] Running Lynis security audit..." >> /var/log/cyberpatriot_hardening.log
    sudo lynis audit system || error_exit "Lynis audit failed"
fi

# 15. SYSTEM REBOOT
if prompt_yes_no "Do you want to reboot the system now to apply all changes?"; then
    echo "[INFO] System configuration complete. Rebooting system..." >> /var/log/cyberpatriot_hardening.log
    sudo reboot
fi

: 'Make it executable:
chmod +x cyberpatriot_hardening.sh
Run the script:
sudo ./cyberpatriot_hardening.sh
To run Lynis audit or reboot at the end, you can use the flags:
sudo ./cyberpatriot_hardening.sh --audit      # For Lynis audit
sudo ./cyberpatriot_hardening.sh --reboot     # For reboot'