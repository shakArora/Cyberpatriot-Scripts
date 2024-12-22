#!/usr/bin/env bash
sudo apt update && sudo apt upgrade
#This main script will be for putting all of the state round stuff into
#Default Display Manager

#DUTIES: 
#SHIVUM - DISPLAY MANAGER AND SERVICES LIKE APACHE/SAMBA
#JASRAJ - USERS IF POSSIBLE, IPV4 FORWARDING, UPDATES, OPENSSH, DISABLE FTP ANONYMOUS ACCESS

echo "LightDM (1) or GDM3 (2) or SDDM (3)"
#read -p displaymanager
#if [["$displaymanager" = "1"]]
#then 
#echo "updating LightDM"
#sudo apt install lightdm
#elif
#then
#elif 
#fi

users() {
  $i = 1
  echo "All Admin (Sudo) Users: "
  getent group sudo
  
  if [1 == $i]; then
      read -p "Unwanted user: (to exit type 00) " $USER
      if [ "$USER" != "00" ]; then
          sudo deluser $USER
      else
          echo "Exiting process."
          $i = 0
      fi
  fi
}

