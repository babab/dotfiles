#!/bin/sh

if [ -x /usr/local/bin/scrot ]; then
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

screenshot()
{
	case $1 in
	full)
		scrot -m "$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png"
		;;
	window)
		sleep 1
		scrot -s "$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png"
		;;
	*)
		;;
	esac;
}

screenshot $1
