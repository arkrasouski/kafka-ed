#!/bin/bash

echo "Setting up file source connector..."

# Create the file-content topic first  
kafka-topics --create --topic file-content --bootstrap-server kafka:9092 --partitions 1 --replication-factor 1 2>/dev/null || echo "Topic already exists"


# echo "Waiting for Kafka Connect to start on localhost:8083..."
# while ! nc -z kafka-connect 8083; do   
#   sleep 2
# done
# echo "Kafka Connect is up!"

# Create the file source connector
curl -X POST http://kafka-connect:8083/connectors \
  -H "Content-Type: application/json" \
  -d @/connectors/file-source-connector.json

curl -X POST http://kafka-connect:8083/connectors \
  -H "Content-Type: application/json" \
  -d @/connectors/file-alert-sink.json

echo "File source connector created!"

# List connectors to verify
echo "Active connectors:"
curl -s http://kafka-connect:8083/connectors