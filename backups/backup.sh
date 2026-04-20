#!/bin/bash

BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="$BACKUP_DIR/votes-backup-$TIMESTAMP.sql"

echo "Starting backup at $TIMESTAMP"

docker exec example-voting-app-db-1 pg_dump -U postgres postgres > $BACKUP_FILE

if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_FILE"
  # Keep only last 7 backups
  ls -t $BACKUP_DIR/*.sql | tail -n +8 | xargs rm -f
  echo "Old backups cleaned up"
else
  echo "Backup FAILED"
  exit 1
fi

