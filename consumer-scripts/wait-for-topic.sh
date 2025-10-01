#!/bin/bash

BOOTSTRAP="kafka1:9092,kafka2:9092,kafka3:9092"
TOPIC="data.cdc.artyom"

# until kafka-topics --bootstrap-server $BOOTSTRAP --describe --topic $TOPIC &>/dev/null; do
#   echo "Topic $TOPIC not ready, waiting for leader..."
#   sleep 5
# done

echo "Topic $TOPIC ready!"