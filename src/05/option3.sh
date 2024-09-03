#!/bin/bash

for i in {1..5}
do
    echo "File: ../logs/04_log_$i.log"
    echo "========="
    awk '$10 ~ /^4|5/ {print $0}' ../logs/04_log_$i.log
    echo "========="
done
