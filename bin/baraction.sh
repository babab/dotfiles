#!/bin/bash
# baraction.sh script for spectrwm status bar

SLEEP_SEC=10
COUNT=0
while :; do
    let COUNT=$COUNT+1
    let MINUTES="$COUNT/6"
    echo -n "$(uname -r) || "
    echo -n "$(cat /proc/loadavg | awk '{ print $1" "$2" "$3 }') || "
    echo -n "$(sensors | grep temp1 | awk '{ print $2 }') "
    echo -n "$(sensors | grep Core0 | awk '{ print $3 }') "
    echo -n "$(sensors | grep Core1 | awk '{ print $3 }') || "
    echo "${MINUTES}m"
    sleep $SLEEP_SEC
done
