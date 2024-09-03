#!/bin/bash

# main error
if [ "$#" -ne 6 ];
then
    echo "Incorrect number of parameters."
    exit 1
fi

# (parametr $1) directory does not exist
if [ ! -d $1 ];
then
    echo "$0: $1: directory does not exist!"
    exit 1
fi

# (parametr $2) error number
if ! [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
    echo "$0: $2: error number of directory number!"
    exit 1
fi

# (parametr $3) letter not from the alphabet
if [[ ! $3 =~ ^[A-Za-z]+$ ]];
then
    echo "$0: $3: value error!"
    exit 1
fi

# (parametr $3) number of letters
if [[ ! $3 =~ ^[A-Za-z]{1,7}$ ]];
then
    echo "$0: $3: value error! (number of letters)"
    exit 1
fi

# (parametr $4) error number
if ! [[ "$4" =~ ^[1-9][0-9]*$ ]]; 
then
    echo "$0: $4: error number of directory number!"
    exit 1
fi

# (parametr $5) letter not from the alphabet
if [[ ! $5 =~ ^[A-Za-z]+\.[A-Za-z]+$ ]];
then
    echo "$0: $5: value error!"
    exit 1
fi

# (parametr $5) number of letters
if [[ ! $5 =~ ^[A-Za-z]{1,7}\.[A-Za-z]{1,3}$ ]];
then
    echo "$0: $5: value error! (number of letters)"
    exit 1
fi

# (parametr $6) correct value
if [[ !("$6" =~ ^[1-9][0-9]*kb$) ]];
then
    echo "$0: $6: value error!"
    exit 1
fi

# (parametr $6) value < 100
if [[ ${6%*kb} -gt 100 ]]
then
    echo "$0: $6: value error! (more than 100)"
    exit 1
fi