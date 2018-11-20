#!/bin/bash
# baraction.sh script for spectrwm status bar

battinfo()
{
    out="$(acpi -b | sed -e 's/^Battery 0: //' -e 's/, / | /g')"

    case $out in
    Discharging*)
        echo -n "BATT | "
        echo "$out" | sed 's/^.*Discharging | //'
        ;;
    Charging*)
        echo -n "CHARGING | "
        echo "$out" | sed 's/^.*Charging | //'
        ;;
    Unknown*)
        echo "$out" | sed 's/^.*Unknown | //'
        ;;
    *)
        echo "$out"
        ;;
    esac
}

ipaddress()
{
    echo $(ip addr | grep 'inet ' | tail -1 | sed -e 's/inet //' -e 's/\/24.*//')
}

SLEEP_SEC=30
COUNT=0
while :; do
    let COUNT=$COUNT+1
    let MINUTES="$COUNT/2"
    echo "${MINUTES}m | $(battinfo) | $(ipaddress)"
    sleep $SLEEP_SEC
done
