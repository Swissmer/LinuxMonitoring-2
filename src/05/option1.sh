#!/bin/bash

for i in {1..5}
do
    echo "File: ../logs/04_log_$i.log"
    echo "========="
    awk '{print $0}' ../logs/04_log_$i.log | sort -k 10
    echo "========="
done
