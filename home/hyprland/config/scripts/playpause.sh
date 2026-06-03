#!/bin/bash

players=()
while IFS= read -r line; do
  players+=("$line")
done < <(playerctl -l)


for p in "${players[@]}"; do
  echo ">&p<"
done

