# monitors / screens
#xrandr --output HDMI-0 --mode 1280x1024 --above eDP-0
# xrandr --output eDP-1 --mode 1366x768
# xrandr --output VGA-1 --mode 1280x1024 --left-of eDP-1

# startup daemons
# swap caps-lock and escape key
setxkbmap -layout us -option "caps:escape"
xbindkeys
/usr/bin/xscreensaver -no-splash &
/usr/bin/dunst &
pgrep redshift &> /dev/null || redshift -l 52.09083:5.12222 &> /dev/null &
# pulseaudio --start


# init user settings
random-wallpaper
synclient TouchpadOff=1

# window manager w/ ssh-agent
if [ -f "$HOME/.config/currentwm" ]; then
    wm=$(cat $HOME/.config/currentwm)
else
    wm=spectrwm
fi

ssh-add -l
if [ $? -lt 2 ]; then
    exec $wm
else
    exec ssh-agent $wm
fi

# vim: set ft=sh:
