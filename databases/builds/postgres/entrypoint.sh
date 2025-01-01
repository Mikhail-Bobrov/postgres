#!/bin/bash

if [[ -z "${PGDATA}" || -z "${PATRONI_TEMPLATE_DIR}" || -z "${PATRONI_TEMPLATE_FILE}" || -z "${POD_IP}" || -z "${POD_NAMESPACE}" || -z "${POD_NAME}" ]]; then
  echo "Error: Missing required environment variables. Please set PGDATA, PATRONI_TEMPLATE_DIR, PATRONI_TEMPLATE_FILE, POD_IP, POD_NAMESPACE, and POD_NAME."
  exit 1
fi
envsubst < "${PATRONI_TEMPLATE_DIR}/${PATRONI_TEMPLATE_FILE}" > "$PGHOME/patroni.yaml"
echo "database will be installed in $PGDATA dir"
mkdir -p $PGDATA
chown postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"
echo "start patroni"
exec runuser -u postgres -- patroni "$PGHOME/patroni.yaml"