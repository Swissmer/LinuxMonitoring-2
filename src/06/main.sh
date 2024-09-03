#!/bin/bash

# main variables
LOGS="../logs/"

# main function
function checkLogs {
    local STATUS=1
    for i in {1..5}
    do
        if [[ ! -f "${LOGS}04_log_$i.log" ]];
        then
            STATUS=0
            break
        fi
    done
    echo $STATUS
}

# main condition
if [[ $( checkLogs ) -eq 1 ]]
then
    goaccess ${LOGS}04_log_*.log --log-format=COMBINED --time-format=%T -o report.html
else
    echo "Create logs from part 4!" 
fi
