#!/bin/bash

# date verification
function checkDate {
    # Date
    if [[ ! $1 =~ ^([0-2]?[0-9]|3[01])\.([0]?[1-9]|1[0-2])\.[0-9]{4}$ ]];
    then
        echo 3
    # Clock
    elif [[ ! $2 =~ ^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$ ]]; then
        echo 2
    else
        echo 1
    fi
}

# name verification
function checkName {
    if [[ $1 =~ ^[A-Za-z]{1,}_[0-9]{6}$ ]];
    then 
        echo 1
    else
        echo 0
    fi
}

# main condition
if [[ "$1" -eq 1 ]] && [[ "$#" -eq 1 ]];                    # parametr 1
then
    ./option1.sh
elif [[ "$1" -eq 2 ]];                                      # parametr 2
then
    if [[ "$#" -eq 3 ]] && [[ $(checkDate $2 $3) -eq 1 ]];
    then
        ./option2.sh $2 $3
    else
        echo "usage: $0 2 [DATE](xx.xx.xxxx) [CLOCK](xx:xx)"
    fi
elif [[ "$1" -eq 3 ]];                                      # parametr 3
then
    if [[ "$#" -eq 2 ]] && [[ $( checkName $2 ) -eq 1 ]];
    then
        ./option3.sh $2
    else
        echo "usage: $0 3 [DIR/FILE_NAME](..._xxxxxx)"
    fi
else 
    echo "usage: $0 [PARAMETR](1 - LOGS|2 - DATE|3 - NAME)"
fi