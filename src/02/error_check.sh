#!/bin/bash

# main error
if [ "$#" -ne 3 ];
then
    echo "Incorrect number of parameters."
    exit 1
fi

# (parametr $1) letter not from the alphabet
if [[ ! $1 =~ ^[A-Za-z]+$ ]];
then
    echo "$0: $1: value error!"
    exit 1
fi

# (parametr $1) number of letters
if [[ ! $1 =~ ^[A-Za-z]{1,7}$ ]];
then
    echo "$0: $1: value error! (number of letters)"
    exit 1
fi

# (parametr $2) letter not from the alphabet
if [[ ! $2 =~ ^[A-Za-z]+\.[A-Za-z]+$ ]];
then
    echo "$0: $2: value error!"
    exit 1
fi

# (parametr $2) number of letters
if [[ ! $2 =~ ^[A-Za-z]{1,7}\.[A-Za-z]{1,3}$ ]];
then
    echo "$0: $2: value error! (number of letters)"
    exit 1
fi

# (parametr $3) correct value
if [[ !("$3" =~ ^[1-9][0-9]*Mb$) ]];
then
    echo "$0: $3: value error!"
    exit 1
fi

# (parametr $3) value < 100
if [[ ${3%*Mb} -gt 100 ]]
then
    echo "$0: $3: value error! (more than 100)"
    exit 1
fi