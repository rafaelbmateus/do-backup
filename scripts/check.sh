#!/bin/bash

source slack.sh

OUTPUT=$(s3cmd ls ${DO_SPACE} 2>&1)

if [[ $? -eq 0 ]]; then
  echo "Successfully connected to the DigitalOcean Space: $DO_SPACE"
  send_slack_notification "Successfully connected to the DigitalOcean Space: $DO_SPACE"
  exit 0
else
  echo "Failed to connect to the DigitalOcean Space: $DO_SPACE"
  echo "Error: $OUTPUT"
  exit 1
fi
