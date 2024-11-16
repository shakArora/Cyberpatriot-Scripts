cd /
#clam antivirus 
# sudo apt update && sudo apt upgrade
sudo apt install clamav clamtk
sudo freshclam
sudo clamscan
#root kit hunter
sudo apt update && sudo apt upgrade
sudo apt install rkhunter
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
