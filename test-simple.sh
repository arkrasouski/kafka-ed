#!/bin/bash

ALERT_FILE="./watched-files/alert.txt"

echo "=== Minimal File Monitoring Test ==="
echo "Adding message to: $ALERT_FILE"

echo "$(date): New alert - File updated!" >> "$ALERT_FILE"

echo "Message added. Check consumer output:"
echo "docker logs file-consumer -f"