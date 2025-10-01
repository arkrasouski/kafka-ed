#!/bin/bash
# # Этот скрипт выполняется под правильным пользователем postgres при первом старте контейнера

# # Настройка WAL для Debezium
# echo "wal_level=logical" >> "$PGDATA/postgresql.conf"
# echo "max_wal_senders=10" >> "$PGDATA/postgresql.conf"
# echo "max_replication_slots=10" >> "$PGDATA/postgresql.conf"

# # Разрешаем репликацию для пользователя debezium
# echo "host replication debezium 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"