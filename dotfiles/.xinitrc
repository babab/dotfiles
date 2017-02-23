# monitors / screens
xrandr --output eDP-0 --mode 1366x768
#xrandr --output HDMI-0 --mode 1280x1024 --above eDP-0

# startup daemons
setxkbmap -layout us -option ctrl:nocaps
xbindkeys
pulseaudio --start
/usr/bin/xscreensaver -no-splash &
/usr/bin/dunst &
redshift &

# init user settings
random-wallpaper
synclient TouchpadOff=1

# window manager w/ ssh-agent
wm=spectrwm
#wm=openbox

ssh-add -l
if [ $? -lt 2 ]; then
    exec $wm
else
    exec ssh-agent $wm
fi

# vim: set ft=sh:
