#!/bin/bash

ERROR="usage: [PARAMETR]\n(1 - SORT BY ANSWER CODE,\n 2 - ALL UNIQUE IP,\n 3 - REQUESTS WITH ERROR,\n 4 - UNIQUE IP AMONG ERRORS)"

if [[ "$#" -eq 1 ]]
then
    case $1 in 
    1) ./option1.sh;;
    2) ./option2.sh;;
    3) ./option3.sh;;
    4) ./option4.sh;;
    *) echo -e $ERROR ;;
    esac
else
    echo -e $ERROR
fi