sudo lsof -nP -iTCP -sTCP:LISTEN #Ports in use
sudo lsof -nP -i:[port-number] #If needed to check a specific number
sudo netstat -tup #display all ports
sudo ss -tunl #more stats than netstat
sudo nmap -n -PN -sT -sU -p- localhost #check other systems if needed
nc -z -v localhost 1-65535 #scan all local ports
nc -z -v -u localhost 1-65535 2>&1 | grep succeeded #tcp and udp scan
