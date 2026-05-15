#!/bin/bash
while true; do
    PLAYERS=$(playerctl status -a -f "{{playerName}}:{{status}}")
    PLAYER=
    PLAYER_ARG=
    PLAYING=0

    # Find first playing player
    while IFS= read -r LINE; do
        IFS=: read -ra PARTS <<< "$LINE";
        if [[ "${PARTS[1]}" == "Playing" ]]; then
            PLAYER="${PARTS[0]}"
            PLAYER_ARG="-p $PLAYER"
            PLAYING=1
            break
        fi
    done <<< "$PLAYERS"

    TEXT="$(playerctl metadata $PLAYER_ARG -f '{{artist}} - {{title}}')"
    TEXT_LONG="$(playerctl metadata $PLAYER_ARG -f '{{artist}} - {{title}} - {{album}} - {{duration(position)}}')"

    jq -n --unbuffered --compact-output \
        --arg text "$TEXT" \
        --arg text_long "$TEXT_LONG" \
        --arg player "$PLAYER" \
        --arg playing "$PLAYING" \
        '{
            text: $text,
            alt: $player,
            percentage: $playing,
            tooltip: $text_long,
            class: "media"
        }'
    sleep 1
done
