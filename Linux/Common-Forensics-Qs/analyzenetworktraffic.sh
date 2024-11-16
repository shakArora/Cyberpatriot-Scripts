#!/bin/bash

# Capture network traffic for 10 minutes
tcpdump -i eth0 -w capture.pcap -n -t -s 0 -W 1 -C 100

# Analyze the captured packet with Wireshark
wireshark capture.pcap
