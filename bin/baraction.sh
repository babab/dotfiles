#!/bin/sh
# baraction.sh script for spectrwm status bar

battinfo() {
    out="$(acpi -b | sed -e 's/^Battery 0: //' -e 's/, / | /g')"

    case $out in
    Discharging*)
        printf "BATT | "
        echo "$out" | sed 's/^.*Discharging | //'
        ;;
    Charging*)
        printf "CHARGING | "
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

ipaddress() {
    ip addr | grep 'inet ' | tail -1 | sed -e 's/inet //' -e 's/\/24.*//'
}

SLEEP_SEC=30
COUNT=0
while :; do
    COUNT=$((COUNT+1))
    MINUTES=$((COUNT/2))
    echo "${MINUTES}m | $(battinfo) | $(ipaddress)"
    sleep $SLEEP_SEC
done
