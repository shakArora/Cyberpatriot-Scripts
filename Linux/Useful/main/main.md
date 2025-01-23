## CyberPatriot Scripts for Linux Mint and Ubuntu

### Known Vulnerabilities: 

**Account Policy**

```bash 
    sudo sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
    sudo sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   7/' /etc/login.defs
    sudo sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE   7/' /etc/login.defs
    sudo sed -i 's/^UMASK.*/UMASK 027/' /etc/login.defs
```

**Application Security**

```bash 
    sudo apt update
    sudo apt upgrade -y
    sudo apt install unattended-upgrades -y
    sudo dpkg-reconfigure --priority=low unattended-upgrades
```

**Defensive Countermeasures**

```bash 
    sudo ufw enable
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
```
**Local Policy**

```bash 
    sudo chmod 700 /home/*
    sudo chown root:root /etc/passwd /etc/shadow /etc/group /etc/gshadow
```

**Malware**

```bash 
    sudo apt install clamav clamav-daemon -y
    sudo freshclam
    sudo systemctl enable clamav-freshclam
    sudo systemctl start clamav-freshclam
```

```bash 
    sudo apt install lynis -y
    sudo lynis audit system | tee /var/log/lynis-report.log
```

**Operating System Updates**

```bash 
    sudo apt install unattended-upgrades -y
    sudo dpkg-reconfigure --priority=low unattended-upgrades
```

- The rest must be completed manually through the Software Updater App, without changing the version of the OS. This means that Linux Mint 22.1 should not be upgraded to Linux Mint 22.2 and Ubuntu 22.04 should not be upgraded to Ubuntu 24.04

**Prohibited Files**

```bash 
    for file in /tmp/* /var/tmp/*; do
    if [[ $(basename "$file") =~ .*\.sh$ ]]; then
        echo "Prohibited file found: $file"
    fi
    done
```

- The files must be deleted graphically or through the terminal. If you would like to search for hidden files, open the file explorer (nautilus) and then use the shortcut Ctrl + h to show them. Finally, we should check for malware before doing this, because malware could easily install prohibited files on the machine, even after they are deleted once. 

**Service Auditing**

```bash 
    sudo systemctl list-units --type=service --state=running
```

**Unwanted Software**

```bash 
    sudo apt autoremove
```

- The rest of this task must be done manually, by removing games and other unwanted apps


**User Auditing**

```bash 
    sudo awk -F: '{ if ($3 < 1000) print $1 }' /etc/passwd
    sudo deluser <unwanted user>
    sudo deluser <user> sudo
    sudo usermod -aG sudo <user>
```

----

### How to execute a shell script: 

```bash 
    chmod +x main.sh
    ./main.sh
```