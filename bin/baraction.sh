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
        echo -n "ONLINE | "
        echo "$out" | sed 's/^.*Charging | //'
        ;;
    *)
        echo "$out"
        ;;
    esac
}

SLEEP_SEC=10
COUNT=0
while :; do
    let COUNT=$COUNT+1
    let MINUTES="$COUNT/6"
    echo -n "$(uname -r)   "
    echo "${MINUTES}m   "
    echo "$(battinfo)   "
    sleep $SLEEP_SEC
done
