#!/bin/bash

source slack.sh

BACKUP_NAME="backup_$(date +'%Y%m%d%H%M%S').tar.gz"
BACKUP_DIR="/backup"

tar -czf $BACKUP_NAME ${BACKUP_DIR}

if s3cmd put $TMP_DIR/$BACKUP_NAME ${DO_SPACE}/${DO_FOLDER}/; then
  send_slack_notification "Backup completed successfully: $BACKUP_NAME"
else
  send_slack_notification "Error during backup: $BACKUP_NAME"
fi

rm -f $BACKUP_NAME

source delete.sh
