#!/bin/bash

# O sleep vai para segundo plano de propósito: em foreground ele bloqueia o
# processamento de sinais, então o SIGTERM do `docker stop` só seria tratado
# 24h depois e o container acabava morrendo no SIGKILL do timeout — 10s de
# espera em cada parada. Com `wait`, o sinal chega na hora.

sleep_pid=""

term_handler() {
  echo "Recebido SIGTERM, encerrando..."
  [ -n "$sleep_pid" ] && kill "$sleep_pid" 2>/dev/null
  exit 0
}

trap term_handler SIGTERM SIGINT

while true; do
  echo "Running backup..."
  backup.sh
  rotate.sh
  echo "Backup completed!"

  sleep 86400 & # 24h
  sleep_pid=$!
  wait "$sleep_pid"
done
