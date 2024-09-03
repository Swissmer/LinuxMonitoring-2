#!/bin/bash

LOGS="../logs/02.log"

# main circle
grep -E "${2}|${1}" $LOGS | grep "create dir" | awk '{print $5}' | while read -r dir_name; do
    rm -rf "$dir_name"
done

# info
echo "Done!"