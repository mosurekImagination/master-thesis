#!/usr/bin/env sh

/serverAgent/startAgent.sh & > /dev/null 2>&1 
java -jar mosur-thesis-worker-webflux-mongodb-1.0.jar