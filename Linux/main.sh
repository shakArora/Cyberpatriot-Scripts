#!/usr/bin/env bash
sudo apt update && sudo apt upgrade
#This main script will be for putting all of the state round stuff into
#Default Display Manager
echo "LightDM (1) or GDM3 (2) or SDDM (3)"
read -p displaymanager
if [["$displaymanager" = "1"]]
then 

echo "updating LightDM"
sudo apt install lightdm
elif
then
elif 
fi
