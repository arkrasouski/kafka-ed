#!/bin/bash

# BOOTSTRAP="kafka1:9092,kafka2:9092,kafka3:9092"
# TOPIC="data.cdc.testdb"

# kafka-console-consumer \
#   --bootstrap-server $BOOTSTRAP \
#   --topic $TOPIC \
#   --from-beginning \
#   --property print.key=true


CONNECTOR_NAME="pg-connector"
TOPIC="data.cdc.kafka.test_cdc"
BROKERS="kafka1:9092,kafka2:9092,kafka3:9092"

# Ждём пока коннектор RUNNING
while true; do
  STATUS=$(curl -s http://kafka-connect:8083/connectors/$CONNECTOR_NAME/status | grep -o '"state":"[^"]*"' | head -1 | cut -d'"' -f4)
  if [ "$STATUS" = "RUNNING" ]; then
    echo "Connector $CONNECTOR_NAME is RUNNING"
    break
  fi
  echo "Waiting for connector $CONNECTOR_NAME to be RUNNING..."
  sleep 5
done

# Ждём пока топик создан
while ! kafka-topics --bootstrap-server $BROKERS --list | grep -q "$TOPIC"; do
  echo "Waiting for topic $TOPIC to exist..."
  sleep 5
done
echo "Ready to read!"
# Запуск consumer
kafka-console-consumer --bootstrap-server $BROKERS --topic $TOPIC --property print.key=true --from-beginning