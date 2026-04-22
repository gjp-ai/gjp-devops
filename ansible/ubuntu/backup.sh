#!/bin/bash

# Main backup script to trigger both MySQL database and Upload folder backups
# Usage: ./backup.sh

echo "---------------------------------------------------"
echo "Starting Full Backup Sequence..."
echo "---------------------------------------------------"

# 1. Backup MySQL Database
echo "[Step 1/2] Backing up MySQL Database..."
./backup_mysql_db.sh

if [ $? -eq 0 ]; then
    echo "✔ MySQL Backup completed successfully."
else
    echo "✘ MySQL Backup failed!"
    exit 1
fi

echo "---------------------------------------------------"

# 2. Backup Upload Folders
echo "[Step 2/2] Backing up Upload Folders..."
./backup_upload_folder.sh

if [ $? -eq 0 ]; then
    echo "✔ Upload Folder Backup completed successfully."
else
    echo "✘ Upload Folder Backup failed!"
    exit 1
fi

echo "---------------------------------------------------"
echo "Full Backup Sequence Finished Successfully!"
echo "---------------------------------------------------"
