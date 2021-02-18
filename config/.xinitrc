#!/usr/bin/env bash

export _JAVA_AWT_WM_NONREPARENTING=1 # java gray window

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &

xset r rate 300 50 # xset r rate delay_before_autorepeat [repeat_rate]
sleep 3 && xmodmap -e 'clear lock' -e 'add control = Caps_Lock' -e 'keycode 0x42 = Control_L' &

# dwmblocks &
dwm # ssh-agent dwm
