#!/bin/bash

function send_slack_notification() {
  local message="$1"
  local webhook_url=${SLACK_WEBHOOK_URL}

  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "$webhook_url"
}
