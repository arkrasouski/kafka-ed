#!/bin/bash

echo "Setting up file source connector..."

# Create the file-content topic first  
#kafka-topics --create --topic file-content --bootstrap-server kafka:9092 --partitions 1 --replication-factor 1 2>/dev/null || echo "Topic already exists"
# kafka-topics --bootstrap-server kafka1:9092 --create --topic connector-config --partitions 1 --replication-factor 3 --config cleanup.policy=compact 2>/dev/null || echo "Topic already exists"
# kafka-topics --bootstrap-server kafka1:9092 --create --topic connector-offsets --partitions 1 --replication-factor 3 --config cleanup.policy=compact 2>/dev/null || echo "Topic already exists"
# kafka-topics --bootstrap-server kafka1:9092 --create --topic connector-status --partitions 1 --replication-factor 3 --config cleanup.policy=compact 2>/dev/null || echo "Topic already exists"
kafka-topics --bootstrap-server kafka1:9092 --list
# echo "Waiting for Kafka Connect to start on localhost:8083..."
# while ! nc -z kafka-connect 8083; do   
#   sleep 2
# done
# echo "Kafka Connect is up!"
kafka-topics --bootstrap-server kafka1:9092  --create --topic data.cdc.kafka.test_cdc --partitions 1 --replication-factor 3  || echo "Topic already exists"
# Create the file source connector

#Files block

# curl -X POST http://kafka-connect:8083/connectors \
#   -H "Content-Type: application/json" \
#   -d @/connectors/file-source-connector.json

# curl -X POST http://kafka-connect:8083/connectors \
#   -H "Content-Type: application/json" \
#   -d @/connectors/file-alert-sink.json

curl -i -X POST http://kafka-connect:8083/connectors/ \
  -H  "Content-Type:application/json" \
  -d @/connectors/pg-con.json

echo "File source connector created!"

curl -i -X POST http://kafka-connect:8083/connectors \
    -H "Content-Type: application/json" \
    -d @/connectors/jdbc-pg-connector.json \
     

echo "DWH connector created!"

# List connectors to verify
echo "Active connectors:"
curl -s http://kafka-connect:8083/connectors








# kafka-console-consumer \
#   --bootstrap-server localhost:9092 \
#   --topic data.cdc.kafka.test_cdc \
#   --from-beginning \
#   --max-messages 1 \
#   --property print.key=false