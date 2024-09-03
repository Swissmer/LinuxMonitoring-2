#!/bin/bash

# main variables
DIR_PATH=$1
if [ "${DIR_PATH: -1}" != '/' ];
then
    DIR_PATH=${DIR_PATH}'/'
fi
DIR_NUM=$2
DIR_NAME=$3
FILE_NUM=$4
FILE_SIZE=${6%*Mb}
FILE_NAME_ALL=$5

# variables for the program
FILE_NAME=${FILE_NAME_ALL%.*}
DATE=$(date +"_%d%m%y")
LOGS="../logs/02.log"
FREE_SIZE=$(df -h -BM / | awk '{printf "%d", $4}' | sed 's/^0*//')
FILE_NAME_END=${FILE_NAME_ALL#*.}
DIR_FIRST_CHAR=${DIR_NAME:0:1}
FILE_FIRST_CHAR=${FILE_NAME:0:1}

# transformation
while [ ${#DIR_NAME} -lt 4 ];
do
    DIR_NAME=${DIR_FIRST_CHAR}${DIR_NAME}
done

while [ ${#FILE_NAME} -lt 4 ];
do
    FILE_NAME=${FILE_FIRST_CHAR}${FILE_NAME}
done

# main round
while [[ "$DIR_NUM" -gt 0 ]];
do
    # if there is a folder
    if [[ -d ${DIR_PATH}${DIR_NAME}${DATE} ]];
    then
        rm -rf ${DIR_PATH}${DIR_NAME}${DATE}
    fi

    # create dir
    mkdir ${DIR_PATH}${DIR_NAME}${DATE} 2> /dev/null

    if [[ -d ${DIR_PATH}${DIR_NAME}${DATE} ]];
    then
        echo "$(date +"%H:%M:%S %d.%m.%Y"): create dir ${DIR_PATH}${DIR_NAME}${DATE}" >> $LOGS
    else
        break
    fi
    
    # variables for cycle
    VALUE_NAME=${FILE_NAME}
    VALUE_NUM=${FILE_NUM}

    # 1048576 - this is the size in bytes
    while [[ ${VALUE_NUM} -gt 0 ]] && [[ "$FREE_SIZE - $FILE_SIZE" -gt 1000 ]];
    do
        # create file
        fallocate -l ${FILE_SIZE}MB ${DIR_PATH}${DIR_NAME}${DATE}/${VALUE_NAME}\.${FILE_NAME_END}
        if [[ -f ${DIR_PATH}${DIR_NAME}${DATE}/${VALUE_NAME}\.${FILE_NAME_END} ]];
        then
        	echo "$(date +"%H:%M:%S %d.%m.%Y"): create file ${DIR_PATH}${DIR_NAME}${DATE}/${VALUE_NAME}\.${FILE_NAME_END}" >> $LOGS
        fi
        VALUE_NAME=${FILE_FIRST_CHAR}${VALUE_NAME}
        VALUE_NUM=$((${VALUE_NUM} - 1))
        FREE_SIZE=$(df -h -BM / | awk '{printf "%d", $4}' | sed 's/^0*//')
    done
    
    if [[ $FREE_SIZE -le 1000 ]];
    then
        break
    fi
    DIR_NAME=${DIR_FIRST_CHAR}${DIR_NAME}
    DIR_NUM=$((${DIR_NUM} - 1))
done
