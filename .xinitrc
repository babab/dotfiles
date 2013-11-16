#xrandr --output HDMI1 --pos 1920x0 --left-of VGA1
#xrandr --output LVDS1 --mode 1920x1080
setxkbmap -layout us -option ctrl:nocaps
xbindkeys
pulseaudio --start
/usr/bin/xscreensaver -no-splash &
/usr/bin/dunst &

wm=spectrwm

ssh-add -l
if [ $? -lt 2 ]; then
    exec $wm
else
    exec ssh-agent $wm
fi
