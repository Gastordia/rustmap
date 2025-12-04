#!/bin/bash

if [ -z $1 ]; then 
   echo "Usage: $0 <ip>"
   exit 1
fi 

IP="$1"
output_file="${IP}.txt"

output_rustscan=$(rustscan -a "$IP" 2> /dev/null | grep "Open ")
ports=$(echo "$output_rustscan" | cut -d: -f2 | paste -sd "," - )

if [ -z ports]; then 
   echo "no open ports are found"
   exit 2
fi 
echo "Open Ports: $ports"
echo
echo "running nmap now ..."
echo 

nmap -sC -sV -p "$ports" "$IP" -oN "$output_file"
echo 
echo "result saved to $output_file"


