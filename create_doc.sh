#!/bin/bash

NC='\033[0m' # No Color
RED='\033[0;91m'
GREEN='\033[0;32m'
SLASH=""
FOLDER=""
ALL=0
NOPARAM="No parameters"
NODIR="No directiory"
echo $mypath
if [ -z "$1" ]
then
    echo $NOPARAM
else
    # finding folnder name
    i=1
    
    count=$#
    while [ $i -le $# ]
    do
        if [ ${!i} == "-a" ]
        then
            ALL=1
            count=$(($count-1))
        fi

        if [ ${!i} == "-d" ]
        then
            count=$(($count-1))
            l=$(($i+1))
            if [ ! -z ${!l} ]
            then
                FOLDER=${!l}
                count=$(($count-1))
                SLASH="/"
                #echo $FOLDER
            else
                echo $NODIR
                exit 0
            fi    
        fi
        i=$(($i + 1))
    done

    if [ $ALL -eq 1 ]
    then
        if [ -z $FOLDER ]
        then
            ls /usr/bin/ | tr "\n" " " | xargs -t ./create_pdf.sh
        else
            ls /usr/bin/ | tr "\n" " " | xargs -t ./create_pdf.sh -d $FOLDER
        fi
        exit 0
    fi

    if [ $count -eq 0 ]
    then
        echo $NOPARAM
        exit 0
    fi
    # create new FOLDER
    if [ ! -z $FOLDER ] && [ ! -d $FOLDER ]
    then
        mkdir -p $FOLDER
    fi

    # create pdfs
    i=1
    j=1
    while [ $i -le $#  ]
    do
        if [ ${!i} == "-d" ]
        then
            i=$(($i+2)) 
            continue 
        fi

        man -t ${!i} | ps2pdf -> "$FOLDER$SLASH${!i}.pdf"
        echo -e "$RED$j$NC of $RED$count$NC: created $GREEN$FOLDER$SLASH${!i}.pdf$NC" 
        i=$(($i + 1))
        j=$(($j + 1))
    done
fi 
