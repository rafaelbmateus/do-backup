#!/bin/bash

while true; do
  echo "Running backup..."
  backup.sh
  rotate.sh
  echo "Backup completed!"
  sleep 86400 # 24h
done
