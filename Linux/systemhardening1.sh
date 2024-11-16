#!/bin/bash

echo "Disabling unnecessary services..."
services_to_disable=(
    "cups"   # Printer service
    "avahi-daemon" # mDNS service
    "bluetooth" # Bluetooth service
)

for service in "${services_to_disable[@]}"; do
    sudo systemctl disable $service
    sudo systemctl stop $service
    echo "$service disabled and stopped."
done

echo "Only essential services are running."
