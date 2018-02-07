#!/bin/sh

if [ -z "$CASS_HOST" ]; then
	CASS_HOST="cassandra"
fi

HOST_IP=$(getent hosts "$CASS_HOST" | cut -d ' ' -f 1)

if [ -z "$CASS_PORT" ]; then
	CASS_PORT=9042
fi

echo "Waiting for Cassandra..."
count=1
while ! nc -vz "$HOST_IP" "$CASS_PORT"  > /dev/null 2>&1; do
	count=$((count+1))
	if [ $count -eq 30 ]; then
		echo "Cassandra is still not listening, aborting"
		exit 1
	fi
	sleep 1;
done
echo "Cassandra listening"


cassandra-web --hosts "$HOST_IP" --port "$CASS_PORT" ${CASS_USERNAME:+"--username"} ${CASS_USERNAME:+"$CASS_USERNAME"} ${CASS_PASSWORD:+"--password"} ${CASS_PASSWORD:+"$CASS_PASSWORD"}
