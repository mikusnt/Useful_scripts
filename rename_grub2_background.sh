#!/bin/bash

GRUB_BG_TEXT="GRUB_BACKGROUND"
TEMP_FILE="temp.txt"
function error_exit() {
    if [[ ! -z $1 ]]
    then
        echo $1", stopped"
    else
        echo "stopped"
    fi
    exit 1
}

if [ -z $1 ]
then
    error_exit "No new background file"
fi

cp $1 /boot/grub
if [ $? -ne 0 ]
then
    error_exit "Error on copy background"
fi

#vim /etc/default/grub
grep -v "$GRUB_BG_TEXT=" /etc/default/grub >> TEMP_FILE; echo "$GRUB_BG_TEXT='"/boot/grub/$1"'" >> TEMP_FILE; mv TEMP_FILE /etc/default/grub; update-grub
if [ $? -ne 0 ]
then
    error_exit "Error on rename background image in /etc/default/grub"
fi
