vga=0
xrandr | grep VGA1 | grep disconnected
if [ $? -ne 0 ]; then
    vga=1
    xrandr --output VGA1 --mode 1280x1024 --above eDP1
fi

xrandr | grep HDMI1 | grep disconnected
if [ $? -ne 0 ]; then
    if [ $vga -eq 1 ]; then
        xrandr --output HDMI1 --mode 1280x1024 --right-of VGA1
    else
        xrandr --output HDMI1 --mode 1280x1024 --above eDP1
    fi
fi

setxkbmap -layout us -option ctrl:nocaps
xbindkeys
pulseaudio --start
/usr/bin/xscreensaver -no-splash &
/usr/bin/dunst &
random-wallpaper

wm=spectrwm
#wm=openbox

ssh-add -l
if [ $? -lt 2 ]; then
    exec $wm
else
    exec ssh-agent $wm
fi


# vim: set ft=sh:
