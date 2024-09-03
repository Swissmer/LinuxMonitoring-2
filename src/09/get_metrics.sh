#!/bin/bash

if [[ -f index.html ]];
then 
    rm -rf index.html
else
    touch index.html
fi

exec 1>./index.html

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
ram_used=$(free | grep Mem | awk '{print $3}')
mem_size=$(df / | grep / |  awk '{print $2}')
mem_used=$(df / | grep / |  awk '{print $3}')

echo -e "cpu_usage $cpu_usage\n"    # CPU
echo -e "ram_used $ram_used\n"      # RAM
echo -e "mem_size $mem_size\n"      # MEMORY SIZE
echo -e "mem_used $mem_used\n"      # MEMORY USED  
