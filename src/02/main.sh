#!/bin/bash

START_TIME=$(date +%s)
START=$(date)
DIR_NAME=$1
FILE_NAME=$2
FILE_SIZE=$3
LOGS="../logs/02.log"

source error_check.sh $DIR_NAME $FILE_NAME $FILE_SIZE

# function
function dir_filter {
    name=$1
    if [[ $name = *"/bin"* ]] || [[ $name = *"/sbin"* ]] ||
        [[ $name = *"/boot"* ]] || [[ $name = *"/dev"* ]] ||
        [[ $name = *"/proc"* ]] || [[ $name = *"/sys"* ]] ||
        [[ $name = *".git"* ]] || [[ $name = *"/run"* ]] ||
        [[ $name = *"/snap"* ]] || [[ $name = *"/root"* ]];
    then
        echo "0"
    else
        echo "1"
    fi
}

# main circle
for dir in `find / -type d 2> /dev/null`
do
    if [[ $( dir_filter $dir ) -eq 1 ]];
    then
        DIR_NUM=$((1 + RANDOM % 100))
        FILE_NUM=$((1 + RANDOM % 100))
        ./create_files.sh $dir $DIR_NUM $DIR_NAME $FILE_NUM $FILE_NAME $FILE_SIZE
        FREE_SIZE=$(df -h -BM / | awk '{printf "%d", $4}' | sed 's/^0*//')
    fi
    if [[ $FREE_SIZE -le 1000 ]]
    then
        break
    fi
done

END_TIME=$(date +%s)
END=$(date)
TIME_DELTA=$(($END_TIME - $START_TIME))
TIME_LOGS=$(
    echo "start time: $START, end time: $END, delta time: $TIME_DELTA" 
)
echo "$TIME_LOGS"
echo "$(date +"%H:%M:%S %d.%m.%Y"): ${TIME_LOGS}" >> $LOGS
