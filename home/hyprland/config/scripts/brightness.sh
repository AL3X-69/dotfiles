#!/bin/bash

CURRENT="$(brightnessctl g)"
MAX="$(brightnessctl m)"
CURRENT_P=$((CURRENT*100/MAX))

if [[ $1 == "d" ]] then
    if (( $CURRENT_P <= 10 )); then
        swayosd-client --brightness -1
    else
        swayosd-client --brightness -10
    fi
elif [[ $1 == "u" ]] then
    if (( $CURRENT_P < 10 )); then
        swayosd-client --brightness +1
    else
        swayosd-client --brightness +10
    fi
fi
