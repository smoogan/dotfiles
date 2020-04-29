#!/usr/bin/env bash

BRIGHTNESS=`brightnessctl --class=backlight get`
if [ $BRIGHTNESS -eq 0 ]; then
    brightnessctl --restore
else
    brightnessctl --save
    brightnessctl --class=backlight set 0
fi
