#!/bin/bash

source slack.sh

BACKUPS_TO_KEEP=10

ALL_BACKUPS=$(s3cmd ls ${DO_SPACE}/${DO_FOLDER}/ | sort | awk '{print $4}')
BACKUP_COUNT=$(echo "$ALL_BACKUPS" | wc -l)
BACKUPS_TO_DELETE=$((BACKUP_COUNT - BACKUPS_TO_KEEP))
echo "Rotate backup..."
echo "Backup count $BACKUP_COUNT to delete $BACKUPS_TO_DELETE"
if [ $BACKUPS_TO_DELETE -gt 0 ]; then
  BACKUPS_TO_REMOVE=$(echo "$ALL_BACKUPS" | head -n $BACKUPS_TO_DELETE)
  for BACKUP in $BACKUPS_TO_REMOVE; do
    if s3cmd del $BACKUP; then
      send_slack_notification "[$DO_FOLDER] Backup deleted: $BACKUP"
    else
      send_slack_notification "[$DO_FOLDER] Error to delete backup: $BACKUP"
    fi
  done
fi
