#!/usr/bin/env bash
#hellcheck disable=SC2086

PAUSE="$(curl -s http://localhost:8008/patroni | jq -r .pause)"

if [[ "${PAUSE}" == "true" ]]; then
    echo "Patroni in pause mode."
    exit 1
fi

pg_isready -U postgres && echo "Postgres accepts connections" || exit 1

exit 0


