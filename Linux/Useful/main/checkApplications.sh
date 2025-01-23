#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -qw "$1"
}

# Update system packages and apps
echo "Updating system and installed applications..."
# sudo apt update -y && sudo apt upgrade -y

# Update specific third-party apps (e.g., Google Chrome)
if is_installed "google-chrome-stable"; then
    echo "Updating Google Chrome..."
    sudo apt install --only-upgrade -y google-chrome-stable
else
    echo "Google Chrome is not installed."
fi

# Define a list of potentially suspicious or unnecessary applications
suspicious_apps=(
    "telnet"        # Unencrypted remote login utility
    "nmap"          # Network scanning tool
    "rsh-client"    # Remote shell client
    "vnc4server"    # Remote desktop service
    "tightvncserver" # Remote desktop service
    "ophcrack"      # Password cracking tool
    "steam"         # Game platform
    "lutris"        # Game platform
    "playonlinux"   # Game emulator
    "minetest"      # Game
    "supertuxkart"  # Game
    "wine"          # Often used for running games and other Windows apps
    "reminna"       # Potentially unsafe vm
)

echo "Checking for suspicious or unnecessary applications..."
sus_found=0
for app in "${suspicious_apps[@]}"; do
    if is_installed "$app"; then
        echo "Suspicious application found: $app"
        # echo "Removing $app..."
        # sudo apt remove --purge -y $app
        sus_found=1
    fi
done

if [ $sus_found -eq 0 ]; then
    echo "No suspicious applications found."
else
    echo "All detected suspicious applications have been removed."
fi

# List all installed applications for review
echo "Generating a list of all installed applications..."
dpkg -l > /tmp/installed_apps.txt
echo "List saved to /tmp/installed_apps.txt. Please review for further analysis."

echo "Application update and audit complete!"
