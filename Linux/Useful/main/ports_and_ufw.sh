#!/bin/bash

function is_port_open() {
    nc -z localhost $1 >/dev/null 2>&1
    return $?
}

ports_to_check=(22 80 443 8080 3306 21 25)

if ! ufw status >/dev/null 2>&1; then
    sudo ufw enable
fi

for port in "${ports_to_check[@]}"; do
    if is_port_open $port; then
        echo "Port $port is open.”

        sudo ufw deny $port/tcp
    else
        echo "Port $port is closed."
done

sudo ufw allow 22/tcp

sudo ufw status
