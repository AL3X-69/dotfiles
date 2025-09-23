#!/bin/bash

MUTED="$(pamixer --get-mute)"

if [[ $MUTED ]] then
    pamixer -u
fi

if [[ $1 == "u" ]]; then
    pamixer -i 5
elif [[ $1 == "d" ]]; then
    pamixer -d 5
fi
