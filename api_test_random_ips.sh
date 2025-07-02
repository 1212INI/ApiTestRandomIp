#!/bin/bash

# Configuración
URL_PATH=""
HOST=""
API_KEY=""
TOTAL=200

# Lista de IPs a usar aleatoriamente
IPS=(
  "192.XXX.XXX.XXX"
  "192.XXX.XXX.XXX"
  "192.XXX.XXX.XXX"
)

echo "Iniciando prueba de $TOTAL peticiones a la API (con IP forzada aleatoria)..."

for i in $(seq 1 $TOTAL); do
  # Seleccionar IP aleatoria
  SELECTED_IP=${IPS[$RANDOM % ${#IPS[@]}]}
  echo "[$(date '+%H:%M:%S')] Petición $i de $TOTAL – Usando IP: $SELECTED_IP"

  output=$(curl -s -w "IP:%{remote_ip} CODE:%{http_code} TIME:%{time_total}" \
    --resolve "$HOST:443:$SELECTED_IP" \
    -H "x-api-key: $API_KEY" \
    "https://$HOST$URL_PATH" \
    -o /dev/null)

  ip=$(echo "$output" | sed -n 's/.*IP:\([^ ]*\).*/\1/p')
  code=$(echo "$output" | sed -n 's/.*CODE:\([0-9]*\).*/\1/p')
  time=$(echo "$output" | sed -n 's/.*TIME:\([0-9.]*\).*/\1/p')

  if [[ "$code" == "200" ]]; then
    echo "✅ Éxito ($code) – IP destino: $ip – ${time}s"
  else
    echo "❌ Falla ($code) – IP destino: $ip – ${time}s"
  fi

  sleep 0.1
done
