#xrandr --output HDMI1 --pos 1920x0 --left-of VGA1
setxkbmap -layout us -option ctrl:nocaps
/usr/bin/xscreensaver -no-splash &
/usr/bin/dunst &

ssh-add -l
if [ $? -lt 2 ]; then
    exec spectrwm
else
    exec ssh-agent spectrwm
fi
