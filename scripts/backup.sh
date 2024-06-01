#!/bin/bash

source slack.sh

BACKUP="/backup"
BACKUP_NAME="$(date +'%Y%m%d%H%M%S').tar.gz"

tar -czf $BACKUP_NAME $BACKUP_DIR

if s3cmd put $BACKUP_NAME ${DO_SPACE}/${DO_FOLDER}/; then
  send_slack_notification "Backup completed successfully: $BACKUP_NAME"
else
  send_slack_notification "Error during backup: $BACKUP_NAME"
fi

rm -f $BACKUP_NAME
