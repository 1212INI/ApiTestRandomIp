API Gateway Private IP Tester
=============================

Este script (`api_test_random_ips.sh`) está diseñado para probar el acceso directo a un endpoint privado de Amazon API Gateway, forzando la conexión a través de IPs internas específicas, en lugar de utilizar el VPC Endpoint (VPCE).

Objetivo
--------
Validar la disponibilidad de la API y el comportamiento del backend cuando se accede directamente a ciertas IPs privadas, sin depender del DNS del VPCE.

Requisitos
----------
- bash
- curl
- Conectividad a las IPs privadas listadas
- API Key válida configurada en API Gateway

Configuración
-------------
Asegúrate de editar y revisar estos valores dentro del script:

API_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
TOTAL=200  # Número total de peticiones

Lista de IPs privadas a las que se enviarán las peticiones aleatorias:

IPS=(
  "192.XXX.XXX.XXX"
  "192.XXX.XXX.XXX"
  "192.XXX.XXX.XXX"
)

⚠️ Reemplaza las IPs por las direcciones reales que correspondan a tus backends o balanceadores internos.

Funcionamiento
--------------
- En cada iteración, se selecciona una IP al azar del arreglo IPS.
- Se ejecuta una petición `curl` usando el parámetro `--resolve` para forzar la conexión HTTPS a esa IP, manteniendo el Hostname original.
- Se imprime:
  - Código HTTP de la respuesta
  - IP del servidor que respondió
  - Tiempo total de respuesta

Uso
---
1. Dar permisos de ejecución:

   chmod +x api_test_random_ips.sh

2. Ejecutar:

   ./api_test_random_ips.sh

Ejemplo de salida:
------------------
[15:04:22] Petición 7 de 200 – Usando IP: 192.168.10.45
✅ Éxito (200) – IP destino: 192.168.10.45 – 0.029s

Notas
-----
- Este script es útil para validar balanceo, fallos parciales o latencias entre múltiples instancias backend.
- Asegúrate de que tu entorno tiene rutas válidas y seguridad configurada (SG/NACL) para llegar a cada IP.
- Si una IP responde con 403, puede ser problema de configuración en API Gateway, IAM, o validación de API Key.

