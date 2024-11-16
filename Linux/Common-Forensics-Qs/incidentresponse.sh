#!/bin/bash

# Collect system information
date
uptime
whoami
hostname
uname -a

# Collect network information
ifconfig
netstat -anp

# Collect process information
ps aux

# Collect file system information
df -h
du -sh /

# Collect log files
cp /var/log/syslog /var/log/auth.log /var/log/secure incident_response_logs

# Create a forensic image of a disk or partition
dd if=/dev/sda1 of=disk_image.img bs=4096 conv=noerror,sync
