#!/bin/bash


if [ -z "$1" ]
then
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "energy:|energy-full:|energy-rate|percentage|state|time\ to\ full|time\ to\ empty"
    exit 0
fi

if [ "$1" == "-f" ] || [ "$1" == "-full" ]
then
    upower -i /org/freedesktop/UPower/devices/battery_BAT0
else
    echo "undefined argument"
fi
