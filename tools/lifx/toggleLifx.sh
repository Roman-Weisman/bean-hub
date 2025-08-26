#!/bin/bash

isKeyValid() {
  if [ -z $key ]; then
    echo -e "Error: key value is empty
  Suggestions:
  \t1. check if cat has the right path
  \t2. check if grep returns key
  \rAborting."
    exit 1
  elif [ $key = "YOUR_KEY_GOES_HERE" ]; then
    echo -e "Error: default key value wasn't changed
    Suggestions:
    \t1. change value under ~/.config/nvim/keys to yours
    \rAborting."
    exit 1
  fi
}

lifxNeonToggle() {
  key=$(cat ~/.config/nvim/keys/lifxAPIKey | grep lifxOffice | cut -d "=" -f 2)
  isKeyValid $key

  lightsPowerStatus=$(curl -H "Authorization: Bearer $key" \
    -s https://api.lifx.com/v1/lights/all | jq '.[0].power' | tr -d '"')

  # lightsPowerStatus=somethingElse
  if [ $lightsPowerStatus = on ]; then
    lightsPowerStatus=off
  elif [ $lightsPowerStatus = off ]; then
    lightsPowerStatus=on
  else
    echo -e "Error: expected on or off, but received: $lightsPowerStatus
    Suggestions:
    \t1. check power value and modify code
    \rAborting."
    exit 1
  fi

  # executes only if power is on or off
  # curl -H "Authorization: Bearer $key" \
  #   -s -o /dev/null -X PUT https://api.lifx.com/v1/lights/all/state \
  #   -d "power=$lightsPowerStatus"
  curl -s -H "Authorization: Bearer $key" \
    "https://api.lifx.com/v1/lights/all" |
    # jq -r '.[] | "ID: \(.id), Label: \(.label), Connected: \(.connected)"'
    jq '.[] | {group: .group.name, label: .label,
    id: .id, power: .power}'
}

lifxNeonToggle
