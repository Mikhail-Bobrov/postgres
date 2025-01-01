#!/bin/bash

pg_isready -h ${POD_IP} -U postgres

if [[ $? -eq 0 ]]; then
  echo "PostgreSQL is ready."
else
  echo "PostgreSQL is not ready."
  exit 1
fi
