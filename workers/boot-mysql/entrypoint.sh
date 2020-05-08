#!/usr/bin/env sh

/serverAgent/startAgent.sh & > /dev/null 2>&1 
java -Dcom.sun.management.jmxremote.port=4711 -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.ssl=false -jar mosur-thesis-worker-boot-mysql-1.0.jar