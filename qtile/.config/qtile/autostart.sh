#! /bin/bash 
xrandr --newmode "1920x1080_60.0" 172.80 1920 2040 2248 2576 1080 1081 1084 1118 -HSync +Vsync \
	&& xrandr --addmode Virtual1 "1920x1080_60.0" \
	&& xrandr --output Virtual1 --primary --mode "1920x1080_60.0" --pos 0x0 --rotate normal &
lxsession &
picom --experimental-backends &
nitrogen --restore &
# urxvtd -q -o -f &
# /usr/bin/emacs --daemon &
# volumeicon &
# nm-applet &
