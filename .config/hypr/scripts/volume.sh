#!/bin/bash

MUTED="$(pamixer --get-mute)"

if [[ $MUTED == "true" ]]; then
    swayosd-client --output-volume mute-toggle
fi

if [[ $1 == "u" ]]; then
    swayosd-client --output-volume raise
elif [[ $1 == "d" ]]; then
    swayosd-client --output-volume lower
fi
