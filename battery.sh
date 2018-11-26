#!/bin/bash

num=0
full=0
NONUM="No battery number"
UNPARAM="Undefined parameter"
GREPPARAMS=

if [ -z $1 ]
then
    echo "empty"
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "native-path|model|serial|^battery$|energy:|energy-full|energy-rate|percentage|capacity|state"
    exit 0
fi

i=1
count=$#
while [ $i -le $# ]
do
    case ${!i} in
    -f*)  full=1
            echo "full"
    ;;
    -n*)  l=$(($i+1))
            if [ ! -z ${!l} ]
            then
                num=${!l}
                i=$(($i+1))
            else
                echo $NONUM
                exit 0
            fi  
    ;;
    *)    echo $UNPARAM ${!i}
            exit 1
    ;;
    esac
    i=$(($i+1))
done

if [ $full == 1 ]
then
    upower -i /org/freedesktop/UPower/devices/battery_BAT$num
else
    upower -i /org/freedesktop/UPower/devices/battery_BAT$num | grep -E "native-path|model|serial|^\ \ battery$|energy:|energy-full|energy-rate|percentage|capacity|state"
fi