@echo off
echo ok securing passords now
net accounts /lockoutthreshold:5 /MINPWLEN:8 /MAXPWAGE:75 /MINPWAGE:7 /UNIQUEPW:7
@echo now manually set complexity requirement to enabled and reversible encryption to disabled
start secpol.msc /wait

@echo starting firewall stuff
netsh advfirewall set allprofiles state on
echo Firewall enabled
netsh advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no 
netsh advfirewall firewall set rule name="Telnet Server" new enable=no 
netsh advfirewall firewall set rule name="netcat" new enable=no
goto:EOF
