#!/bin/sh

if [ -z "$CASS_HOST" ]; then
	CASS_HOST="cassandra"
fi

HOST_IP=$(getent hosts "$CASS_HOST" | cut -d ' ' -f 1)

if [ -z "$CASS_PORT" ]; then
	CASS_PORT=9042
fi

cassandra-web --hosts "$HOST_IP" --port "$CASS_PORT" ${CASS_USERNAME:+"--username"} ${CASS_USERNAME:+"$CASS_USERNAME"} ${CASS_PASSWORD:+"--password"} ${CASS_PASSWORD:+"$CASS_PASSWORD"}
