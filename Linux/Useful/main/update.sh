#!/usr/bin/env bash
sudo apt install nala
sudo nala update && sudo apt full-upgrade && sudo apt dist-upgrade
apt upgrade -a --upgradable
echo "Basic apt updates complete"
sudo snap refresh
echo "Snap updates completed"
echo "For version updates go to the 'software updater' and 'software and updates' apps by pressing the super and a keys. Then update all packages."
echo "Should I open Software Updater? (1 or 0)" 
read -p "To open it type 1 else type 0: " $open
if ["$open" == "1"]; then 
  update-manager
else
  echo "Exiting process"
fi
